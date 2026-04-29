using System;
using System.Data;
using System.Data.SqlClient;

namespace FINALPROJECT
{
    public partial class MyDepositsWithdrawals : System.Web.UI.Page
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
                LoadTransactions(null, null, "All");
            }
        }

        protected void btnGenerate_Click(object sender, EventArgs e)
        {
            lblError.Text = "";

            DateTime fromDate, toDate;
            DateTime today = DateTime.Today;

            if (!DateTime.TryParse(txtFromDate.Text, out fromDate))
            {
                lblError.Text = "Invalid From Date.";
                return;
            }

            if (!DateTime.TryParse(txtToDate.Text, out toDate))
            {
                lblError.Text = "Invalid To Date.";
                return;
            }

            if (fromDate > today || toDate > today)
            {
                lblError.Text = "Dates must not be future dates.";
                return;
            }

            if (fromDate > toDate)
            {
                lblError.Text = "From Date must be earlier than To Date.";
                return;
            }

            toDate = toDate.AddDays(1).AddSeconds(-1);
            LoadTransactions(fromDate, toDate, ddlType.SelectedValue);
        }

        private void LoadTransactions(DateTime? fromDate, DateTime? toDate, string type)
        {
            int userID = Convert.ToInt32(Session["UserID"]);

            using (SqlConnection conn = DbHelper.GetConnection())
            {
                conn.Open();

                string sql = @"
                    SELECT
                        ROW_NUMBER() OVER (ORDER BY t.TransactionDate DESC) AS SeqNo,
                        LEFT(t.TransactionType, 1) AS Type,
                        t.TransactionDate AS Date,
                        t.Amount
                    FROM Transactions t
                    WHERE
                        (
                            (t.TransactionType = 'Deposit'    AND t.ReceiverUserID = @UserID) OR
                            (t.TransactionType = 'Withdrawal' AND t.SenderUserID   = @UserID)
                        )
                        AND (@FromDate IS NULL OR t.TransactionDate >= @FromDate)
                        AND (@ToDate   IS NULL OR t.TransactionDate <= @ToDate)
                        AND (@Type = 'All' OR t.TransactionType = @Type)
                    ORDER BY t.TransactionDate DESC";

                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", userID);
                    cmd.Parameters.AddWithValue("@FromDate", fromDate.HasValue ? (object)fromDate.Value : DBNull.Value);
                    cmd.Parameters.AddWithValue("@ToDate", toDate.HasValue ? (object)toDate.Value : DBNull.Value);
                    cmd.Parameters.AddWithValue("@Type", type);

                    DataTable dt = new DataTable();
                    new SqlDataAdapter(cmd).Fill(dt);

                    pnlResults.Visible = true;
                    gvTransactions.DataSource = dt;
                    gvTransactions.DataBind();
                }
            }
        }

        protected string GetTypeBadge(string type)
        {
            switch (type)
            {
                case "D": return "<span class='badge badge-D'>Deposit</span>";
                case "W": return "<span class='badge badge-W'>Withdrawal</span>";
                default: return "<span class='badge'>" + type + "</span>";
            }
        }

        protected string GetAmountHtml(string type, object amount)
        {
            string formatted = "₱" + string.Format("{0:N2}", amount);
            if (type == "D")
                return "<span class='amount-deposit'>" + formatted + "</span>";
            else
                return "<span class='amount-withdrawal'>" + formatted + "</span>";
        }
    }
}