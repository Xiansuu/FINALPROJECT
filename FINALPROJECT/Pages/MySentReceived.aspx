<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MySentReceived.aspx.cs" Inherits="FINALPROJECT.MySentReceived" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Owl eWallet - My Sent / Received</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@300;400;500;600;700&family=DM+Mono:wght@400;500&display=swap" rel="stylesheet" />
    <style>
        *, *::before, *::after {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'DM Sans', sans-serif;
        }

        body { background: #060f18; min-height: 100vh; }

        /* ── Navbar ── */
        .navbar {
            background: #0e2238;
            padding: 0 40px;
            display: flex;
            justify-content: space-between;
            align-items: stretch;
            box-shadow: 0 2px 10px rgba(0,0,0,0.4);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .navbar-left {
            display: flex;
            align-items: center;
            gap: 40px;
        }

        .brand-name {
            font-family: 'DM Mono', monospace;
            font-size: 15px;
            font-weight: 500;
            letter-spacing: 2px;
            color: #ffffff;
            padding: 18px 0;
            white-space: nowrap;
        }

        .nav-links {
            display: flex;
            align-items: stretch;
        }

        .nav-links a {
            color: #7aaac8;
            font-size: 13px;
            font-weight: 500;
            text-decoration: none;
            padding: 0 16px;
            display: flex;
            align-items: center;
            border-bottom: 2px solid transparent;
            transition: color 0.2s, border-color 0.2s;
            white-space: nowrap;
        }

        .nav-links a:hover {
            color: #ffffff;
            border-bottom-color: #4a9fd4;
        }

        .nav-links a.active {
            color: #ffffff;
            border-bottom-color: #2e7db5;
        }

        .nav-divider {
            width: 1px;
            background: #1a3a5c;
            margin: 12px 0;
        }

        .navbar-right {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .navbar-right span { color: #a8c4e0; font-size: 13px; }
        .navbar-right strong { color: #ffffff; font-weight: 600; }

        .btn-logout {
            background: transparent;
            color: #cc0000;
            border: 1px solid #cc0000;
            padding: 7px 16px;
            border-radius: 6px;
            font-size: 12.5px;
            font-weight: 600;
            font-family: 'DM Sans', sans-serif;
            cursor: pointer;
            text-decoration: none;
            transition: background 0.2s, color 0.2s;
        }

        .btn-logout:hover { background: #cc0000; color: #ffffff; }

        /* ── Page Header ── */
        .page-header {
            background: #0a1929;
            border-bottom: 1px solid #1a3a5c;
            padding: 24px 40px;
        }

        .page-header h1 {
            color: #ffffff;
            font-size: 20px;
            font-weight: 600;
            letter-spacing: -0.2px;
            margin-bottom: 4px;
        }

        .page-header p {
            color: #7aaac8;
            font-size: 12.5px;
        }

        /* ── Main ── */
        .main-content {
            max-width: 1100px;
            margin: 30px auto;
            padding: 0 20px;
        }

        /* ── Filter Card ── */
        .filter-card {
            background: #0e2238;
            border-radius: 14px;
            padding: 24px 28px;
            border: 1px solid #1a3a5c;
            margin-bottom: 20px;
        }

        .filter-card-title {
            color: #7aaac8;
            font-size: 10px;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            font-weight: 600;
            margin-bottom: 18px;
        }

        .filter-row {
            display: flex;
            gap: 16px;
            align-items: flex-end;
            flex-wrap: wrap;
        }

        .filter-group {
            display: flex;
            flex-direction: column;
            gap: 7px;
            flex: 1;
            min-width: 140px;
        }

        .filter-group label {
            font-size: 11px;
            font-weight: 600;
            color: #7aaac8;
            text-transform: uppercase;
            letter-spacing: 1.5px;
        }

        .filter-group input,
        .filter-group select {
            padding: 11px 14px;
            border: 1.5px solid #1a3a5c;
            border-radius: 8px;
            font-size: 13.5px;
            font-family: 'DM Sans', sans-serif;
            color: #ffffff;
            background: #091929;
            outline: none;
            transition: border-color 0.2s, box-shadow 0.2s;
        }

        .filter-group input:focus,
        .filter-group select:focus {
            border-color: #4a9fd4;
            box-shadow: 0 0 0 3px rgba(74,159,212,0.1);
        }

        .filter-group select option { background: #0e2238; }

        .btn-generate {
            padding: 11px 28px;
            background: #2e7db5;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 13.5px;
            font-weight: 600;
            font-family: 'DM Sans', sans-serif;
            cursor: pointer;
            transition: background 0.2s, transform 0.1s;
            letter-spacing: 0.3px;
            white-space: nowrap;
        }

        .btn-generate:hover  { background: #256a9e; }
        .btn-generate:active { transform: scale(0.99); }

        .val-error {
            color: #ff6b6b;
            font-size: 11px;
            font-weight: 500;
            margin-top: 4px;
            display: block;
        }

        /* ── Error Message ── */
        .msg-error {
            display: block;
            background: #1a0a0a;
            border-left: 3px solid #cc0000;
            border-radius: 6px;
            padding: 11px 15px;
            color: #ff6b6b;
            font-size: 13px;
            font-weight: 500;
            margin-bottom: 18px;
        }

        .msg-error:empty { display: none; }

        /* ── Results Card ── */
        .results-card {
            background: #0e2238;
            border-radius: 14px;
            border: 1px solid #1a3a5c;
            overflow: hidden;
        }

        .results-header {
            padding: 18px 24px;
            border-bottom: 1px solid #1a3a5c;
        }

        .results-header span {
            color: #7aaac8;
            font-size: 10px;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            font-weight: 600;
        }

        /* ── Table ── */
        .table-wrap { overflow-x: auto; }

        table.stmt-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 13px;
        }

        .stmt-table thead tr {
            background: #091929;
            border-bottom: 1px solid #1a3a5c;
        }

        .stmt-table th {
            padding: 12px 16px;
            text-align: left;
            color: #7aaac8;
            font-size: 10px;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            font-weight: 600;
            white-space: nowrap;
        }

        .stmt-table td {
            padding: 13px 16px;
            border-bottom: 1px solid rgba(26,58,92,0.4);
            color: #c8d8e8;
            vertical-align: middle;
        }

        .stmt-table tr:last-child td { border-bottom: none; }
        .stmt-table tr:hover td { background: rgba(74,159,212,0.04); }

        /* Badges */
        .badge {
            display: inline-block;
            padding: 3px 10px;
            border-radius: 20px;
            font-size: 10px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-family: 'DM Mono', monospace;
        }

        .badge-sent     { background: rgba(255,165,0,0.12);  color: #ffaa33; }
        .badge-received { background: rgba(74,159,212,0.12); color: #4a9fd4; }

        .amount-sent     { color: #ffaa33; font-family: 'DM Mono', monospace; }
        .amount-received { color: #4adf8a; font-family: 'DM Mono', monospace; }
        .seq-col  { color: #3a5570; font-family: 'DM Mono', monospace; font-size: 12px; }
        .acct-col { color: #4a9fd4;  font-family: 'DM Mono', monospace; font-size: 12px; }
        .dash-col { color: #3a5570; }

        .empty-state {
            text-align: center;
            color: #3a5570;
            padding: 40px;
            font-size: 13px;
        }

        /* ── Footer ── */
        .footer-info {
            text-align: center;
            color: #2a4560;
            font-size: 12px;
            margin-top: 30px;
            padding-bottom: 20px;
        }
    </style>
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
                    <a href="MyDepositsWithdrawals.aspx">Dep / With</a>
                    <a href="MySentReceived.aspx" class="active">Sent / Received</a>
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
            <h1>My Sent / Received Transactions</h1>
            <p>View your sent and received CloudMoney transactions</p>
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
                            <asp:ListItem Value="Send">Sent</asp:ListItem>
                            <asp:ListItem Value="Receive">Received</asp:ListItem>
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
                                        <%# GetTypeBadge(Eval("SentTo"), Eval("ReceivedFrom")) %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="DateSent"
                                    HeaderText="Date &amp; Time"
                                    DataFormatString="{0:MM/dd/yyyy hh:mm tt}" />
                                <asp:TemplateField HeaderText="Amount">
                                    <ItemTemplate>
                                        <%# GetAmountHtml(Eval("SentTo"), Eval("ReceivedFrom"), Eval("Amount")) %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Sent To">
                                    <ItemTemplate>
                                        <span class="<%# Eval("SentTo") == DBNull.Value ? "dash-col" : "acct-col" %>">
                                            <%# Eval("SentTo") == DBNull.Value ? "—" : Eval("SentTo").ToString() %>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Received From">
                                    <ItemTemplate>
                                        <span class="<%# Eval("ReceivedFrom") == DBNull.Value ? "dash-col" : "acct-col" %>">
                                            <%# Eval("ReceivedFrom") == DBNull.Value ? "—" : Eval("ReceivedFrom").ToString() %>
                                        </span>
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