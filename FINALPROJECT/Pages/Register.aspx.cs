using System;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;

namespace FINALPROJECT
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblError.Text = "";
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string lastName = txtLastName.Text.Trim();
            string firstName = txtFirstName.Text.Trim();
            string email = txtEmail.Text.Trim().ToLower();
            string password = txtPassword.Text;
            string confirm = txtConfirmPassword.Text;

            if (password != confirm)
            {
                lblError.Text = "Passwords do not match.";
                return;
            }

            if (password.Length < 8)
            {
                lblError.Text = "Password must be at least 8 characters.";
                return;
            }

            string hashedPassword = HashPassword(password);
            string accountNumber = GenerateAccountNumber();

            using (SqlConnection conn = DbHelper.GetConnection())
            {
                conn.Open();

                string checkSql = "SELECT COUNT(*) FROM Users WHERE Email = @Email";
                using (SqlCommand checkCmd = new SqlCommand(checkSql, conn))
                {
                    checkCmd.Parameters.AddWithValue("@Email", email);
                    int count = (int)checkCmd.ExecuteScalar();
                    if (count > 0)
                    {
                        lblError.Text = "An account with this email already exists.";
                        return;
                    }
                }

                string insertSql = @"
                    INSERT INTO Users
                        (AccountNumber, LastName, FirstName, Email,
                         PasswordHash, CurrentBalance, DateRegistered, IsActive)
                    VALUES
                        (@AccountNumber, @LastName, @FirstName, @Email,
                         @PasswordHash, 0.00, GETDATE(), 1)";

                using (SqlCommand cmd = new SqlCommand(insertSql, conn))
                {
                    cmd.Parameters.AddWithValue("@AccountNumber", accountNumber);
                    cmd.Parameters.AddWithValue("@LastName", lastName);
                    cmd.Parameters.AddWithValue("@FirstName", firstName);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@PasswordHash", hashedPassword);
                    cmd.ExecuteNonQuery();
                }
            }

            // Set account number to hidden field — triggers popup on page reload
            hfAccountNumber.Value = accountNumber;

            // Clear form fields
            txtLastName.Text = "";
            txtFirstName.Text = "";
            txtEmail.Text = "";
        }

        private string GenerateAccountNumber()
        {
            string candidate;

            using (SqlConnection conn = DbHelper.GetConnection())
            {
                conn.Open();

                string sql = @"
                    SELECT CASE
                        WHEN MAX(CAST(AccountNumber AS BIGINT)) IS NULL
                        THEN 1000000001
                        ELSE MAX(CAST(AccountNumber AS BIGINT)) + 1
                    END
                    FROM Users";

                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    candidate = cmd.ExecuteScalar().ToString();
                }
            }

            return candidate;
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