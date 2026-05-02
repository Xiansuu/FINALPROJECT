<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SendMoney.aspx.cs" Inherits="FINALPROJECT.SendMoney" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Owl eWallet - Send Money</title>
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
            text-decoration: none;
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
            border: 1px solid #1e4060;
            box-shadow: 0 8px 32px rgba(0,0,0,0.5), inset 0 1px 0 rgba(74,159,212,0.08);
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: relative;
            overflow: hidden;
        }

        .account-card::before {
            content: '';
            position: absolute;
            top: -60px; right: -60px;
            width: 220px; height: 220px;
            background: radial-gradient(circle, rgba(155,89,182,0.08) 0%, transparent 70%);
            pointer-events: none;
        }

        .account-left h4 {
            color: #7aaac8;
            font-size: 10px;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            margin-bottom: 5px;
            font-weight: 600;
        }

        .account-left p {
            color: #ffffff;
            font-size: 15px;
            font-weight: 500;
            margin-bottom: 14px;
        }

        .account-left p:last-child { margin-bottom: 0; }

        .account-num {
            font-family: 'DM Mono', monospace !important;
            color: #4a9fd4 !important;
            font-size: 20px !important;
            letter-spacing: 2px;
        }

        .balance-right { text-align: right; }

        .balance-right h4 {
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

        /* ── Body Row ── */
        .body-row {
            display: flex;
            gap: 20px;
            align-items: flex-start;
        }

        /* ── Form Card ── */
        .form-card {
            background: #0e2238;
            border-radius: 18px;
            padding: 32px;
            border: 1px solid #1a3a5c;
            flex: 1;
            box-shadow: 0 8px 24px rgba(0,0,0,0.3);
        }

        .form-group { margin-bottom: 22px; }

        .form-group label {
            display: block;
            font-size: 11px;
            font-weight: 600;
            color: #7aaac8;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            margin-bottom: 10px;
        }

        .input-row { display: flex; gap: 10px; }
        .input-row input { flex: 1; }

        .form-group input {
            width: 100%;
            padding: 14px 18px;
            border: 1.5px solid #1a3a5c;
            border-radius: 10px;
            font-size: 15px;
            font-family: 'DM Mono', monospace;
            color: #ffffff;
            background: #091929;
            outline: none;
            transition: border-color 0.2s, box-shadow 0.2s;
        }

        .form-group input:focus {
            border-color: #9b59b6;
            box-shadow: 0 0 0 3px rgba(155,89,182,0.1);
        }

        .form-group input:disabled {
            opacity: 0.35;
            cursor: not-allowed;
        }

        .form-hint {
            color: #3a5570;
            font-size: 11.5px;
            margin-top: 8px;
        }

        /* ── Quick Amount ── */
        .quick-label {
            font-size: 11px;
            font-weight: 600;
            color: #7aaac8;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            margin-top: 14px;
            margin-bottom: 12px;
            display: block;
        }

        .quick-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 10px;
            margin-bottom: 22px;
        }

        .quick-amt {
            background: #091929;
            border: 1px solid #1a3a5c;
            color: #7aaac8;
            font-family: 'DM Mono', monospace;
            font-size: 12.5px;
            font-weight: 500;
            padding: 12px 8px;
            border-radius: 10px;
            cursor: pointer;
            transition: background 0.2s, border-color 0.2s, color 0.2s;
            letter-spacing: 0.3px;
            text-align: center;
        }

        .quick-amt:hover {
            background: #1a0d2e;
            border-color: #9b59b6;
            color: #c39bd3;
        }

        .quick-amt.selected {
            background: rgba(155,89,182,0.15);
            border-color: #9b59b6;
            color: #c39bd3;
        }

        /* ── Recipient Box ── */
        .recipient-box {
            background: #091929;
            border: 1px solid #1a3a5c;
            border-radius: 10px;
            padding: 16px 18px;
            margin-bottom: 22px;
            min-height: 50px;
            transition: border-color 0.2s;
        }

        .recipient-box.has-recipient {
            border-color: #9b59b6;
            background: rgba(155,89,182,0.05);
        }

        .recipient-label {
            color: #7aaac8;
            font-size: 10px;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            font-weight: 600;
            margin-bottom: 6px;
        }

        /* ── Buttons ── */
        .btn-search {
            padding: 14px 22px;
            background: #1a3a5c;
            color: #a8c4e0;
            border: 1.5px solid #1a3a5c;
            border-radius: 10px;
            font-size: 13px;
            font-weight: 600;
            font-family: 'DM Sans', sans-serif;
            cursor: pointer;
            transition: background 0.2s, color 0.2s, border-color 0.2s;
            white-space: nowrap;
        }

        .btn-search:hover {
            background: #9b59b6;
            border-color: #9b59b6;
            color: #ffffff;
        }

        .btn-send {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #9b59b6, #7d3c98);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 14px;
            font-weight: 700;
            font-family: 'DM Sans', sans-serif;
            cursor: pointer;
            transition: opacity 0.2s, transform 0.1s;
            letter-spacing: 0.5px;
            box-shadow: 0 4px 16px rgba(155,89,182,0.3);
            margin-top: 4px;
        }

        .btn-send:hover  { opacity: 0.9; }
        .btn-send:active { transform: scale(0.99); }
        .btn-send:disabled { opacity: 0.35; cursor: not-allowed; transform: none; box-shadow: none; }

        .val-error {
            color: #ff6b6b;
            font-size: 11.5px;
            font-weight: 500;
            display: block;
            margin-top: 5px;
        }

        .msg-error {
            display: block;
            background: #1a0a0a;
            border-left: 3px solid #cc0000;
            border-radius: 8px;
            padding: 12px 16px;
            color: #ff6b6b;
            font-size: 13px;
            font-weight: 500;
            margin-bottom: 20px;
        }

        .msg-error:empty { display: none; }

        .msg-success {
            display: block;
            background: #0a1a0f;
            border-left: 3px solid #27ae60;
            border-radius: 8px;
            padding: 12px 16px;
            color: #4adf8a;
            font-size: 13px;
            font-weight: 500;
            margin-bottom: 20px;
        }

        .msg-success:empty { display: none; }

        .divider {
            height: 1px;
            background: #1a3a5c;
            margin: 22px 0;
        }

        /* ── Rules Sidebar ── */
        .rules-card {
            background: #0e2238;
            border: 1px solid #1a3a5c;
            border-radius: 18px;
            padding: 28px;
            width: 280px;
            flex-shrink: 0;
            box-shadow: 0 8px 24px rgba(0,0,0,0.3);
        }

        .rules-title {
            color: #7aaac8;
            font-size: 10px;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            font-weight: 600;
            margin-bottom: 20px;
        }

        .rules-list {
            list-style: none;
            display: flex;
            flex-direction: column;
            gap: 16px;
        }

        .rules-list li {
            color: #a8c4e0;
            font-size: 13px;
            line-height: 1.5;
            display: flex;
            align-items: flex-start;
            gap: 12px;
        }

        .rules-list li strong { color: #ffffff; font-weight: 600; }

        .rule-icon {
            display: inline-block;
            background: rgba(155,89,182,0.1);
            color: #c39bd3;
            font-family: 'DM Mono', monospace;
            font-size: 9px;
            font-weight: 500;
            padding: 4px 7px;
            border-radius: 5px;
            letter-spacing: 0.5px;
            flex-shrink: 0;
            margin-top: 2px;
        }

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
                <a href="Dashboard.aspx" class="brand-name">Owl eWallet</a>
                <div class="nav-divider"></div>
                <nav class="nav-links">
                    <a href="Dashboard.aspx">Dashboard</a>
                    <a href="Deposit.aspx">Deposit</a>
                    <a href="Withdraw.aspx">Withdraw</a>
                    <a href="SendMoney.aspx" class="active">Send Money</a>
                    <a href="StatementOfAccount.aspx">Statement</a>
                    <a href="MyDepositsWithdrawals.aspx">Dep / With</a>
                    <a href="MySentReceived.aspx">Sent / Received</a>
                    <a href="Settings.aspx">Settings</a>
                </nav>
            </div>
            <div class="navbar-right">
                <span>Welcome, <strong><%= Session["FullName"] %></strong></span>
                <a href="Logout.aspx" class="btn-logout">Logout</a>
            </div>
        </div>

        <div class="page-header">
            <h1>Send Money</h1>
            <p>Transfer funds to another Owl eWallet account</p>
        </div>

        <div class="main-content">

            <div class="account-card">
                <div class="account-left">
                    <h4>Account Name</h4>
                    <p><asp:Label ID="lblSenderName" runat="server" /></p>
                    <h4>Account Number</h4>
                    <p class="account-num">
                        <asp:Label ID="lblSenderAccountNumber" runat="server" />
                    </p>
                </div>
                <div class="balance-right">
                    <h4>Current Balance</h4>
                    <div class="balance-amount">
                        <asp:Label ID="lblCurrentBalance" runat="server" />
                    </div>
                </div>
            </div>

            <div class="body-row">

                <div class="form-card">

                    <asp:Label ID="lblError"   runat="server" CssClass="msg-error" />
                    <asp:Label ID="lblSuccess" runat="server" CssClass="msg-success" />

                    <div class="form-group">
                        <label>Recipient Account Number</label>
                        <div class="input-row">
                            <asp:TextBox ID="txtAccountNumber" runat="server"
                                placeholder="e.g. 1000000002" />
                            <asp:Button ID="btnSearch" runat="server"
                                Text="Search"
                                OnClick="btnSearch_Click"
                                CausesValidation="false"
                                CssClass="btn-search" />
                        </div>
                    </div>

                    <div class="recipient-box" id="recipientBox">
                        <div class="recipient-label">Recipient Info</div>
                        <asp:Label ID="lblRecipientName" runat="server"
                            style="color:#c39bd3; font-size:14px; font-weight:500;" />
                    </div>

                    <div class="divider"></div>

                    <div class="form-group">
                        <label>Amount</label>
                        <asp:TextBox ID="txtAmount" runat="server"
                            placeholder="e.g. 500" Enabled="false" />
                        <asp:RequiredFieldValidator ID="rfvAmount" runat="server"
                            ControlToValidate="txtAmount"
                            ErrorMessage="Amount is required."
                            CssClass="val-error" Display="Dynamic" Enabled="false" />
                        <asp:RangeValidator ID="rvAmount" runat="server"
                            ControlToValidate="txtAmount"
                            MinimumValue="100" MaximumValue="2000"
                            Type="Currency"
                            ErrorMessage="Amount must be between ₱100.00 and ₱2,000.00."
                            CssClass="val-error" Display="Dynamic" Enabled="false" />
                        <p class="form-hint">Min: ₱100 &nbsp;|&nbsp; Max: ₱2,000 &nbsp;|&nbsp; Multiples of ₱100 only</p>

                        <span class="quick-label">Quick Select Amount</span>
                        <div class="quick-grid">
                            <button type="button" class="quick-amt" onclick="setAmount(100, this)">₱100</button>
                            <button type="button" class="quick-amt" onclick="setAmount(200, this)">₱200</button>
                            <button type="button" class="quick-amt" onclick="setAmount(300, this)">₱300</button>
                            <button type="button" class="quick-amt" onclick="setAmount(400, this)">₱400</button>
                            <button type="button" class="quick-amt" onclick="setAmount(500, this)">₱500</button>
                            <button type="button" class="quick-amt" onclick="setAmount(600, this)">₱600</button>
                            <button type="button" class="quick-amt" onclick="setAmount(700, this)">₱700</button>
                            <button type="button" class="quick-amt" onclick="setAmount(800, this)">₱800</button>
                            <button type="button" class="quick-amt" onclick="setAmount(900, this)">₱900</button>
                            <button type="button" class="quick-amt" onclick="setAmount(1000, this)">₱1,000</button>
                            <button type="button" class="quick-amt" onclick="setAmount(1500, this)">₱1,500</button>
                            <button type="button" class="quick-amt" onclick="setAmount(2000, this)">₱2,000</button>
                        </div>
                    </div>

                    <div class="form-group">
                        <label>Your Password</label>
                        <asp:TextBox ID="txtPassword" runat="server"
                            TextMode="Password"
                            placeholder="Enter your password to confirm"
                            Enabled="false" />
                        <asp:RequiredFieldValidator ID="rfvPassword" runat="server"
                            ControlToValidate="txtPassword"
                            ErrorMessage="Password is required."
                            CssClass="val-error" Display="Dynamic" Enabled="false" />
                    </div>

                    <asp:Button ID="btnSend" runat="server"
                        Text="Send Money"
                        OnClick="btnSend_Click"
                        CssClass="btn-send"
                        Enabled="false" />

                </div>

                <div class="rules-card">
                    <div class="rules-title">Transaction Rules</div>
                    <ul class="rules-list">
                        <li>
                            <span class="rule-icon">MIN</span>
                            Minimum send amount is <strong>₱100.00</strong>
                        </li>
                        <li>
                            <span class="rule-icon">MAX</span>
                            Maximum per transaction is <strong>₱2,000.00</strong>
                        </li>
                        <li>
                            <span class="rule-icon">DIV</span>
                            Must be in multiples of <strong>₱100.00</strong>
                        </li>
                        <li>
                            <span class="rule-icon">BAL</span>
                            Cannot exceed your current balance
                        </li>
                        <li>
                            <span class="rule-icon">DAY</span>
                            Daily limit is <strong>₱10,000.00</strong>
                        </li>
                        <li>
                            <span class="rule-icon">PWD</span>
                            Password required to confirm every send
                        </li>
                    </ul>
                </div>

            </div>

            <div class="footer-info">
                Owl eWallet &copy; 2026 &mdash; All transactions are secured and encrypted.
            </div>

        </div>
    </form>

    <script>
        var amtInputId = '<%= txtAmount.ClientID %>';

        document.addEventListener('DOMContentLoaded', function () {
            var input = document.getElementById(amtInputId);
            if (input) {
                input.addEventListener('keypress', function (e) {
                    if (!/[0-9]/.test(e.key)) e.preventDefault();
                });
                input.addEventListener('paste', function (e) { e.preventDefault(); });
            }
        });

        function setAmount(val, btn) {
            var input = document.getElementById(amtInputId);
            if (!input || input.disabled) return;
            input.value = val;
            document.querySelectorAll('.quick-amt').forEach(function (b) {
                b.classList.remove('selected');
            });
            btn.classList.add('selected');
        }
    </script>
</body>
</html>