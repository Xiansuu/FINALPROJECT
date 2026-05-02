<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="FINALPROJECT.Register" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Owl eWallet - Register</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@300;400;500;600;700&family=DM+Mono:wght@400;500&display=swap" rel="stylesheet" />
    <link href="~/Styles/register.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <div class="modal-overlay" id="modalOverlay">
        <div class="modal-box">
            <div class="modal-header">
                <h3>Registration Successful</h3>
                <p>Your account has been created</p>
            </div>
            <div class="modal-body">
                <p>Your Account Number is:</p>
                <div class="account-number-box">
                    <span>Account Number</span>
                    <div class="acct-num" id="modalAccountNumber"></div>
                </div>
                <div class="warning-box">
                    Please write down or remember this number. You will need it to log in.
                </div>
                <button class="btn-proceed" onclick="goToLogin()">Proceed to Login</button>
            </div>
        </div>
    </div>

    <form id="form1" runat="server">
        <div class="register-wrapper">

            <div class="left-panel">
                <div class="brand-name">Owl eWallet</div>
                <div class="divider"></div>
                <p>Create your account and start sending money securely today.</p>

                <div class="left-badges">
                    <div class="left-badge">
                        <span class="left-badge-icon">FREE</span>
                        <span class="left-badge-text">No registration fees</span>
                    </div>
                    <div class="left-badge">
                        <span class="left-badge-icon">SEC</span>
                        <span class="left-badge-text">Your data is fully encrypted</span>
                    </div>
                    <div class="left-badge">
                        <span class="left-badge-icon">FAST</span>
                        <span class="left-badge-text">Start transacting instantly</span>
                    </div>
                </div>
            </div>

            <div class="right-panel">
                <h2>Create Account</h2>
                <p class="subtitle">Fill in the details below to get started</p>

                <asp:HiddenField ID="hfAccountNumber" runat="server" />
                <asp:Label ID="lblError" runat="server" CssClass="server-error" />

                <div class="form-group">
                    <label>Last Name</label>
                    <asp:TextBox ID="txtLastName" runat="server" />
                    <asp:RequiredFieldValidator ID="rfvLastName" runat="server"
                        ControlToValidate="txtLastName"
                        ErrorMessage="Last name is required."
                        CssClass="error-msg"
                        Display="Dynamic" />
                    <asp:RegularExpressionValidator ID="revLastName" runat="server"
                        ControlToValidate="txtLastName"
                        ValidationExpression="^[a-zA-ZÀ-ÖØ-öø-ÿÑñ\s]+$"
                        ErrorMessage="Last name must contain letters only."
                        CssClass="error-msg"
                        Display="Dynamic" />
                </div>

                <div class="form-group">
                    <label>First Name</label>
                    <asp:TextBox ID="txtFirstName" runat="server" />
                    <asp:RequiredFieldValidator ID="rfvFirstName" runat="server"
                        ControlToValidate="txtFirstName"
                        ErrorMessage="First name is required."
                        CssClass="error-msg"
                        Display="Dynamic" />
                    <asp:RegularExpressionValidator ID="revFirstName" runat="server"
                        ControlToValidate="txtFirstName"
                        ValidationExpression="^[a-zA-ZÀ-ÖØ-öø-ÿÑñ\s]+$"
                        ErrorMessage="First name must contain letters only."
                        CssClass="error-msg"
                        Display="Dynamic" />
                </div>

                <div class="form-group">
                    <label>Email</label>
                    <asp:TextBox ID="txtEmail" runat="server" />
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                        ControlToValidate="txtEmail"
                        ErrorMessage="Email is required."
                        CssClass="error-msg"
                        Display="Dynamic" />
                    <asp:RegularExpressionValidator ID="revEmail" runat="server"
                        ControlToValidate="txtEmail"
                        ValidationExpression="^[a-zA-ZÀ-ÖØ-öø-ÿÑñ0-9._%+\-]+@[a-zA-ZÀ-ÖØ-öø-ÿÑñ0-9.\-]+\.[a-zA-Z]{2,}$"
                        ErrorMessage="Invalid email format."
                        CssClass="error-msg"
                        Display="Dynamic" />
                </div>

                <div class="form-group">
                    <label>Password</label>
                    <div class="password-wrapper">
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" />
                        <button type="button" class="toggle-password" onclick="togglePassword('pwd', this)">SHOW</button>
                    </div>
                    <asp:RequiredFieldValidator ID="rfvPassword" runat="server"
                        ControlToValidate="txtPassword"
                        ErrorMessage="Password is required."
                        CssClass="error-msg"
                        Display="Dynamic" />
                </div>

                <div class="form-group">
                    <label>Confirm Password</label>
                    <div class="password-wrapper">
                        <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" />
                        <button type="button" class="toggle-password" onclick="togglePassword('confirm', this)">SHOW</button>
                    </div>
                    <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server"
                        ControlToValidate="txtConfirmPassword"
                        ErrorMessage="Please confirm your password."
                        CssClass="error-msg"
                        Display="Dynamic" />
                    <asp:CompareValidator ID="cvPassword" runat="server"
                        ControlToValidate="txtConfirmPassword"
                        ControlToCompare="txtPassword"
                        ErrorMessage="Passwords do not match."
                        CssClass="error-msg"
                        Display="Dynamic" />
                </div>

                <asp:Button ID="btnRegister" runat="server"
                    Text="Create Account"
                    OnClick="btnRegister_Click"
                    CssClass="btn-register" />

                <div class="login-link">
                    Already have an account? <a href="Login.aspx">Sign in here</a>
                </div>
            </div>

        </div>
    </form>

    <script>
        window.onload = function () {
            var an = document.getElementById('<%= hfAccountNumber.ClientID %>').value;
            if (an !== '') {
                document.getElementById('modalAccountNumber').innerText = an;
                document.getElementById('modalOverlay').classList.add('active');
            }
        };

        function goToLogin() {
            window.location.href = 'Login.aspx';
        }

        function togglePassword(field, btn) {
            var inputId = field === 'pwd'
                ? '<%= txtPassword.ClientID %>'
                : '<%= txtConfirmPassword.ClientID %>';
            var input = document.getElementById(inputId);
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