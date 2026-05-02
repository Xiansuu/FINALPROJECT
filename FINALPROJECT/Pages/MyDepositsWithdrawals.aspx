<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyDepositsWithdrawals.aspx.cs" Inherits="FINALPROJECT.MyDepositsWithdrawals" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Owl eWallet - My Deposits / Withdrawals</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@300;400;500;600;700&family=DM+Mono:wght@400;500&display=swap" rel="stylesheet" />
    <link href="~/Styles/mydepositswithdrawals.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">

        <!-- Navbar -->
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
                    <a href="MyDepositsWithdrawals.aspx" class="active">Dep / With</a>
                    <a href="MySentReceived.aspx">Sent / Received</a>
                    <a href="Settings.aspx">Settings</a>
                </nav>
            </div>
            <div class="navbar-right">
                <span>Welcome, <strong><%= Session["FullName"] %></strong></span>
                <a href="Logout.aspx" class="btn-logout">Logout</a>
            </div>
        </div>

        <!-- Page Header -->
        <div class="page-header">
            <h1>My Deposits / Withdrawals</h1>
            <p>View your deposit and withdrawal transaction history</p>
        </div>

        <div class="main-content">

            <asp:Label ID="lblError" runat="server" CssClass="msg-error" />

            <!-- Filter Card -->
            <div class="filter-card">
                <div class="filter-card-title">Filter Transactions</div>
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
                    <div class="filter-group">
                        <label>Type</label>
                        <asp:DropDownList ID="ddlType" runat="server">
                            <asp:ListItem Value="All">All</asp:ListItem>
                            <asp:ListItem Value="Deposit">Deposit</asp:ListItem>
                            <asp:ListItem Value="Withdrawal">Withdrawal</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <asp:Button ID="btnGenerate" runat="server"
                        Text="Generate"
                        OnClick="btnGenerate_Click"
                        CssClass="btn-generate" />
                </div>
            </div>

            <!-- Results -->
            <asp:Panel ID="pnlResults" runat="server" Visible="false">
                <div class="results-card">
                    <div class="results-header">
                        <span>Transaction Results</span>
                    </div>
                    <div class="table-wrap">
                        <asp:GridView ID="gvTransactions" runat="server"
                            AutoGenerateColumns="false"
                            CssClass="stmt-table"
                            GridLines="None"
                            EmptyDataText="">
                            <EmptyDataRowStyle CssClass="empty-state" />
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
                                <asp:BoundField DataField="Date"
                                    HeaderText="Date &amp; Time"
                                    DataFormatString="{0:MM/dd/yyyy hh:mm tt}" />
                                <asp:TemplateField HeaderText="Amount">
                                    <ItemTemplate>
                                        <%# GetAmountHtml(Eval("Type").ToString(), Eval("Amount")) %>
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