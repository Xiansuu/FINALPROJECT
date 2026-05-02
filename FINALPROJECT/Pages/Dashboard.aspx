<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="FINALPROJECT.Dashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Owl eWallet - Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@300;400;500;600;700&family=DM+Mono:wght@400;500&display=swap" rel="stylesheet" />
    <style>
        *, *::before, *::after {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'DM Sans', sans-serif;
        }

        body { background: #060f18; min-height: 100vh; }

        /* ── Navbar ── */
        .navbar {
            background: #0e2238;
            padding: 0 40px;
            display: flex;
            justify-content: space-between;
            align-items: stretch;
            box-shadow: 0 2px 10px rgba(0,0,0,0.4);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .navbar-left {
            display: flex;
            align-items: center;
            gap: 40px;
        }

        .brand-name {
            font-family: 'DM Mono', monospace;
            font-size: 15px;
            font-weight: 500;
            letter-spacing: 2px;
            color: #ffffff;
            padding: 18px 0;
            white-space: nowrap;
        }

        .nav-links { display: flex; align-items: stretch; gap: 0; }

        .nav-links a {
            color: #7aaac8;
            font-size: 13px;
            font-weight: 500;
            text-decoration: none;
            padding: 0 16px;
            display: flex;
            align-items: center;
            border-bottom: 2px solid transparent;
            transition: color 0.2s, border-color 0.2s;
            letter-spacing: 0.2px;
            white-space: nowrap;
        }

        .nav-links a:hover  { color: #ffffff; border-bottom-color: #4a9fd4; }
        .nav-links a.active { color: #ffffff; border-bottom-color: #2e7db5; }

        .nav-divider {
            width: 1px;
            background: #1a3a5c;
            margin: 12px 0;
        }

        .navbar-right {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .navbar-right span { color: #a8c4e0; font-size: 13px; }
        .navbar-right strong { color: #ffffff; font-weight: 600; }

        .btn-logout {
            background: transparent;
            color: #cc0000;
            border: 1px solid #cc0000;
            padding: 7px 16px;
            border-radius: 6px;
            font-size: 12.5px;
            font-weight: 600;
            font-family: 'DM Sans', sans-serif;
            cursor: pointer;
            text-decoration: none;
            transition: background 0.2s, color 0.2s;
        }

        .btn-logout:hover { background: #cc0000; color: #ffffff; }

        /* ── Notification Bell ── */
        .notif-wrapper {
            position: relative;
            display: flex;
            align-items: center;
        }

        .notif-bell {
            background: transparent;
            border: 1px solid #1a3a5c;
            color: #a8c4e0;
            height: 36px;
            padding: 0 14px;
            border-radius: 8px;
            font-size: 11px;
            font-family: 'DM Mono', monospace;
            font-weight: 500;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 7px;
            transition: background 0.2s, border-color 0.2s, color 0.2s;
            letter-spacing: 1px;
            white-space: nowrap;
        }

        .notif-bell:hover {
            background: #1a3a5c;
            border-color: #4a9fd4;
            color: #ffffff;
        }

        .notif-bell.has-notif {
            border-color: #2e7db5;
            color: #4a9fd4;
        }

        .notif-dropdown {
            display: none;
            position: absolute;
            top: 46px;
            right: 0;
            width: 340px;
            background: #0d1f35;
            border: 1px solid #1a3a5c;
            border-radius: 12px;
            box-shadow: 0 12px 40px rgba(0,0,0,0.6);
            z-index: 999;
            overflow: hidden;
        }

        .notif-dropdown.open { display: block; animation: fadeDown 0.18s ease; }

        @keyframes fadeDown {
            from { opacity: 0; transform: translateY(-6px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        .notif-dropdown-header {
            padding: 13px 18px;
            border-bottom: 1px solid #1a3a5c;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .notif-dropdown-header span {
            color: #7aaac8;
            font-size: 10px;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            font-weight: 600;
        }

        .notif-count-label {
            background: rgba(46,125,181,0.15);
            color: #4a9fd4;
            font-size: 10px;
            font-family: 'DM Mono', monospace;
            font-weight: 600;
            padding: 2px 8px;
            border-radius: 6px;
            border: 1px solid rgba(46,125,181,0.3);
        }

        .notif-dropdown-body {
            max-height: 340px;
            overflow-y: auto;
        }

        .notif-dropdown-body::-webkit-scrollbar { width: 3px; }
        .notif-dropdown-body::-webkit-scrollbar-track { background: transparent; }
        .notif-dropdown-body::-webkit-scrollbar-thumb { background: #1a3a5c; border-radius: 2px; }

        .notif-item {
            padding: 12px 18px;
            border-bottom: 1px solid rgba(26,58,92,0.4);
            display: flex;
            align-items: center;
            gap: 12px;
            transition: background 0.15s;
        }

        .notif-item:last-child { border-bottom: none; }
        .notif-item:hover { background: rgba(74,159,212,0.04); }

        .notif-icon {
            width: 36px;
            height: 36px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 10px;
            font-family: 'DM Mono', monospace;
            font-weight: 500;
            letter-spacing: 0.5px;
            flex-shrink: 0;
        }

        .notif-icon.deposit    { background: rgba(74,223,138,0.1);  color: #4adf8a; }
        .notif-icon.withdrawal { background: rgba(255,107,107,0.1); color: #ff6b6b; }
        .notif-icon.sent       { background: rgba(255,170,51,0.1);  color: #ffaa33; }
        .notif-icon.received   { background: rgba(74,159,212,0.1);  color: #4a9fd4; }

        .notif-body { flex: 1; min-width: 0; }

        .notif-title {
            color: #ddeeff;
            font-size: 12.5px;
            font-weight: 500;
            margin-bottom: 3px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .notif-date {
            color: #3a5570;
            font-size: 10px;
            font-family: 'DM Mono', monospace;
        }

        .notif-amount {
            font-family: 'DM Mono', monospace;
            font-size: 12.5px;
            font-weight: 500;
            white-space: nowrap;
        }

        .notif-amount.deposit    { color: #4adf8a; }
        .notif-amount.withdrawal { color: #ff6b6b; }
        .notif-amount.sent       { color: #ffaa33; }
        .notif-amount.received   { color: #4a9fd4; }

        .notif-empty {
            padding: 28px;
            text-align: center;
            color: #3a5570;
            font-size: 12.5px;
        }

        /* ── Page Header ── */
        .page-header {
            background: #0a1929;
            border-bottom: 1px solid #1a3a5c;
            padding: 24px 40px;
        }

        .page-header h1 {
            color: #ffffff;
            font-size: 20px;
            font-weight: 600;
            letter-spacing: -0.2px;
            margin-bottom: 4px;
        }

        .page-header p { color: #7aaac8; font-size: 12.5px; }

        /* ── Main ── */
        .main-content {
            max-width: 1100px;
            margin: 30px auto;
            padding: 0 20px;
        }

        /* ── Account Card ── */
        .account-card {
            background: linear-gradient(135deg, #0e2238 60%, #122e4e 100%);
            border-radius: 18px;
            padding: 34px 38px;
            margin-bottom: 22px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.5), inset 0 1px 0 rgba(74,159,212,0.08);
            display: flex;
            justify-content: space-between;
            align-items: center;
            border: 1px solid #1e4060;
            position: relative;
            overflow: hidden;
        }

        .account-card::before {
            content: '';
            position: absolute;
            top: -60px; right: -60px;
            width: 220px; height: 220px;
            background: radial-gradient(circle, rgba(46,125,181,0.12) 0%, transparent 70%);
            pointer-events: none;
        }

        .account-info h3 {
            color: #7aaac8;
            font-size: 10px;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            margin-bottom: 6px;
            font-weight: 600;
        }

        .account-info p { color: white; font-size: 16px; font-weight: 500; }

        .account-num {
            font-family: 'DM Mono', monospace !important;
            color: #4a9fd4 !important;
            font-size: 22px !important;
            font-weight: 500 !important;
            letter-spacing: 3px;
        }

        .account-info .gap { margin-bottom: 16px; }

        .balance-section { text-align: right; }

        .balance-section h3 {
            color: #7aaac8;
            font-size: 10px;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            margin-bottom: 8px;
            font-weight: 600;
        }

        .balance-amount {
            font-family: 'DM Mono', monospace;
            color: #4adf8a;
            font-size: 36px;
            font-weight: 500;
            text-shadow: 0 0 30px rgba(74,223,138,0.25);
        }

        /* ── Stats Row ── */
        .stats-row {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 16px;
            margin-bottom: 22px;
        }

        .stat-card {
            background: #0e2238;
            border-radius: 14px;
            padding: 22px 25px;
            border: 1px solid #1a3a5c;
            transition: border-color 0.2s, transform 0.2s;
            position: relative;
            overflow: hidden;
        }

        .stat-card::after {
            content: '';
            position: absolute;
            bottom: 0; left: 0;
            width: 100%; height: 2px;
            background: linear-gradient(90deg, #2e7db5, transparent);
            opacity: 0.5;
        }

        .stat-card:hover { border-color: #2e7db5; transform: translateY(-2px); }

        .stat-card h4 {
            color: #7aaac8;
            font-size: 10px;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            margin-bottom: 10px;
            font-weight: 600;
        }

        .stat-card p {
            color: white;
            font-size: 17px;
            font-weight: 600;
            font-family: 'DM Mono', monospace;
        }

        .stat-active    { color: #4adf8a !important; font-family: 'DM Sans', sans-serif !important; font-size: 14px !important; }
        .stat-protected { color: #4adf8a !important; font-family: 'DM Sans', sans-serif !important; font-size: 14px !important; }

        /* ── Section Title ── */
        .section-title {
            color: #7aaac8;
            font-size: 10px;
            font-weight: 600;
            margin-bottom: 14px;
            text-transform: uppercase;
            letter-spacing: 2px;
        }

        /* ── Actions Grid ── */
        .actions-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 14px;
            margin-bottom: 22px;
        }

        .action-btn {
            border-radius: 14px;
            padding: 26px 15px;
            text-align: center;
            text-decoration: none;
            transition: all 0.22s ease;
            display: block;
            position: relative;
            overflow: hidden;
            border: 1px solid transparent;
        }

        .action-label {
            color: #ffffff;
            font-size: 13px;
            font-weight: 600;
            display: block;
            letter-spacing: 0.3px;
        }

        .action-tag {
            display: inline-flex;
            width: 44px;
            height: 44px;
            border-radius: 10px;
            border: 1px solid transparent;
            margin-bottom: 14px;
            align-items: center;
            justify-content: center;
            font-family: 'DM Mono', monospace;
            font-size: 11px;
            font-weight: 500;
            letter-spacing: 0.5px;
            transition: background 0.22s, border-color 0.22s;
        }

        /* Deposit — Green */
        .action-btn.dep {
            background: linear-gradient(160deg, #0d2e1a, #0a1f12);
            border-color: #1a4d2e;
        }
        .action-btn.dep:hover {
            border-color: #27ae60;
            box-shadow: 0 8px 24px rgba(39,174,96,0.2);
            transform: translateY(-3px);
        }
        .action-btn.dep .action-tag {
            background: rgba(74,223,138,0.1);
            border-color: rgba(74,223,138,0.25);
            color: #4adf8a;
        }
        .action-btn.dep:hover .action-tag {
            background: rgba(74,223,138,0.2);
            border-color: rgba(74,223,138,0.5);
        }

        /* Withdraw — Red */
        .action-btn.wit {
            background: linear-gradient(160deg, #2e0d0d, #1f0a0a);
            border-color: #4d1a1a;
        }
        .action-btn.wit:hover {
            border-color: #c0392b;
            box-shadow: 0 8px 24px rgba(192,57,43,0.2);
            transform: translateY(-3px);
        }
        .action-btn.wit .action-tag {
            background: rgba(255,107,107,0.1);
            border-color: rgba(255,107,107,0.25);
            color: #ff6b6b;
        }
        .action-btn.wit:hover .action-tag {
            background: rgba(255,107,107,0.2);
            border-color: rgba(255,107,107,0.5);
        }

        /* Send Money — Purple */
        .action-btn.snd {
            background: linear-gradient(160deg, #1a0d2e, #120a1f);
            border-color: #3d1f6e;
        }
        .action-btn.snd:hover {
            border-color: #9b59b6;
            box-shadow: 0 8px 24px rgba(155,89,182,0.2);
            transform: translateY(-3px);
        }
        .action-btn.snd .action-tag {
            background: rgba(155,89,182,0.1);
            border-color: rgba(155,89,182,0.25);
            color: #c39bd3;
        }
        .action-btn.snd:hover .action-tag {
            background: rgba(155,89,182,0.2);
            border-color: rgba(155,89,182,0.5);
        }

        /* ── Reports Grid ── */
        .reports-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 14px;
            margin-bottom: 25px;
        }

        .report-btn {
            border-radius: 14px;
            padding: 22px 18px;
            text-align: center;
            text-decoration: none;
            transition: all 0.22s ease;
            display: block;
            position: relative;
            overflow: hidden;
            border: 1px solid transparent;
        }

        .report-btn::after {
            content: '';
            position: absolute;
            bottom: 0; left: 0;
            width: 0; height: 2px;
            transition: width 0.3s ease;
        }

        .report-btn:hover { transform: translateY(-3px); box-shadow: 0 8px 24px rgba(0,0,0,0.3); }
        .report-btn:hover::after { width: 100%; }

        .report-label {
            color: #a8c4e0;
            font-size: 13px;
            font-weight: 500;
            display: block;
            transition: color 0.2s;
        }

        .report-btn:hover .report-label { color: #ffffff; }

        .report-tag {
            display: inline-flex;
            width: 36px;
            height: 36px;
            border-radius: 8px;
            border: 1px solid transparent;
            margin-bottom: 12px;
            align-items: center;
            justify-content: center;
            font-family: 'DM Mono', monospace;
            font-size: 10px;
            font-weight: 500;
            transition: background 0.22s;
        }

        /* Statement — Purple */
        .report-btn.soa {
            background: linear-gradient(160deg, #1a0d2e, #120a1f);
            border-color: #3d1f6e;
        }
        .report-btn.soa:hover { border-color: #9b59b6; box-shadow: 0 8px 24px rgba(155,89,182,0.2); }
        .report-btn.soa .report-tag { background: rgba(155,89,182,0.1); border-color: rgba(155,89,182,0.25); color: #c39bd3; }
        .report-btn.soa:hover .report-tag { background: rgba(155,89,182,0.2); }
        .report-btn.soa::after { background: #9b59b6; }

        /* Dep/With — Teal */
        .report-btn.dw {
            background: linear-gradient(160deg, #0d2e2a, #0a1f1c);
            border-color: #1a5c52;
        }
        .report-btn.dw:hover { border-color: #1abc9c; box-shadow: 0 8px 24px rgba(26,188,156,0.2); }
        .report-btn.dw .report-tag { background: rgba(26,188,156,0.1); border-color: rgba(26,188,156,0.25); color: #1abc9c; }
        .report-btn.dw:hover .report-tag { background: rgba(26,188,156,0.2); }
        .report-btn.dw::after { background: #1abc9c; }

        /* Sent/Received — Orange */
        .report-btn.sr {
            background: linear-gradient(160deg, #2e1d0d, #1f140a);
            border-color: #5c3a1a;
        }
        .report-btn.sr:hover { border-color: #e67e22; box-shadow: 0 8px 24px rgba(230,126,34,0.2); }
        .report-btn.sr .report-tag { background: rgba(230,126,34,0.1); border-color: rgba(230,126,34,0.25); color: #e67e22; }
        .report-btn.sr:hover .report-tag { background: rgba(230,126,34,0.2); }
        .report-btn.sr::after { background: #e67e22; }

        /* ── Footer ── */
        .footer-info {
            text-align: center;
            color: #2a4560;
            font-size: 12px;
            margin-top: 30px;
            padding-bottom: 20px;
        }
    </style>
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