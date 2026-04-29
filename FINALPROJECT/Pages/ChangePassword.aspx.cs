using System;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;

namespace FINALPROJECT
{
    public partial class ChangePassword : System.Web.UI.Page
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
            }
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            int userID = Convert.ToInt32(Session["UserID"]);
            string currentPass = HashPassword(txtCurrentPassword.Text);
            string newPassword = txtNewPassword.Text;
            string confirmPass = txtConfirmPassword.Text;

            if (newPassword != confirmPass)
            {
                lblError.Text = "New passwords do not match.";
                return;
            }

            if (newPassword.Length < 8)
            {
                lblError.Text = "New password must be at least 8 characters.";
                return;
            }

            if (txtCurrentPassword.Text == newPassword)
            {
                lblError.Text = "New password must be different from current password.";
                return;
            }

            using (SqlConnection conn = DbHelper.GetConnection())
            {
                conn.Open();

                // Verify current password
                string checkSql = "SELECT COUNT(*) FROM Users WHERE UserID = @UserID AND PasswordHash = @PasswordHash";
                using (SqlCommand cmd = new SqlCommand(checkSql, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", userID);
                    cmd.Parameters.AddWithValue("@PasswordHash", currentPass);
                    int match = (int)cmd.ExecuteScalar();
                    if (match == 0)
                    {
                        lblError.Text = "Current password is incorrect.";
                        return;
                    }
                }

                // Update to new password
                string updateSql = "UPDATE Users SET PasswordHash = @NewHash WHERE UserID = @UserID";
                using (SqlCommand cmd = new SqlCommand(updateSql, conn))
                {
                    cmd.Parameters.AddWithValue("@NewHash", HashPassword(newPassword));
                    cmd.Parameters.AddWithValue("@UserID", userID);
                    cmd.ExecuteNonQuery();
                }
            }

            lblSuccess.Text = "Password changed successfully!";
            lblError.Text = "";
            txtCurrentPassword.Text = "";
            txtNewPassword.Text = "";
            txtConfirmPassword.Text = "";
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