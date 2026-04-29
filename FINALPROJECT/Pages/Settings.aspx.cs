using System;
using System.Data.SqlClient;

namespace FINALPROJECT
{
    public partial class Settings : System.Web.UI.Page
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
                LoadInfo();
            }
        }

        private void LoadInfo()
        {
            int userID = Convert.ToInt32(Session["UserID"]);

            using (SqlConnection conn = DbHelper.GetConnection())
            {
                conn.Open();

                string sql = @"
                    SELECT AccountNumber,
                           LastName + ', ' + FirstName AS FullName,
                           Email,
                           DateRegistered,
                           CurrentBalance,
                           ISNULL((SELECT SUM(t.Amount)
                                   FROM   Transactions t
                                   WHERE  t.SenderUserID    = u.UserID
                                     AND  t.TransactionType = 'Send'), 0) AS TotalSent
                    FROM   Users u
                    WHERE  UserID = @UserID";

                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", userID);

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            lblNavName.Text = dr["FullName"].ToString();
                            lblAccountNumber.Text = dr["AccountNumber"].ToString();
                            lblFullName.Text = dr["FullName"].ToString();
                            lblEmail.Text = dr["Email"].ToString();
                            lblDateRegistered.Text = Convert.ToDateTime(dr["DateRegistered"])
                                                        .ToString("MMMM dd, yyyy");
                            lblCurrentBalance.Text = "₱" + Convert.ToDecimal(dr["CurrentBalance"])
                                                        .ToString("N2");
                            lblTotalSent.Text = "₱" + Convert.ToDecimal(dr["TotalSent"])
                                                        .ToString("N2");
                        }
                    }
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            lblError.Text = "";
            lblSuccess.Text = "";

            int userID = Convert.ToInt32(Session["UserID"]);
            string currentPw = txtCurrentPassword.Text.Trim();
            string newPw = txtNewPassword.Text.Trim();

            if (newPw.Length < 8)
            {
                lblError.Text = "New password must be at least 8 characters.";
                return;
            }

            using (SqlConnection conn = DbHelper.GetConnection())
            {
                conn.Open();

                string verifySQL = @"
                    SELECT COUNT(*) FROM Users
                    WHERE  UserID       = @UserID
                      AND  PasswordHash = @Hash";

                using (SqlCommand cmd = new SqlCommand(verifySQL, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", userID);
                    cmd.Parameters.AddWithValue("@Hash", HashPassword(currentPw));
                    if ((int)cmd.ExecuteScalar() == 0)
                    {
                        lblError.Text = "Current password is incorrect.";
                        return;
                    }
                }

                if (HashPassword(newPw) == HashPassword(currentPw))
                {
                    lblError.Text = "New password must be different from current password.";
                    return;
                }

                string updateSQL = @"
                    UPDATE Users SET PasswordHash = @Hash
                    WHERE  UserID = @UserID";

                using (SqlCommand cmd = new SqlCommand(updateSQL, conn))
                {
                    cmd.Parameters.AddWithValue("@Hash", HashPassword(newPw));
                    cmd.Parameters.AddWithValue("@UserID", userID);
                    cmd.ExecuteNonQuery();
                }

                Session.Clear();
                Session.Abandon();
                Response.Redirect("Login.aspx?passwordChanged=1");
            }
        }

        private string HashPassword(string plainText)
        {
            using (System.Security.Cryptography.SHA256 sha =
                   System.Security.Cryptography.SHA256.Create())
            {
                byte[] bytes = sha.ComputeHash(System.Text.Encoding.UTF8.GetBytes(plainText));
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                foreach (byte b in bytes)
                    sb.Append(b.ToString("x2"));
                return sb.ToString();
            }
        }
    }
}