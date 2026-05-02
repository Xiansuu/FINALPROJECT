<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="FINALPROJECT.Dashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Owl eWallet - Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@300;400;500;600;700&family=DM+Mono:wght@400;500&display=swap" rel="stylesheet" />
    <link href="~/Styles/dashboard.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">

        <div class="navbar">
            <div class="navbar-left">
                <div class="brand-name">Owl eWallet</div>
                <div class="nav-divider"></div>
                <nav class="nav-links">
                    <a href="Dashboard.aspx" class="active">Dashboard</a>
                    <a href="Deposit.aspx">Deposit</a>
                    <a href="Withdraw.aspx">Withdraw</a>
                    <a href="SendMoney.aspx">Send Money</a>
                    <a href="StatementOfAccount.aspx">Statement</a>
                    <a href="MyDepositsWithdrawals.aspx">Dep / With</a>
                    <a href="MySentReceived.aspx">Sent / Received</a>
                    <a href="Settings.aspx">Settings</a>
                </nav>
            </div>
            <div class="navbar-right">

                <!-- Notification Bell -->
                <div class="notif-wrapper">
                    <button type="button" id="bellBtn"
                        class="notif-bell <%# NotifHasItems ? "has-notif" : "" %>"
                        onclick="toggleNotif(event)">
                        NTF
                    </button>
                    <div class="notif-dropdown" id="notifDropdown">
                        <div class="notif-dropdown-header">
                            <span>Recent Activity</span>
                            <asp:Label ID="lblNotifCountLabel" runat="server" CssClass="notif-count-label" />
                        </div>
                        <div class="notif-dropdown-body">
                            <asp:Panel ID="pnlNotifEmpty" runat="server" Visible="false">
                                <div class="notif-empty">No recent transactions.</div>
                            </asp:Panel>
                            <asp:Repeater ID="rptNotifications" runat="server">
                                <ItemTemplate>
                                    <div class="notif-item">
                                        <div class="notif-icon <%# Eval("IconClass") %>">
                                            <%# Eval("Icon") %>
                                        </div>
                                        <div class="notif-body">
                                            <div class="notif-title"><%# Eval("Title") %></div>
                                            <div class="notif-date"><%# Eval("Date") %></div>
                                        </div>
                                        <div class="notif-amount <%# Eval("IconClass") %>">
                                            <%# Eval("Amount") %>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                </div>

                <span>Welcome, <strong>
                    <asp:Label ID="lblNavName" runat="server" />
                </strong></span>
                <a href="Logout.aspx" class="btn-logout">Logout</a>
            </div>
        </div>

        <div class="page-header">
            <h1>Dashboard</h1>
            <p>Overview of your Owl eWallet account</p>
        </div>

        <div class="main-content">

            <div class="account-card">
                <div class="account-info">
                    <h3>Account Number</h3>
                    <p class="account-num">
                        <asp:Label ID="lblAccountNumber" runat="server" />
                    </p>
                    <div class="gap"></div>
                    <h3>Account Name</h3>
                    <p><asp:Label ID="lblFullName" runat="server" /></p>
                    <div class="gap"></div>
                    <h3>Member Since</h3>
                    <p><asp:Label ID="lblDateRegistered" runat="server" /></p>
                </div>
                <div class="balance-section">
                    <h3>Current Balance</h3>
                    <div class="balance-amount">
                        <asp:Label ID="lblCurrentBalance" runat="server" />
                    </div>
                </div>
            </div>

            <div class="stats-row">
                <div class="stat-card">
                    <h4>Total Sent</h4>
                    <p><asp:Label ID="lblTotalSent" runat="server" /></p>
                </div>
                <div class="stat-card">
                    <h4>Account Status</h4>
                    <p class="stat-active">● Active</p>
                </div>
                <div class="stat-card">
                    <h4>Security</h4>
                    <p class="stat-protected">● Protected</p>
                </div>
            </div>

            <p class="section-title">Quick Actions</p>
            <div class="actions-grid">
                <a href="Deposit.aspx" class="action-btn dep">
                    <span class="action-tag">DEP</span>
                    <span class="action-label">Deposit</span>
                </a>
                <a href="Withdraw.aspx" class="action-btn wit">
                    <span class="action-tag">WIT</span>
                    <span class="action-label">Withdraw</span>
                </a>
                <a href="SendMoney.aspx" class="action-btn snd">
                    <span class="action-tag">SND</span>
                    <span class="action-label">Send Money</span>
                </a>
            </div>

            <p class="section-title">Reports</p>
            <div class="reports-grid">
                <a href="StatementOfAccount.aspx" class="report-btn soa">
                    <span class="report-tag">SOA</span>
                    <span class="report-label">Statement of Account</span>
                </a>
                <a href="MyDepositsWithdrawals.aspx" class="report-btn dw">
                    <span class="report-tag">D/W</span>
                    <span class="report-label">My Deposits / Withdrawals</span>
                </a>
                <a href="MySentReceived.aspx" class="report-btn sr">
                    <span class="report-tag">S/R</span>
                    <span class="report-label">My Sent / Received</span>
                </a>
            </div>

            <div class="footer-info">
                Owl eWallet &copy; 2026 &mdash; All transactions are secured and encrypted.
            </div>

        </div>
    </form>

    <script>
        function toggleNotif(e) {
            e.stopPropagation();
            var dropdown = document.getElementById('notifDropdown');
            dropdown.classList.toggle('open');
        }

        document.addEventListener('click', function (e) {
            var wrapper = document.querySelector('.notif-wrapper');
            if (wrapper && !wrapper.contains(e.target)) {
                document.getElementById('notifDropdown').classList.remove('open');
            }
        });
    </script>
</body>
</html>