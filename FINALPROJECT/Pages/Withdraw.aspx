<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Withdraw.aspx.cs" Inherits="FINALPROJECT.Withdraw" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Owl eWallet - Withdraw</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@300;400;500;600;700&family=DM+Mono:wght@400;500&display=swap" rel="stylesheet" />
    <style>
        *, *::before, *::after {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'DM Sans', sans-serif;
        }

        body { background: #060f18; min-height: 100vh; }

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

        .navbar-right strong {
            color: #e8f4ff;
            font-weight: 600;
        }

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

        .main-content {
            max-width: 860px;
            margin: 30px auto;
            padding: 0 20px;
        }

        .balance-card {
            background: #0e2238;
            border-radius: 14px;
            padding: 24px 28px;
            margin-bottom: 20px;
            border: 1px solid #1a3a5c;
        }

        .balance-card h4 {
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
            font-size: 30px;
            font-weight: 500;
        }

        .body-row {
            display: flex;
            gap: 20px;
            align-items: flex-start;
        }

        .form-card {
            background: #0e2238;
            border-radius: 14px;
            padding: 28px;
            border: 1px solid #1a3a5c;
            flex: 1;
        }

        .form-group { margin-bottom: 20px; }

        .form-group label {
            display: block;
            font-size: 11px;
            font-weight: 600;
            color: #7aaac8;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            margin-bottom: 8px;
        }

        .form-group input {
            width: 100%;
            padding: 12px 15px;
            border: 1.5px solid #1a3a5c;
            border-radius: 8px;
            font-size: 15px;
            font-family: 'DM Mono', monospace;
            color: #ffffff;
            background: #091929;
            outline: none;
            transition: border-color 0.2s, box-shadow 0.2s;
        }

        .form-group input:focus {
            border-color: #4a9fd4;
            box-shadow: 0 0 0 3px rgba(74,159,212,0.1);
        }

        .hint-text {
            color: #3a5570;
            font-size: 11.5px;
            margin-top: 7px;
            display: block;
        }

        .error-msg {
            color: #ff6b6b;
            font-size: 11.5px;
            font-weight: 500;
            margin-top: 5px;
            display: block;
        }

        .server-error {
            display: block;
            background: #1a0a0a;
            border-left: 3px solid #cc0000;
            border-radius: 6px;
            padding: 11px 15px;
            color: #ff6b6b;
            font-size: 13px;
            font-weight: 500;
            margin-bottom: 18px;
        }

        .server-error:empty { display: none; }

        .server-success {
            display: block;
            background: #0a1a0f;
            border-left: 3px solid #27ae60;
            border-radius: 6px;
            padding: 11px 15px;
            color: #4adf8a;
            font-size: 13px;
            font-weight: 500;
            margin-bottom: 18px;
        }

        .server-success:empty { display: none; }

        /* ── Quick Amount Buttons ── */
        .quick-label {
            font-size: 11px;
            font-weight: 600;
            color: #7aaac8;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            margin-bottom: 10px;
            display: block;
        }

        .quick-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 8px;
            margin-bottom: 20px;
        }

        .quick-amt {
            background: #091929;
            border: 1px solid #1a3a5c;
            color: #7aaac8;
            font-family: 'DM Mono', monospace;
            font-size: 12px;
            font-weight: 500;
            padding: 10px 8px;
            border-radius: 8px;
            cursor: pointer;
            transition: background 0.2s, border-color 0.2s, color 0.2s;
            letter-spacing: 0.3px;
            text-align: center;
        }

        .quick-amt:hover {
            background: #1a3a5c;
            border-color: #4a9fd4;
            color: #ffffff;
        }

        .quick-amt.selected {
            background: rgba(192,57,43,0.2);
            border-color: #c0392b;
            color: #ff6b6b;
        }

        .btn-withdraw {
            width: 100%;
            padding: 13px;
            background: #c0392b;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            font-family: 'DM Sans', sans-serif;
            cursor: pointer;
            transition: background 0.2s, transform 0.1s;
            letter-spacing: 0.3px;
        }

        .btn-withdraw:hover  { background: #a93226; }
        .btn-withdraw:active { transform: scale(0.99); }

        .rules-card {
            background: #0e2238;
            border: 1px solid #1a3a5c;
            border-radius: 14px;
            padding: 24px;
            width: 240px;
            flex-shrink: 0;
        }

        .rules-title {
            color: #7aaac8;
            font-size: 10px;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            font-weight: 600;
            margin-bottom: 18px;
        }

        .rules-list {
            list-style: none;
            display: flex;
            flex-direction: column;
            gap: 14px;
        }

        .rules-list li {
            color: #a8c4e0;
            font-size: 12.5px;
            line-height: 1.5;
            display: flex;
            align-items: flex-start;
            gap: 10px;
        }

        .rules-list li strong { color: #ffffff; font-weight: 600; }

        .rule-icon {
            display: inline-block;
            background: rgba(74,159,212,0.1);
            color: #4a9fd4;
            font-family: 'DM Mono', monospace;
            font-size: 9px;
            font-weight: 500;
            padding: 3px 6px;
            border-radius: 4px;
            letter-spacing: 0.5px;
            flex-shrink: 0;
            margin-top: 2px;
        }

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
                    <a href="Withdraw.aspx" class="active">Withdraw</a>
                    <a href="SendMoney.aspx">Send Money</a>
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
            <h1>Withdraw Funds</h1>
            <p>Withdraw money from your Owl eWallet account</p>
        </div>

        <div class="main-content">

            <div class="balance-card">
                <h4>Current Balance</h4>
                <div class="balance-amount">
                    <asp:Label ID="lblCurrentBalance" runat="server" />
                </div>
            </div>

            <div class="body-row">

                <div class="form-card">

                    <asp:Label ID="lblError"   runat="server" CssClass="server-error" />
                    <asp:Label ID="lblSuccess" runat="server" CssClass="server-success" />

                    <div class="form-group">
                        <label>Withdrawal Amount (₱)</label>
                        <asp:TextBox ID="txtAmount" runat="server" placeholder="e.g. 500" />
                        <span class="hint-text">Enter amount in multiples of ₱100 (e.g. 100, 200, 500)</span>
                        <asp:RequiredFieldValidator ID="rfvAmount" runat="server"
                            ControlToValidate="txtAmount"
                            ErrorMessage="Amount is required."
                            CssClass="error-msg" Display="Dynamic" />
                        <asp:RangeValidator ID="rvAmount" runat="server"
                            ControlToValidate="txtAmount"
                            MinimumValue="100" MaximumValue="2000"
                            Type="Currency"
                            ErrorMessage="Amount must be between ₱100.00 and ₱2,000.00."
                            CssClass="error-msg" Display="Dynamic" />
                    </div>

                    <!-- Quick Amount Buttons -->
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

                    <asp:Button ID="btnWithdraw" runat="server"
                        Text="Withdraw Now"
                        OnClick="btnWithdraw_Click"
                        CssClass="btn-withdraw" />

                </div>

                <div class="rules-card">
                    <div class="rules-title">Withdrawal Rules</div>
                    <ul class="rules-list">
                        <li>
                            <span class="rule-icon">MIN</span>
                            Minimum withdrawal is <strong>₱100.00</strong>
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
                            Daily withdrawal limit is <strong>₱10,000.00</strong>
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
                // Numbers only
                input.addEventListener('keypress', function (e) {
                    if (!/[0-9]/.test(e.key)) e.preventDefault();
                });
                // Block paste
                input.addEventListener('paste', function (e) {
                    e.preventDefault();
                });
                // Clear quick selection if user types manually
                input.addEventListener('input', function () {
                    document.querySelectorAll('.quick-amt').forEach(function (b) {
                        b.classList.remove('selected');
                    });
                });
            }
        });

        function setAmount(val, btn) {
            var input = document.getElementById(amtInputId);
            if (!input) return;
            input.value = val;
            document.querySelectorAll('.quick-amt').forEach(function (b) {
                b.classList.remove('selected');
            });
            btn.classList.add('selected');
        }
    </script>

</body>
</html>