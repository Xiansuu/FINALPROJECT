<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StatementOfAccount.aspx.cs" Inherits="FINALPROJECT.StatementOfAccount" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Owl eWallet - Statement of Account</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@300;400;500;600;700&family=DM+Mono:wght@400;500&display=swap" rel="stylesheet" />
    <link href="~/Styles/statementofaccount.css" rel="stylesheet" type="text/css" />
</head>
<body>
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
                    <a href="StatementOfAccount.aspx" class="active">Statement</a>
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
            <h1>Statement of Account</h1>
            <p>View your full transaction history within a date range</p>
        </div>

        <div class="main-content">

            <asp:Label ID="lblError" runat="server" CssClass="msg-error" />

            <div class="filter-card">
                <div class="filter-card-title">Filter by Date Range</div>
                <div class="filter-row">
                    <div class="filter-group">
                        <label>From Date</label>
                        <asp:TextBox ID="txtFromDate" runat="server" TextMode="Date" />
                        <asp:RequiredFieldValidator ID="rfvFromDate" runat="server"
                            ControlToValidate="txtFromDate"
                            ErrorMessage="From date is required."
                            CssClass="val-error" Display="Dynamic" />
                    </div>
                    <div class="filter-group">
                        <label>To Date</label>
                        <asp:TextBox ID="txtToDate" runat="server" TextMode="Date" />
                        <asp:RequiredFieldValidator ID="rfvToDate" runat="server"
                            ControlToValidate="txtToDate"
                            ErrorMessage="To date is required."
                            CssClass="val-error" Display="Dynamic" />
                    </div>
                    <asp:Button ID="btnGenerate" runat="server"
                        Text="Generate"
                        OnClick="btnGenerate_Click"
                        CssClass="btn-generate" />
                </div>
            </div>

            <asp:Panel ID="pnlResults" runat="server" Visible="false">
                <div class="results-card">
                    <div class="results-header">
                        <span>Transaction History</span>
                    </div>
                    <div class="table-wrap">
                        <asp:GridView ID="gvStatement" runat="server"
                            AutoGenerateColumns="false"
                            CssClass="stmt-table"
                            GridLines="None"
                            EmptyDataText="">
                            <EmptyDataRowStyle CssClass="empty-row" />
                            <Columns>
                                <asp:TemplateField HeaderText="#">
                                    <ItemTemplate>
                                        <span class="seq-col"><%# Eval("SeqNo") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Type">
                                    <ItemTemplate>
                                        <%# GetTypeBadge(Eval("Type").ToString()) %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="Date" HeaderText="Date &amp; Time"
                                    DataFormatString="{0:MM/dd/yyyy hh:mm tt}" />
                                <asp:TemplateField HeaderText="Debit">
                                    <ItemTemplate>
                                        <span class="debit">
                                            <%# Eval("Debit") == DBNull.Value ? "" : "₱" + string.Format("{0:N2}", Eval("Debit")) %>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Credit">
                                    <ItemTemplate>
                                        <span class="credit">
                                            <%# Eval("Credit") == DBNull.Value ? "" : "₱" + string.Format("{0:N2}", Eval("Credit")) %>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Balance">
                                    <ItemTemplate>
                                        <span class="balance-col">₱<%# string.Format("{0:N2}", Eval("Balance")) %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Sent To">
                                    <ItemTemplate>
                                        <span class="acct-col"><%# Eval("SentTo") == DBNull.Value ? "—" : Eval("SentTo").ToString() %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Received From">
                                    <ItemTemplate>
                                        <span class="acct-col"><%# Eval("ReceivedFrom") == DBNull.Value ? "—" : Eval("ReceivedFrom").ToString() %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </asp:Panel>

            <div class="footer-info">
                Owl eWallet &copy; 2026 &mdash; All transactions are secured and encrypted.
            </div>

        </div>
    </form>
</body>
</html>