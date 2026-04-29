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

        .left-panel {
            background: #0e2238;
            width: 40%;
            padding: 50px 35px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
        }

        .brand-name {
            font-family: 'DM Mono', monospace;
            font-size: 18px;
            font-weight: 500;
            letter-spacing: 2px;
            color: #ffffff;
            margin-bottom: 8px;
        }

        .left-panel p {
            color: #7aaac8;
            font-size: 13px;
            line-height: 1.6;
            font-weight: 400;
        }

        .divider {
            width: 40px;
            height: 3px;
            background: #2e7db5;
            margin: 15px auto;
            border-radius: 2px;
        }

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
            border-color: #0e2238;
            box-shadow: 0 0 0 3px rgba(14,34,56,0.12);
        }

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

        .server-error {
            background: #fff0f0;
            border-left: 3px solid #cc0000;
            border-radius: 8px;
            padding: 12px 15px;
            color: #cc0000;
            font-size: 13px;
            font-weight: 500;
            margin-bottom: 20px;
            display: block;
        }

        .server-error:empty { display: none; }

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

        .btn-login {
            width: 100%;
            padding: 13px;
            background: #0e2238;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            font-family: 'DM Sans', sans-serif;
            cursor: pointer;
            margin-top: 8px;
            transition: background 0.2s, transform 0.1s;
            letter-spacing: 0.3px;
        }

        .btn-login:hover  { background: #091929; }
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
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" />
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
</body>
</html>