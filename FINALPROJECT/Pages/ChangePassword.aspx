<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="FINALPROJECT.ChangePassword" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>CloudMoney - Change Password</title>
</head>
<body>
    <form id="form1" runat="server">
        <h2>Change Password</h2>

        <asp:Label ID="lblError" runat="server" ForeColor="Red" /><br />
        <asp:Label ID="lblSuccess" runat="server" ForeColor="Green" />

        <table>
            <tr>
                <td>Current Password:</td>
                <td>
                    <asp:TextBox ID="txtCurrentPassword" runat="server" TextMode="Password" />
                    <asp:RequiredFieldValidator ID="rfvCurrentPassword" runat="server"
                        ControlToValidate="txtCurrentPassword"
                        ErrorMessage="Current password is required."
                        ForeColor="Red" />
                </td>
            </tr>
            <tr>
                <td>New Password:</td>
                <td>
                    <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" />
                    <asp:RequiredFieldValidator ID="rfvNewPassword" runat="server"
                        ControlToValidate="txtNewPassword"
                        ErrorMessage="New password is required."
                        ForeColor="Red" />
                </td>
            </tr>
            <tr>
                <td>Confirm New Password:</td>
                <td>
                    <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" />
                    <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server"
                        ControlToValidate="txtConfirmPassword"
                        ErrorMessage="Please confirm your new password."
                        ForeColor="Red" />
                    <asp:CompareValidator ID="cvPassword" runat="server"
                        ControlToValidate="txtConfirmPassword"
                        ControlToCompare="txtNewPassword"
                        ErrorMessage="Passwords do not match."
                        ForeColor="Red" />
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <asp:Button ID="btnChangePassword" runat="server"
                        Text="Change Password"
                        OnClick="btnChangePassword_Click" />
                </td>
            </tr>
        </table>

        <br />
        <a href="Dashboard.aspx">Back to Dashboard</a>
    </form>
</body>
</html>