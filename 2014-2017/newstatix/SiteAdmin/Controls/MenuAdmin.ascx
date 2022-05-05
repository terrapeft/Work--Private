<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MenuAdmin.ascx.cs" Inherits="AdministrativeUI.Controls.MenuAdmin" %>
<%@ Import Namespace="Db" %>

<nav class="navbar navbar-default plain-bar min-width-hundred-percent" data-spy="affix" data-offset-top="90">
    <div class="container-fluid">
        <div class="navbar-header" style="margin: 3px 15px 3px 0;">
            <a href="/" title="Futures &amp; Options World">
                <img src="/Themes/General/Images/logo.png?<%=DateTime.Now.ToBinary() %>" height="30" alt="TradeData"></a>
        </div>

        <div class="collapse navbar-collapse" id="admin-menu">

            <%--left part--%>
            <ul class="nav navbar-nav">
                <%-- Unsorted tables --%>
                <% foreach (var table in UngroupedTables.OrderBy(t => t.DisplayName))
                   { %>
                <% if (CurrentTable == table.Name)
                   { %>
                <li class="active">
                    <% }
                   else
                   { %>
                <li>
                    <% } %>
                    <a href="/<%= table.Name %>/List.aspx"><%= table.DisplayName %></a>
                </li>
                <% } %>


                <%-- drop downs --%>
                <% foreach (var group in TablesGroups.OrderBy(g => g.Key))
                   { %>
                <% if (group.Any(t => t.Name == CurrentTable))
                   { %>
                <li class="dropdown active">
                    <% }
                   else
                   { %>
                <li class="dropdown">
                    <% } %>

                    <a href="#" class="dropdown-toggle" data-hover="dropdown" data-delay="300" data-close-others="true">
                        <%= group.Key %>
                        <span class="glyphicon glyphicon-chevron-down" style="position: relative; top: 3px;"></span>
                    </a>
                    <ul class="dropdown-menu">
                        <% foreach (var table in group.OrderBy(t => t.DisplayName))
                           { %>
                        <% if (CurrentTable == table.Name)
                           { %>
                        <li class="active">
                            <% }
                           else
                           { %>
                        <li>
                            <% } %>
                            <a href="/<%= table.Name %>/List.aspx"><%= table.DisplayName %></a>
                        </li>
                        <% } %>
                    </ul>
                </li>
                <% } %>

                <% if (CurrentPath == "/Upload.aspx")
                   { %>
                <li class="active">
                    <% }
                   else
                   { %>
                <li>
                    <% } %>
                    <a href="/Upload.aspx">Upload logo</a>
                </li>
            </ul>

            <%--right part--%>
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                    <a id="loginInfo1_HyperLink1" class="dropdown-toggle" data-hover="dropdown" data-delay="300" data-close-others="true" href="#"><%= StatixEntities.CurrentSessionUser.Email %> <span class="glyphicon glyphicon-chevron-down" style="position: relative; top: 3px;"></span></a>
                    <ul class="dropdown-menu" role="menu">
                        <% foreach (var table in AccountTables.OrderBy(t => t.DisplayName))
                           { %>
                        <% if (CurrentTable == table.Name)
                           { %>
                        <li class="active">
                            <% }
                           else
                           { %>
                        <li>
                            <% } %>
                            <a href="/<%= table.Name %>/List.aspx"><i class="fa fa-fw"></i><%= table.DisplayName %></a>
                        </li>

                        <% } %>

                        <li><a href="#" runat="server" onserverclick="logout_ServerClick"><i class="fa fa-sign-out fa-fw"></i>Logout</a>
                        </li>
                    </ul>
            </ul>
        </div>
    </div>
</nav>

