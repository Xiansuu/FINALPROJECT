using System;
using System.Data;
using System.Data.SqlClient;

namespace FINALPROJECT
{
    public partial class MySentReceived : System.Web.UI.Page
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
            { lblError.Text = "Invalid From Date."; return; }

            if (!DateTime.TryParse(txtToDate.Text, out toDate))
            { lblError.Text = "Invalid To Date."; return; }

            if (fromDate > today || toDate > today)
            { lblError.Text = "Dates must not be future dates."; return; }

            if (fromDate > toDate)
            { lblError.Text = "From Date must be earlier than To Date."; return; }

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
                        t.TransactionDate AS DateSent,
                        t.Amount,
                        CASE
                            WHEN t.TransactionType = 'Send'
                                THEN u2.AccountNumber
                            ELSE NULL
                        END AS SentTo,
                        CASE
                            WHEN t.TransactionType = 'Receive'
                                THEN u1.AccountNumber
                            ELSE NULL
                        END AS ReceivedFrom
                    FROM Transactions t
                    LEFT JOIN Users u1 ON u1.UserID = t.SenderUserID
                    LEFT JOIN Users u2 ON u2.UserID = t.ReceiverUserID
                    WHERE
                        (
                            (t.TransactionType = 'Send'    AND t.SenderUserID   = @UserID) OR
                            (t.TransactionType = 'Receive' AND t.ReceiverUserID = @UserID)
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

        protected string GetTypeBadge(object sentTo, object receivedFrom)
        {
            if (sentTo != DBNull.Value && sentTo != null)
                return "<span class='badge badge-sent'>Sent</span>";
            if (receivedFrom != DBNull.Value && receivedFrom != null)
                return "<span class='badge badge-received'>Received</span>";
            return "";
        }

        protected string GetAmountHtml(object sentTo, object receivedFrom, object amount)
        {
            string formatted = "₱" + string.Format("{0:N2}", amount);
            if (sentTo != DBNull.Value && sentTo != null)
                return "<span class='amount-sent'>-" + formatted + "</span>";
            if (receivedFrom != DBNull.Value && receivedFrom != null)
                return "<span class='amount-received'>+" + formatted + "</span>";
            return formatted;
        }
    }
}