using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace FINALPROJECT
{
    public partial class Dashboard : System.Web.UI.Page
    {
        // Property used by the bell button class binding
        public bool NotifHasItems { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadDashboard();
                LoadNotifications();
            }
        }

        private void LoadDashboard()
        {
            int userID = Convert.ToInt32(Session["UserID"]);

            using (SqlConnection conn = DbHelper.GetConnection())
            {
                conn.Open();

                string sql = @"
                    SELECT u.AccountNumber,
                           u.LastName + ', ' + u.FirstName AS FullName,
                           u.DateRegistered,
                           u.CurrentBalance,
                           ISNULL((SELECT SUM(t.Amount)
                                   FROM   Transactions t
                                   WHERE  t.SenderUserID    = u.UserID
                                     AND  t.TransactionType = 'Send'), 0) AS TotalSent
                    FROM   Users u
                    WHERE  u.UserID = @UserID";

                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", userID);

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            lblAccountNumber.Text = dr["AccountNumber"].ToString();
                            lblFullName.Text = dr["FullName"].ToString();
                            lblNavName.Text = dr["FullName"].ToString();
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

        private void LoadNotifications()
        {
            int userID = Convert.ToInt32(Session["UserID"]);

            using (SqlConnection conn = DbHelper.GetConnection())
            {
                conn.Open();

                // ── FIXED: strictly filter to only 1 CERTAIN user's transactions ──
                string sql = @"
                    SELECT TOP 10
                        t.TransactionType,
                        t.Amount,
                        t.TransactionDate,
                        u1.LastName + ', ' + u1.FirstName AS SenderName,
                        u2.LastName + ', ' + u2.FirstName AS ReceiverName,
                        u1.AccountNumber AS SenderAccount,
                        u2.AccountNumber AS ReceiverAccount
                    FROM Transactions t
                    LEFT JOIN Users u1 ON u1.UserID = t.SenderUserID
                    LEFT JOIN Users u2 ON u2.UserID = t.ReceiverUserID
                    WHERE
                        (t.TransactionType = 'Deposit'    AND t.ReceiverUserID = @UserID)
                     OR (t.TransactionType = 'Withdrawal' AND t.SenderUserID   = @UserID)
                     OR (t.TransactionType = 'Send'       AND t.SenderUserID   = @UserID)
                     OR (t.TransactionType = 'Receive'    AND t.ReceiverUserID = @UserID)
                    ORDER BY t.TransactionDate DESC";

                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", userID);

                    var notifications = new List<object>();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            string type = dr["TransactionType"].ToString();
                            decimal amount = Convert.ToDecimal(dr["Amount"]);
                            string date = Convert.ToDateTime(dr["TransactionDate"])
                                                       .ToString("MMM dd, yyyy hh:mm tt");
                            string title, icon, iconClass, amountStr;

                            switch (type)
                            {
                                case "Deposit":
                                    title = "Cash Deposit";
                                    icon = "IN";
                                    iconClass = "deposit";
                                    amountStr = "+ ₱" + amount.ToString("N2");
                                    break;

                                case "Withdrawal":
                                    title = "Cash Withdrawal";
                                    icon = "OUT";
                                    iconClass = "withdrawal";
                                    amountStr = "- ₱" + amount.ToString("N2");
                                    break;

                                case "Send":
                                    string receiver = dr["ReceiverName"] != DBNull.Value
                                        ? dr["ReceiverName"].ToString()
                                        : dr["ReceiverAccount"].ToString();
                                    title = "Sent to " + receiver;
                                    icon = "SND";
                                    iconClass = "sent";
                                    amountStr = "- ₱" + amount.ToString("N2");
                                    break;

                                case "Receive":
                                    string sender = dr["SenderName"] != DBNull.Value
                                        ? dr["SenderName"].ToString()
                                        : dr["SenderAccount"].ToString();
                                    title = "Received from " + sender;
                                    icon = "RCV";
                                    iconClass = "received";
                                    amountStr = "+ ₱" + amount.ToString("N2");
                                    break;

                                default:
                                    continue;
                            }

                            notifications.Add(new
                            {
                                Title = title,
                                Icon = icon,
                                IconClass = iconClass,
                                Amount = amountStr,
                                Date = date
                            });
                        }
                    }

                    if (notifications.Count == 0)
                    {
                        pnlNotifEmpty.Visible = true;
                        rptNotifications.Visible = false;
                        NotifHasItems = false;
                    }
                    else
                    {
                        pnlNotifEmpty.Visible = false;
                        rptNotifications.Visible = true;
                        NotifHasItems = true;
                        rptNotifications.DataSource = notifications;
                        rptNotifications.DataBind();
                    }
                }
            }
        }
    }
}