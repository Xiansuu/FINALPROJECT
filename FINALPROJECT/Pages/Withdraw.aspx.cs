using System;
using System.Data.SqlClient;

namespace FINALPROJECT
{
    public partial class Withdraw : System.Web.UI.Page
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
        }

        private void LoadBalance()
        {
            int userID = Convert.ToInt32(Session["UserID"]);

            using (SqlConnection conn = DbHelper.GetConnection())
            {
                conn.Open();
                string sql = "SELECT CurrentBalance FROM Users WHERE UserID = @UserID";
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", userID);
                    object result = cmd.ExecuteScalar();
                    if (result != null)
                        lblCurrentBalance.Text = "₱" + Convert.ToDecimal(result).ToString("N2");
                }
            }
        }

        protected void btnWithdraw_Click(object sender, EventArgs e)
        {
            lblError.Text = "";
            lblSuccess.Text = "";

            int userID = Convert.ToInt32(Session["UserID"]);
            decimal amount;

            if (!decimal.TryParse(txtAmount.Text.Trim(), out amount))
            { lblError.Text = "Please enter a valid amount."; return; }

            if (amount < 100 || amount > 2000)
            { lblError.Text = "Withdrawal amount must be between ₱100.00 and ₱2,000.00."; return; }

            if (amount % 100 != 0)
            { lblError.Text = "Amount must be divisible by ₱100.00."; return; }

            using (SqlConnection conn = DbHelper.GetConnection())
            {
                conn.Open();
                SqlTransaction txn = conn.BeginTransaction();

                try
                {
                    string dailyLimitSql = @"
                        SELECT ISNULL(SUM(Amount), 0)
                        FROM   Transactions
                        WHERE  SenderUserID    = @UserID
                          AND  TransactionType = 'Withdrawal'
                          AND  CAST(TransactionDate AS DATE) = CAST(GETDATE() AS DATE)";

                    using (SqlCommand cmd = new SqlCommand(dailyLimitSql, conn, txn))
                    {
                        cmd.Parameters.AddWithValue("@UserID", userID);
                        decimal totalToday = Convert.ToDecimal(cmd.ExecuteScalar());

                        if (totalToday + amount > 10000)
                        {
                            decimal remaining = 10000 - totalToday;
                            lblError.Text = remaining <= 0
                                ? "You have reached your ₱10,000.00 daily withdrawal limit."
                                : "Daily limit exceeded. You can only withdraw ₱" +
                                  remaining.ToString("N2") + " more today.";
                            txn.Rollback();
                            return;
                        }
                    }

                    decimal currentBalance;
                    string balanceSql = @"
                        SELECT CurrentBalance FROM Users WITH (UPDLOCK)
                        WHERE  UserID = @UserID";

                    using (SqlCommand cmd = new SqlCommand(balanceSql, conn, txn))
                    {
                        cmd.Parameters.AddWithValue("@UserID", userID);
                        object result = cmd.ExecuteScalar();
                        if (result == null)
                        {
                            lblError.Text = "User not found.";
                            txn.Rollback();
                            return;
                        }
                        currentBalance = Convert.ToDecimal(result);
                    }

                    if (amount > currentBalance)
                    {
                        lblError.Text = "Insufficient funds. Your current balance is ₱" +
                                        currentBalance.ToString("N2") + ".";
                        txn.Rollback();
                        LoadBalance();
                        return;
                    }

                    decimal newBalance = currentBalance - amount;

                    string updateSql = @"
                        UPDATE Users SET CurrentBalance = @NewBalance
                        WHERE  UserID = @UserID";

                    using (SqlCommand cmd = new SqlCommand(updateSql, conn, txn))
                    {
                        cmd.Parameters.AddWithValue("@NewBalance", newBalance);
                        cmd.Parameters.AddWithValue("@UserID", userID);
                        cmd.ExecuteNonQuery();
                    }

                    string insertSql = @"
                        INSERT INTO Transactions
                            (SenderUserID, ReceiverUserID, TransactionType,
                             Amount, SenderBalanceAfter, ReceiverBalanceAfter,
                             Remarks, TransactionDate)
                        VALUES
                            (@SenderID, NULL, 'Withdrawal',
                             @Amount, @BalanceAfter, NULL,
                             'Cash Withdrawal', GETDATE())";

                    using (SqlCommand cmd = new SqlCommand(insertSql, conn, txn))
                    {
                        cmd.Parameters.AddWithValue("@SenderID", userID);
                        cmd.Parameters.AddWithValue("@Amount", amount);
                        cmd.Parameters.AddWithValue("@BalanceAfter", newBalance);
                        cmd.ExecuteNonQuery();
                    }

                    txn.Commit();

                    lblSuccess.Text = "Withdrawal of ₱" + amount.ToString("N2") +
                                      " successful! New balance: ₱" + newBalance.ToString("N2");
                    txtAmount.Text = "";
                    LoadBalance();
                }
                catch (Exception ex)
                {
                    txn.Rollback();
                    lblError.Text = "Transaction failed: " + ex.Message;
                }
            }
        }
    }
}