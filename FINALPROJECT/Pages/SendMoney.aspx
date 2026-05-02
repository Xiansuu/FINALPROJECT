<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SendMoney.aspx.cs" Inherits="FINALPROJECT.SendMoney" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Owl eWallet - Send Money</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@300;400;500;600;700&family=DM+Mono:wght@400;500&display=swap" rel="stylesheet" />
    <link href="~/Styles/sendmoney.css" rel="stylesheet" type="text/css" /> 
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