<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Menu.ascx.cs" Inherits="Statix.Controls.Menu.Menu" %>
<div class="masthead bgd-white">
    <div class="container-fluid menu-fluid alpha align-top-portrait">
        <div class="header row">
            <div class="logo col-md-3 col-sm-3 col-xs-3">
                <a href="/" title="Futures &amp; Options World">
                    <img src="/App_Themes/General/Images/logo.png" alt="Statix" height="30"></a>
            </div>
            <!-- User's menu -->
            <% if (IsAuthenticated)
               { %>
            <div class="col-md-9 col-sm-9 col-xs-9" style="padding-right: 0">
                <a id="loginInfo1_HyperLink1" style="margin-top: 10px;" class="btn btn-sm menu-sm btn-primary hidden-mob dropdown-toggle pull-right" data-hover="dropdown" data-delay="300" data-close-others="true">My Account <span class="glyphicon glyphicon-chevron-down"></span></a>
                <ul class="dropdown-menu dropdown-menu-sm pull-right btn-sm">
                    <li>
                        <a id="A1" href="#" runat="server" onserverclick="logout_ServerClick">Logout</a>
                    </li>
                </ul>
            </div>
            <% } %>
        </div>
    </div>
    <div id="menuContainer" class="nav-bg-wrap" data-spy="affix" data-offset-top="90">
        <div class="container-fluid menu-fluid mob-full-width alpha omega">
            <div class="navbar navbar-inverse">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse"><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></button>
                    <a class="navbar-brand visible-xs" href="#"></a>
                </div>
                <div class="navbar-collapse collapse">
                    <ul class="nav navbar-nav">
                        <li class="active"><a href="/"><span class="glyphicon glyphicon-home"></span></a></li>
                        <li>
                            <a href="/exchanges">Exchanges</a>
                        </li>
                        <li>
                            <a href="/members">Members</a>
                        </li>
                        <li>
                            <a href="/holidays">Holidays</a>
                        </li>
                        <li>
                            <a href="/contracts">Contracts</a>
                        </li>
                        <li>
                            <a href="/global-diary">Global Diary</a>
                        </li>
                        <li>
                            <a href="/glossary">Glossary</a>
                        </li>
                    </ul>

                    <% if (!IsAuthenticated)
                       { %>
                    <ul class="nav navbar-nav navbar-right alternate">
                        <li>
                            <a class="btn-hlight" href="/Login.aspx">Login</a>
                        </li>
                        <li>
                            <a class="btn-hlight" href="/Register.aspx">Register &nbsp;<span class="glyphicon glyphicon-user"></span></a>
                        </li>
                    </ul>
                    <% } %>
                </div>
            </div>
        </div>
    </div>
</div>
