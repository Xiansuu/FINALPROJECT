<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="FINALPROJECT.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Owl eWallet - Login</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@300;400;500;600;700&family=DM+Mono:wght@400;500&display=swap" rel="stylesheet" />
    <link href="~/Styles/login.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-wrapper">

            <div class="left-panel">
                <div class="brand-name">Owl eWallet</div>
                <div class="divider"></div>
                <p>Your trusted digital wallet for secure and fast transactions.</p>

                <div class="left-badges">
                    <div class="left-badge">
                        <span class="left-badge-icon">SEC</span>
                        <span class="left-badge-text">256-bit encrypted transactions</span>
                    </div>
                    <div class="left-badge">
                        <span class="left-badge-icon">FAST</span>
                        <span class="left-badge-text">Instant fund transfers</span>
                    </div>
                    <div class="left-badge">
                        <span class="left-badge-icon">24/7</span>
                        <span class="left-badge-text">Available anytime, anywhere</span>
                    </div>
                </div>
            </div>

            <div class="right-panel">
                <h2>Welcome Back</h2>
                <p class="subtitle">Sign in to access your account</p>

                <asp:Label ID="lblSuccess" runat="server" CssClass="success-msg" />

                <div class="form-group">
                    <label>Account Number</label>
                    <asp:TextBox ID="txtAccountNumber" runat="server" MaxLength="10" />
                    <asp:RequiredFieldValidator ID="rfvAccountNumber" runat="server"
                        ControlToValidate="txtAccountNumber"
                        ErrorMessage="Account number is required."
                        CssClass="error-msg"
                        Display="Dynamic" />
                    <asp:RegularExpressionValidator ID="revAccountNumber" runat="server"
                        ControlToValidate="txtAccountNumber"
                        ValidationExpression="^[0-9]+$"
                        ErrorMessage="Account number must contain numbers only."
                        CssClass="error-msg"
                        Display="Dynamic" />
                    <asp:Label ID="lblAccountError" runat="server" CssClass="field-error" />
                </div>

                <div class="form-group">
                    <label>Password</label>
                    <div class="password-wrapper">
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" />
                        <button type="button" class="toggle-password" onclick="togglePassword(this)">SHOW</button>
                    </div>
                    <asp:RequiredFieldValidator ID="rfvPassword" runat="server"
                        ControlToValidate="txtPassword"
                        ErrorMessage="Password is required."
                        CssClass="error-msg"
                        Display="Dynamic" />
                    <asp:Label ID="lblPasswordError" runat="server" CssClass="field-error" />
                </div>

                <asp:Button ID="btnLogin" runat="server"
                    Text="Sign In"
                    OnClick="btnLogin_Click"
                    CssClass="btn-login" />

                <div class="register-link">
                    Don't have an account? <a href="Register.aspx">Register here</a>
                </div>
            </div>

        </div>
    </form>

    <script>
        function togglePassword(btn) {
            var input = document.getElementById('<%= txtPassword.ClientID %>');
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