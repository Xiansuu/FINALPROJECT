<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="FINALPROJECT.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Owl eWallet - Login</title>
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
        }

        .login-wrapper {
            display: flex;
            width: 850px;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 20px 60px rgba(0,0,0,0.7);
        }

        /* ── Left Panel ── */
        .left-panel {
            background: #0e2238;
            width: 40%;
            padding: 50px 35px;
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
            width: 60%;
            padding: 50px 45px;
        }

        .right-panel h2 {
            color: #0e2238;
            font-size: 26px;
            font-weight: 700;
            margin-bottom: 6px;
            letter-spacing: -0.3px;
        }

        .subtitle {
            color: #666;
            font-size: 13px;
            margin-bottom: 30px;
            font-weight: 400;
        }

        .form-group { margin-bottom: 20px; }

        .form-group label {
            display: block;
            font-size: 11px;
            font-weight: 600;
            color: #4a5568;
            margin-bottom: 6px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .form-group input {
            width: 100%;
            padding: 12px 15px;
            border: 1.5px solid #c0ccd8;
            border-radius: 8px;
            font-size: 14px;
            font-family: 'DM Sans', sans-serif;
            color: #222;
            background: white;
            outline: none;
            transition: border 0.2s, box-shadow 0.2s;
        }

        .form-group input:focus {
            border-color: #2e7db5;
            box-shadow: 0 0 0 3px rgba(46,125,181,0.12);
        }

        /* ── Password Wrapper ── */
        .password-wrapper {
            position: relative;
        }

        .password-wrapper input {
            padding-right: 44px;
        }

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

        /* ── Error & Success Messages ── */
        .error-msg {
            color: #cc0000;
            font-size: 12px;
            font-weight: 500;
            margin-top: 6px;
            display: block;
        }

        .field-error {
            display: block;
            background: #fff5f5;
            border-left: 3px solid #cc0000;
            border-radius: 6px;
            padding: 8px 12px;
            color: #cc0000;
            font-size: 12px;
            font-weight: 500;
            margin-top: 8px;
        }

        .field-error:empty { display: none; }

        .success-msg {
            background: #f0fff4;
            border-left: 3px solid #27ae60;
            border-radius: 8px;
            padding: 12px 15px;
            color: #1e8449;
            font-size: 13px;
            font-weight: 500;
            margin-bottom: 20px;
            display: block;
        }

        .success-msg:empty { display: none; }

        /* ── Sign In Button ── */
        .btn-login {
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
            margin-top: 8px;
            transition: opacity 0.2s, transform 0.1s;
            letter-spacing: 0.3px;
            box-shadow: 0 4px 14px rgba(14,34,56,0.3);
        }

        .btn-login:hover  { opacity: 0.9; }
        .btn-login:active { transform: scale(0.99); }

        .register-link {
            text-align: center;
            margin-top: 20px;
            font-size: 13px;
            color: #666;
        }

        .register-link a {
            color: #0e2238;
            font-weight: 700;
            text-decoration: none;
            border-bottom: 1px solid transparent;
            transition: border-color 0.15s;
        }

        .register-link a:hover { border-bottom-color: #0e2238; }
    </style>
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