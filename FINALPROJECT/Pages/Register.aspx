<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="FINALPROJECT.Register" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Owl eWallet - Register</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@300;400;500;600;700&family=DM+Mono:wght@400;500&display=swap" rel="stylesheet" />
    <style>
        *, *::before, *::after {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'DM Sans', sans-serif;
        }

        body {
            background: #060f18;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 30px 0;
        }

        .register-wrapper {
            display: flex;
            width: 900px;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 20px 60px rgba(0,0,0,0.7);
        }

        /* ── Left Panel ── */
        .left-panel {
            background: #0e2238;
            width: 35%;
            padding: 50px 30px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .left-panel::before {
            content: '';
            position: absolute;
            top: -80px; left: -80px;
            width: 260px; height: 260px;
            background: radial-gradient(circle, rgba(46,125,181,0.15) 0%, transparent 70%);
            pointer-events: none;
        }

        .left-panel::after {
            content: '';
            position: absolute;
            bottom: -80px; right: -80px;
            width: 260px; height: 260px;
            background: radial-gradient(circle, rgba(46,125,181,0.1) 0%, transparent 70%);
            pointer-events: none;
        }

        .brand-name {
            font-family: 'DM Mono', monospace;
            font-size: 18px;
            font-weight: 500;
            letter-spacing: 2px;
            color: #ffffff;
            margin-bottom: 8px;
            position: relative;
            z-index: 1;
        }

        .left-panel p {
            color: #7aaac8;
            font-size: 13px;
            line-height: 1.6;
            font-weight: 400;
            position: relative;
            z-index: 1;
        }

        .divider {
            width: 40px;
            height: 3px;
            background: linear-gradient(90deg, #2e7db5, #4a9fd4);
            margin: 15px auto;
            border-radius: 2px;
            position: relative;
            z-index: 1;
        }

        .left-badges {
            display: flex;
            flex-direction: column;
            gap: 10px;
            margin-top: 30px;
            width: 100%;
            position: relative;
            z-index: 1;
        }

        .left-badge {
            background: rgba(74,159,212,0.08);
            border: 1px solid rgba(74,159,212,0.15);
            border-radius: 8px;
            padding: 10px 14px;
            display: flex;
            align-items: center;
            gap: 10px;
            text-align: left;
        }

        .left-badge-icon {
            font-family: 'DM Mono', monospace;
            font-size: 9px;
            color: #4a9fd4;
            background: rgba(74,159,212,0.12);
            border: 1px solid rgba(74,159,212,0.2);
            padding: 3px 6px;
            border-radius: 4px;
            font-weight: 500;
            letter-spacing: 0.5px;
            flex-shrink: 0;
        }

        .left-badge-text {
            color: #7aaac8;
            font-size: 11.5px;
            font-weight: 400;
            line-height: 1.4;
        }

        /* ── Right Panel ── */
        .right-panel {
            background: #f0f4f8;
            width: 65%;
            padding: 40px 45px;
        }

        .right-panel h2 {
            color: #0e2238;
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 6px;
            letter-spacing: -0.3px;
        }

        .subtitle {
            color: #666;
            font-size: 13px;
            margin-bottom: 22px;
            font-weight: 400;
        }

        .form-group { margin-bottom: 14px; }

        .form-group label {
            display: block;
            font-size: 11px;
            font-weight: 600;
            color: #333;
            margin-bottom: 6px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .form-group input {
            width: 100%;
            padding: 11px 15px;
            border: 1.5px solid #c0ccd8;
            border-radius: 8px;
            font-size: 14px;
            font-family: 'DM Sans', sans-serif;
            color: #222;
            transition: border 0.2s, box-shadow 0.2s;
            background: white;
            outline: none;
        }

        .form-group input:focus {
            border-color: #2e7db5;
            box-shadow: 0 0 0 3px rgba(46,125,181,0.12);
        }

        /* ── Password Wrapper ── */
        .password-wrapper { position: relative; }
        .password-wrapper input { padding-right: 52px; }

        .toggle-password {
            position: absolute;
            right: 13px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            cursor: pointer;
            color: #c0ccd8;
            font-size: 10px;
            font-family: 'DM Mono', monospace;
            font-weight: 500;
            padding: 0;
            letter-spacing: 1px;
            transition: color 0.2s;
            user-select: none;
        }

        .toggle-password:hover { color: #7aaac8; }

        .error-msg {
            color: #cc0000;
            font-size: 12px;
            font-weight: 500;
            margin-top: 5px;
            display: block;
        }

        .server-error {
            background: #fff0f0;
            border-left: 3px solid #cc0000;
            border-radius: 8px;
            padding: 12px 15px;
            color: #cc0000;
            font-size: 13px;
            font-weight: 500;
            margin-bottom: 16px;
            display: block;
        }

        .server-error:empty { display: none; }

        .btn-register {
            width: 100%;
            padding: 13px;
            background: linear-gradient(135deg, #0e2238, #1a3a5c);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            font-family: 'DM Sans', sans-serif;
            cursor: pointer;
            margin-top: 10px;
            transition: opacity 0.2s, transform 0.1s;
            letter-spacing: 0.3px;
            box-shadow: 0 4px 14px rgba(14,34,56,0.3);
        }

        .btn-register:hover  { opacity: 0.9; }
        .btn-register:active { transform: scale(0.99); }

        .login-link {
            text-align: center;
            margin-top: 18px;
            font-size: 13px;
            color: #666;
        }

        .login-link a {
            color: #0e2238;
            font-weight: 700;
            text-decoration: none;
            border-bottom: 1px solid transparent;
            transition: border-color 0.15s;
        }

        .login-link a:hover { border-bottom-color: #0e2238; }

        /* ── Modal ── */
        .modal-overlay {
            display: none;
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(0,0,0,0.7);
            z-index: 999;
            justify-content: center;
            align-items: center;
        }

        .modal-overlay.active { display: flex; }

        .modal-box {
            background: white;
            width: 380px;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 10px 40px rgba(0,0,0,0.5);
            animation: popIn 0.3s ease;
        }

        @keyframes popIn {
            from { transform: scale(0.85); opacity: 0; }
            to   { transform: scale(1);   opacity: 1; }
        }

        .modal-header {
            background: #0e2238;
            padding: 30px 20px;
            text-align: center;
        }

        .modal-header h3 {
            color: white;
            font-size: 18px;
            font-weight: 600;
            letter-spacing: 0.2px;
        }

        .modal-header p {
            color: #7aaac8;
            font-size: 12px;
            margin-top: 6px;
            font-weight: 400;
        }

        .modal-body {
            padding: 28px 30px;
            text-align: center;
        }

        .modal-body p {
            color: #555;
            font-size: 13.5px;
            margin-bottom: 12px;
        }

        .account-number-box {
            background: #eef4fb;
            border: 2px dashed #0e2238;
            border-radius: 10px;
            padding: 18px 15px;
            margin: 15px 0;
        }

        .account-number-box span {
            display: block;
            font-size: 10px;
            color: #888;
            margin-bottom: 8px;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            font-weight: 600;
        }

        .account-number-box .acct-num {
            font-family: 'DM Mono', monospace;
            font-size: 28px;
            font-weight: 500;
            color: #0e2238;
            letter-spacing: 3px;
        }

        .warning-box {
            background: #fff8e1;
            border-left: 3px solid #f9a825;
            padding: 10px 14px;
            border-radius: 6px;
            font-size: 12px;
            color: #795548;
            text-align: left;
            margin-top: 10px;
            font-weight: 400;
        }

        .btn-proceed {
            width: 100%;
            padding: 13px;
            background: linear-gradient(135deg, #0e2238, #1a3a5c);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            font-family: 'DM Sans', sans-serif;
            cursor: pointer;
            margin-top: 20px;
            transition: opacity 0.2s, transform 0.1s;
            letter-spacing: 0.3px;
            box-shadow: 0 4px 14px rgba(14,34,56,0.3);
        }

        .btn-proceed:hover  { opacity: 0.9; }
        .btn-proceed:active { transform: scale(0.99); }
    </style>
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