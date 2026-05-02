<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Withdraw.aspx.cs" Inherits="FINALPROJECT.Withdraw" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Owl eWallet - Withdraw</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@300;400;500;600;700&family=DM+Mono:wght@400;500&display=swap" rel="stylesheet" />
    <link href="~/Styles/withdraw.css" rel="stylesheet" type="text/css" />
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
                input.addEventListener('keypress', function (e) {
                    if (!/[0-9]/.test(e.key)) e.preventDefault();
                });
                input.addEventListener('paste', function (e) { e.preventDefault(); });
                input.addEventListener('input', function () {
                    document.querySelectorAll('.quick-amt').forEach(function (b) {
                        b.classList.remove('selected');
                    });
                });
            }x
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