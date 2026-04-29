using System;
using System.Data;
using System.Data.SqlClient;

namespace FINALPROJECT
{
    public partial class StatementOfAccount : System.Web.UI.Page
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
                LoadStatement(null, null);
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
            LoadStatement(fromDate, toDate);
        }

        private void LoadStatement(DateTime? fromDate, DateTime? toDate)
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
                        CASE
                            WHEN t.TransactionType IN ('Withdrawal', 'Send')
                                THEN t.Amount
                            ELSE NULL
                        END AS Debit,
                        CASE
                            WHEN t.TransactionType IN ('Deposit', 'Receive')
                                THEN t.Amount
                            ELSE NULL
                        END AS Credit,
                        CASE
                            WHEN t.TransactionType IN ('Deposit', 'Receive')
                                THEN t.ReceiverBalanceAfter
                            ELSE t.SenderBalanceAfter
                        END AS Balance,
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
                        (t.ReceiverUserID = @UserID OR t.SenderUserID = @UserID)
                        AND (@FromDate IS NULL OR t.TransactionDate >= @FromDate)
                        AND (@ToDate   IS NULL OR t.TransactionDate <= @ToDate)
                    ORDER BY t.TransactionDate DESC";

                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", userID);
                    cmd.Parameters.AddWithValue("@FromDate", fromDate.HasValue ? (object)fromDate.Value : DBNull.Value);
                    cmd.Parameters.AddWithValue("@ToDate", toDate.HasValue ? (object)toDate.Value : DBNull.Value);

                    DataTable dt = new DataTable();
                    new SqlDataAdapter(cmd).Fill(dt);

                    pnlResults.Visible = true;
                    gvStatement.DataSource = dt;
                    gvStatement.DataBind();
                }
            }
        }

        protected string GetTypeBadge(string type)
        {
            switch (type)
            {
                case "D": return "<span class='badge badge-D'>Deposit</span>";
                case "W": return "<span class='badge badge-W'>Withdraw</span>";
                case "S": return "<span class='badge badge-S'>Sent</span>";
                case "R": return "<span class='badge badge-R'>Received</span>";
                default: return "<span class='badge'>" + type + "</span>";
            }
        }
    }
}