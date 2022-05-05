<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MenuControl.ascx.cs" Inherits="CustomersUI.Controls.MenuControl" %>
<%@ Import Namespace="System.Globalization" %>
<%@ Import Namespace="System.IO" %>

<div class="masthead bgd-white">
    <div class="container spc-top align-top-portrait">
        <div class="header row">
            <div class="hidden-xs col-md-3 col-sm-3 col-xs-3" style="margin: 0 0 15px 0; padding: 0;">
                <a href="/" title="Futures &amp; Options World">
                    <img src="/Content/Images/logo.png" height="40" alt="TradeData"></a>
            </div>
            <!-- User's menu -->
            <div runat="server" id="logoutButton" class="col-md-9 col-sm-9 col-xs-9" style="padding: 0;">
                <div class="fright dropdown">
                    <a id="loginInfo1_HyperLink1" class="btn btn-lrg btn-primary btn-larger hidden-mob dropdown-toggle" data-hover="dropdown" data-delay="300" data-close-others="true" href="/account">My Account <span class="glyphicon glyphicon-chevron-down"></span></a>
                    <ul class="dropdown-menu">
                        <li>
                            <a id="A1" href="#" runat="server" onserverclick="logout_ServerClick">Logout</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div id="menuContainer" class="nav-bg-wrap" data-spy="affix" data-offset-top="90">
        <div class="container mob-full-width alpha omega">
            <div class="navbar navbar-inverse">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse"><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></button>
                    <a class="navbar-brand visible-xs" href="#"></a>
                </div>
                <div class="navbar-collapse collapse">
                    <ul class="nav navbar-nav">
                        <li class="active"><a href="/"><span class="glyphicon glyphicon-home"></span></a></li>
                        <%foreach (var file in Pages)
                          {
                              if (file == CurrentPage)
                              {
                        %>
                        <li class="active">
                            <% }
                          else
                          { %>
                        <li>
                            <% }%>
                            <a href="/<%=file%>">My <%= CultureInfo.CurrentUICulture.TextInfo.ToTitleCase(Path.GetFileNameWithoutExtension(file)) %></a>
                        </li>

                        <%}%>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
