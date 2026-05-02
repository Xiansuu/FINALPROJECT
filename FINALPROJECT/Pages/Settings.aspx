<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Settings.aspx.cs" Inherits="FINALPROJECT.Settings" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Owl eWallet - Settings</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@300;400;500;600;700&family=DM+Mono:wght@400;500&display=swap" rel="stylesheet" />
    <link href="~/Styles/settings.css" rel="stylesheet" type="text/css" />
</head>
<body>

    <div class="modal-overlay" id="confirmModal">
        <div class="modal-box">
            <div class="modal-icon">PWD</div>
            <div class="modal-title">Change Password?</div>
            <div class="modal-desc">
                Are you sure you want to update your password?
                You will be logged out and redirected to the login page.
            </div>
            <div class="modal-actions">
                <button type="button" class="btn-cancel" onclick="closeModal()">Cancel</button>
                <button type="button" class="btn-confirm" onclick="confirmSave()">Yes, Update</button>
            </div>
        </div>
    </div>

    <form id="form1" runat="server">

        <div class="navbar">
            <div class="navbar-left">
                <div class="brand-name">Owl eWallet</div>
                <div class="nav-divider"></div>
                <nav class="nav-links">
                    <a href="Dashboard.aspx">Dashboard</a>
                    <a href="Deposit.aspx">Deposit</a>
                    <a href="Withdraw.aspx">Withdraw</a>
                    <a href="SendMoney.aspx">Send Money</a>
                    <a href="StatementOfAccount.aspx">Statement</a>
                    <a href="MyDepositsWithdrawals.aspx">Dep / With</a>
                    <a href="MySentReceived.aspx">Sent / Received</a>
                    <a href="Settings.aspx" class="active">Settings</a>
                </nav>
            </div>
            <div class="navbar-right">
                <span>Welcome, <strong>
                    <asp:Label ID="lblNavName" runat="server" />
                </strong></span>
                <a href="Logout.aspx" class="btn-logout">Logout</a>
            </div>
        </div>

        <div class="page-header">
            <h1>Settings</h1>
            <p>Manage your account information and security</p>
        </div>

        <div class="main-content">
            <div class="settings-grid">

                <!-- Account Info Card -->
                <div class="info-card">
                    <div class="card-title">Account Information</div>
                    <div class="info-grid">
                        <div class="info-row">
                            <span class="info-label">Account Number</span>
                            <span class="info-value mono">
                                <asp:Label ID="lblAccountNumber" runat="server" />
                            </span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Current Balance</span>
                            <span class="info-value green">
                                <asp:Label ID="lblCurrentBalance" runat="server" />
                            </span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Full Name</span>
                            <span class="info-value">
                                <asp:Label ID="lblFullName" runat="server" />
                            </span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Total Sent</span>
                            <span class="info-value green">
                                <asp:Label ID="lblTotalSent" runat="server" />
                            </span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Email Address</span>
                            <span class="info-value">
                                <asp:Label ID="lblEmail" runat="server" />
                            </span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Account Status</span>
                            <span class="info-value badge">● Active</span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Date Registered</span>
                            <span class="info-value">
                                <asp:Label ID="lblDateRegistered" runat="server" />
                            </span>
                        </div>
                        <div class="info-row">
                            <span class="info-label">Security</span>
                            <span class="info-value badge">● Protected</span>
                        </div>
                    </div>
                </div>

                <!-- Password Card -->
                <div class="password-card">
                    <div class="card-title">Change Password</div>

                    <asp:Label ID="lblError"   runat="server" CssClass="msg-error" />
                    <asp:Label ID="lblSuccess" runat="server" CssClass="msg-success" />

                    <div class="form-row">
                        <div class="form-group">
                            <label>Current Password</label>
                            <div class="password-wrapper">
                                <asp:TextBox ID="txtCurrentPassword" runat="server"
                                    TextMode="Password" placeholder="Current password" />
                                <button type="button" class="toggle-password" onclick="togglePassword('cur', this)">SHOW</button>
                            </div>
                            <asp:RequiredFieldValidator ID="rfvCurrent" runat="server"
                                ControlToValidate="txtCurrentPassword"
                                ErrorMessage="Required."
                                CssClass="msg-error" Display="Dynamic" />
                        </div>
                        <div class="form-group">
                            <label>New Password</label>
                            <div class="password-wrapper">
                                <asp:TextBox ID="txtNewPassword" runat="server"
                                    TextMode="Password" placeholder="New password" />
                                <button type="button" class="toggle-password" onclick="togglePassword('new', this)">SHOW</button>
                            </div>
                            <asp:RequiredFieldValidator ID="rfvNew" runat="server"
                                ControlToValidate="txtNewPassword"
                                ErrorMessage="Required."
                                CssClass="msg-error" Display="Dynamic" />
                        </div>
                        <div class="form-group">
                            <label>Confirm New Password</label>
                            <div class="password-wrapper">
                                <asp:TextBox ID="txtConfirmPassword" runat="server"
                                    TextMode="Password" placeholder="Confirm password" />
                                <button type="button" class="toggle-password" onclick="togglePassword('con', this)">SHOW</button>
                            </div>
                            <asp:RequiredFieldValidator ID="rfvConfirm" runat="server"
                                ControlToValidate="txtConfirmPassword"
                                ErrorMessage="Required."
                                CssClass="msg-error" Display="Dynamic" />
                            <asp:CompareValidator ID="cvPassword" runat="server"
                                ControlToValidate="txtConfirmPassword"
                                ControlToCompare="txtNewPassword"
                                ErrorMessage="Passwords do not match."
                                CssClass="msg-error" Display="Dynamic" />
                        </div>
                    </div>

                    <asp:Button ID="btnSave" runat="server"
                        Text="Update Password"
                        OnClick="btnSave_Click"
                        CssClass="btn-save"
                        style="display:none;" />

                    <button type="button" class="btn-save" onclick="showModal()">
                        Update Password
                    </button>

                </div>

            </div>

            <div class="footer-info">
                Owl eWallet &copy; 2026 &mdash; All transactions are secured and encrypted.
            </div>
        </div>
    </form>

    <script>
        function showModal() {
            if (typeof Page_ClientValidate === 'function') {
                if (!Page_ClientValidate()) return;
            }
            document.getElementById('confirmModal').classList.add('open');
        }

        function closeModal() {
            document.getElementById('confirmModal').classList.remove('open');
        }

        function confirmSave() {
            closeModal();
            document.getElementById('<%= btnSave.ClientID %>').click();
        }

        document.getElementById('confirmModal').addEventListener('click', function (e) {
            if (e.target === this) closeModal();
        });

        function togglePassword(field, btn) {
            var ids = {
                'cur': '<%= txtCurrentPassword.ClientID %>',
                'new': '<%= txtNewPassword.ClientID %>',
                'con': '<%= txtConfirmPassword.ClientID %>'
            };
            var input = document.getElementById(ids[field]);
            if (input.type === 'password') {
                input.type = 'text';
                btn.innerText = 'HIDE';
            } else {
                input.type = 'password';
                btn.innerText = 'SHOW';
            }
        }
    </script>

</body>
</html>