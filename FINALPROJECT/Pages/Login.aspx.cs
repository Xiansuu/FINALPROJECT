using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace FINALPROJECT
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] != null)
                Response.Redirect("Dashboard.aspx");

            if (!IsPostBack)
            {
                if (Request.QueryString["registered"] == "1")
                    lblSuccess.Text = "Registration successful! You can now sign in.";
                if (Request.QueryString["passwordChanged"] == "1")
                    lblSuccess.Text = "Password changed successfully. Please sign in again.";
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            lblAccountError.Text = "";
            lblPasswordError.Text = "";

            string accountNumber = txtAccountNumber.Text.Trim();
            string password = txtPassword.Text.Trim();

            using (SqlConnection conn = DbHelper.GetConnection())
            {
                conn.Open();

                // Step 1: Check if account number exists
                string checkAccountSql = @"
                    SELECT COUNT(*)
                    FROM   Users
                    WHERE  AccountNumber = @AccountNumber
                      AND  IsActive = 1";

                using (SqlCommand cmd = new SqlCommand(checkAccountSql, conn))
                {
                    cmd.Parameters.AddWithValue("@AccountNumber", accountNumber);
                    int accountExists = (int)cmd.ExecuteScalar();

                    if (accountExists == 0)
                    {
                        lblAccountError.Text = "⚠ Account number not found.";
                        return;
                    }
                }

                // Step 2: Check if password is correct
                string hashedPassword = HashPassword(password);

                string checkPasswordSql = @"
                    SELECT COUNT(*)
                    FROM   Users
                    WHERE  AccountNumber = @AccountNumber
                      AND  PasswordHash  = @PasswordHash
                      AND  IsActive      = 1";

                using (SqlCommand cmd = new SqlCommand(checkPasswordSql, conn))
                {
                    cmd.Parameters.AddWithValue("@AccountNumber", accountNumber);
                    cmd.Parameters.AddWithValue("@PasswordHash", hashedPassword);
                    int passwordMatch = (int)cmd.ExecuteScalar();

                    if (passwordMatch == 0)
                    {
                        lblPasswordError.Text = "⚠ Incorrect password.";
                        return;
                    }
                }

                // Step 3: Load user session
                string getUserSql = @"
                    SELECT UserID,
                           LastName + ', ' + FirstName AS FullName,
                           AccountNumber
                    FROM   Users
                    WHERE  AccountNumber = @AccountNumber
                      AND  IsActive      = 1";

                using (SqlCommand cmd = new SqlCommand(getUserSql, conn))
                {
                    cmd.Parameters.AddWithValue("@AccountNumber", accountNumber);

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            Session["UserID"] = dr["UserID"].ToString();
                            Session["FullName"] = dr["FullName"].ToString();
                            Session["AccountNumber"] = dr["AccountNumber"].ToString();
                            Response.Redirect("Dashboard.aspx");
                        }
                    }
                }
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