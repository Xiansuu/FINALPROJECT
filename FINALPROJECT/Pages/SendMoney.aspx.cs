using System;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;

namespace FINALPROJECT
{
    public partial class SendMoney : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                lblError.Text = "";
                lblSuccess.Text = "";
                LoadBalance();
            }
            else
            {
                if (ViewState["RecipientID"] != null)
                {
                    btnSend.Enabled = true;
                    txtAmount.Enabled = true;
                    txtPassword.Enabled = true;
                    rfvAmount.Enabled = true;
                    rvAmount.Enabled = true;
                    rfvPassword.Enabled = true;
                }
            }
        }

        private void LoadBalance()
        {
            int userID = Convert.ToInt32(Session["UserID"]);

            using (SqlConnection conn = DbHelper.GetConnection())
            {
                conn.Open();
                string sql = @"
                    SELECT CurrentBalance,
                           LastName + ', ' + FirstName AS FullName,
                           AccountNumber
                    FROM   Users
                    WHERE  UserID = @UserID";

                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", userID);
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            lblCurrentBalance.Text = "₱" + Convert.ToDecimal(dr["CurrentBalance"]).ToString("N2");
                            lblSenderName.Text = dr["FullName"].ToString();
                            lblSenderAccountNumber.Text = dr["AccountNumber"].ToString();
                        }
                    }
                }
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            lblError.Text = "";
            lblSuccess.Text = "";
            lblRecipientName.Text = "";
            btnSend.Enabled = false;
            txtAmount.Enabled = false;
            txtPassword.Enabled = false;
            rfvAmount.Enabled = false;
            rvAmount.Enabled = false;
            rfvPassword.Enabled = false;
            ViewState["RecipientID"] = null;
            ViewState["RecipientName"] = null;

            string accountNumber = txtAccountNumber.Text.Trim();
            int userID = Convert.ToInt32(Session["UserID"]);

            if (string.IsNullOrEmpty(accountNumber))
            {
                lblError.Text = "Please enter an account number.";
                return;
            }

            using (SqlConnection conn = DbHelper.GetConnection())
            {
                conn.Open();

                string sql = @"
                    SELECT UserID, AccountNumber, LastName, FirstName
                    FROM   Users
                    WHERE  AccountNumber = @AccountNumber
                      AND  IsActive = 1";

                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@AccountNumber", accountNumber);

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            int recipientID = Convert.ToInt32(dr["UserID"]);

                            if (recipientID == userID)
                            {
                                lblError.Text = "You cannot send money to your own account.";
                                return;
                            }

                            string recipientName = dr["LastName"].ToString() + ", " +
                                                   dr["FirstName"].ToString();

                            ViewState["RecipientID"] = recipientID;
                            ViewState["RecipientName"] = recipientName;

                            lblRecipientName.Text = "Account No.: " + dr["AccountNumber"].ToString() +
                                                    " | Name: " + recipientName;

                            btnSend.Enabled = true;
                            txtAmount.Enabled = true;
                            txtPassword.Enabled = true;
                            rfvAmount.Enabled = true;
                            rvAmount.Enabled = true;
                            rfvPassword.Enabled = true;
                        }
                        else
                        {
                            lblError.Text = "Account not found.";
                        }
                    }
                }
            }
        }

        protected void btnSend_Click(object sender, EventArgs e)
        {
            lblError.Text = "";
            lblSuccess.Text = "";

            if (ViewState["RecipientID"] == null)
            {
                lblError.Text = "Please search for a recipient first.";
                return;
            }

            int senderID = Convert.ToInt32(Session["UserID"]);
            int recipientID = Convert.ToInt32(ViewState["RecipientID"]);
            decimal amount;

            if (!decimal.TryParse(txtAmount.Text.Trim(), out amount))
            {
                lblError.Text = "Please enter a valid amount.";
                return;
            }

            if (amount < 100 || amount > 2000)
            {
                lblError.Text = "Amount must be between ₱100.00 and ₱2,000.00.";
                return;
            }

            if (amount % 100 != 0)
            {
                lblError.Text = "Amount must be divisible by ₱100.00.";
                return;
            }

            string enteredPassword = HashPassword(txtPassword.Text);

            using (SqlConnection conn = DbHelper.GetConnection())
            {
                conn.Open();

                // 1. Verify password
                string checkPassSql = @"
                    SELECT COUNT(*) FROM Users
                    WHERE  UserID       = @UserID
                      AND  PasswordHash = @PasswordHash";

                using (SqlCommand cmd = new SqlCommand(checkPassSql, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", senderID);
                    cmd.Parameters.AddWithValue("@PasswordHash", enteredPassword);
                    if ((int)cmd.ExecuteScalar() == 0)
                    {
                        lblError.Text = "Incorrect password. Transaction cancelled.";
                        return;
                    }
                }

                // 2. Check daily limit
                string dailyLimitSql = @"
                    SELECT ISNULL(SUM(Amount), 0)
                    FROM   Transactions
                    WHERE  SenderUserID = @UserID
                      AND  CAST(TransactionDate AS DATE) = CAST(GETDATE() AS DATE)";

                using (SqlCommand cmd = new SqlCommand(dailyLimitSql, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", senderID);
                    decimal totalToday = Convert.ToDecimal(cmd.ExecuteScalar());

                    if (totalToday + amount > 10000)
                    {
                        decimal remaining = 10000 - totalToday;
                        lblError.Text = remaining <= 0
                            ? "You have reached your ₱10,000.00 daily transaction limit."
                            : "Daily limit exceeded. You can only send ₱" +
                              remaining.ToString("N2") + " more today.";
                        return;
                    }
                }

                // 3. Begin transaction
                SqlTransaction txn = conn.BeginTransaction(System.Data.IsolationLevel.Serializable);

                try
                {
                    string balanceSql = @"
                        SELECT CurrentBalance FROM Users WITH (UPDLOCK)
                        WHERE  UserID = @UserID";

                    decimal senderBalance;
                    using (SqlCommand cmd = new SqlCommand(balanceSql, conn, txn))
                    {
                        cmd.Parameters.AddWithValue("@UserID", senderID);
                        senderBalance = Convert.ToDecimal(cmd.ExecuteScalar());
                    }

                    if (amount > senderBalance)
                    {
                        lblError.Text = "Insufficient funds. Your balance is ₱" +
                                        senderBalance.ToString("N2") + ".";
                        txn.Rollback();
                        return;
                    }

                    decimal recipientBalance;
                    using (SqlCommand cmd = new SqlCommand(balanceSql, conn, txn))
                    {
                        cmd.Parameters.AddWithValue("@UserID", recipientID);
                        recipientBalance = Convert.ToDecimal(cmd.ExecuteScalar());
                    }

                    if (recipientBalance + amount > 10000)
                    {
                        lblError.Text = "Recipient's balance would exceed the ₱10,000.00 maximum.";
                        txn.Rollback();
                        return;
                    }

                    decimal newSenderBalance = senderBalance - amount;
                    decimal newRecipientBalance = recipientBalance + amount;

                    string updateSql = @"
                        UPDATE Users SET CurrentBalance = @NewBalance
                        WHERE  UserID = @UserID";

                    using (SqlCommand cmd = new SqlCommand(updateSql, conn, txn))
                    {
                        cmd.Parameters.AddWithValue("@NewBalance", newSenderBalance);
                        cmd.Parameters.AddWithValue("@UserID", senderID);
                        cmd.ExecuteNonQuery();
                    }

                    using (SqlCommand cmd = new SqlCommand(updateSql, conn, txn))
                    {
                        cmd.Parameters.AddWithValue("@NewBalance", newRecipientBalance);
                        cmd.Parameters.AddWithValue("@UserID", recipientID);
                        cmd.ExecuteNonQuery();
                    }

                    string insertSql = @"
                        INSERT INTO Transactions
                            (SenderUserID, ReceiverUserID, TransactionType,
                             Amount, SenderBalanceAfter, ReceiverBalanceAfter,
                             Remarks, TransactionDate)
                        VALUES
                            (@SenderID, @ReceiverID, @Type,
                             @Amount, @SenderBalance, @ReceiverBalance,
                             @Remarks, GETDATE())";

                    // Send row
                    using (SqlCommand cmd = new SqlCommand(insertSql, conn, txn))
                    {
                        cmd.Parameters.AddWithValue("@SenderID", senderID);
                        cmd.Parameters.AddWithValue("@ReceiverID", recipientID);
                        cmd.Parameters.AddWithValue("@Type", "Send");
                        cmd.Parameters.AddWithValue("@Amount", amount);
                        cmd.Parameters.AddWithValue("@SenderBalance", newSenderBalance);
                        cmd.Parameters.AddWithValue("@ReceiverBalance", newRecipientBalance);
                        cmd.Parameters.AddWithValue("@Remarks", "Sent to " + ViewState["RecipientName"].ToString());
                        cmd.ExecuteNonQuery();
                    }

                    // Receive row
                    using (SqlCommand cmd = new SqlCommand(insertSql, conn, txn))
                    {
                        cmd.Parameters.AddWithValue("@SenderID", senderID);
                        cmd.Parameters.AddWithValue("@ReceiverID", recipientID);
                        cmd.Parameters.AddWithValue("@Type", "Receive");
                        cmd.Parameters.AddWithValue("@Amount", amount);
                        cmd.Parameters.AddWithValue("@SenderBalance", newSenderBalance);
                        cmd.Parameters.AddWithValue("@ReceiverBalance", newRecipientBalance);
                        cmd.Parameters.AddWithValue("@Remarks", "Received from " + Session["FullName"].ToString());
                        cmd.ExecuteNonQuery();
                    }

                    txn.Commit();

                    lblSuccess.Text = "Successfully sent ₱" + amount.ToString("N2") +
                                              " to " + ViewState["RecipientName"].ToString() + "!";
                    txtAmount.Text = "";
                    txtPassword.Text = "";
                    txtAccountNumber.Text = "";
                    lblRecipientName.Text = "";
                    btnSend.Enabled = false;
                    txtAmount.Enabled = false;
                    txtPassword.Enabled = false;
                    ViewState["RecipientID"] = null;
                    ViewState["RecipientName"] = null;
                    LoadBalance();
                }
                catch (Exception ex)
                {
                    txn.Rollback();
                    lblError.Text = "Transaction failed: " + ex.Message;
                }
            }
        }

        private string HashPassword(string plainText)
        {
            using (SHA256 sha = SHA256.Create())
            {
                byte[] bytes = sha.ComputeHash(Encoding.UTF8.GetBytes(plainText));
                StringBuilder sb = new StringBuilder();
                foreach (byte b in bytes)
                    sb.Append(b.ToString("x2"));
                return sb.ToString();
            }
        }
    }
}