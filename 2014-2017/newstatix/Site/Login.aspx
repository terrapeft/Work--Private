<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Statix.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Statix Login</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.css" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap-theme.css" />
    <link href="~/App_Themes/General/Site.css" rel="stylesheet" type="text/css" />
    <link href="~/Content/Css/Styles.css" rel="stylesheet" type="text/css" />
</head>

<body>
    <form runat="server">
        <asp:Panel ID="Panel1" runat="server" CssClass="container centered" DefaultButton="btnSubmit">
            <div style="width: 320px" class="panel panel-default centered shadow">
                <div class="panel-heading">
                    <table width="100%">
                        <tr>
                            <td>
                                <h3 class="panel-title no-wrap">Members area</h3>
                            </td>
                            <td align="right">
                                <img style="width: 95px;" src="App_Themes/General/Images/logo.png" />
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="clear" style="margin: 15px;">
                    <asp:Label ID="errorLabel" runat="server" Visible="false">
                        <br>
                        Invalid username and / or password.
                        <br>
                        <br>
                        If you have forgotten your password please contact your Account Manager <a href="mailto:sales@fowtradedata.com">sales@fowtradedata.com</a> or call us on  +44 (0)1277 633777&nbsp;<br>
                        <br>
                        <br>
                    </asp:Label>
                    <div class="input-group">
                        <label class="input-group-addon" for="<%= txtUserName.ClientID %>">Email</label>
                        <asp:TextBox ID="txtUserName" CssClass="form-control" placeholder="Enter email" runat="server" />
                    </div>
                    <div class="input-group">
                        <label class="input-group-addon">Password</label>
                        <asp:TextBox ID="txtUserPass" runat="server" CssClass="form-control" TextMode="Password" placeholder="Enter password" autocomplete="off" />
                    </div>
                    <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_OnClick" Text="Login" CssClass="btn btn-default" />
                    <asp:Button ID="btnSignUp" runat="server" Text="Register" CssClass="btn btn-default" OnClick="btnSignUp_OnClick" />
                    <label for="rememberMeCheckBox" class="pull-right" style="position: relative; top: 10px">
                        <input id="rememberMeCheckBox" type="checkbox" runat="server" />
                        <span style="position: relative; top: -2px; left: -3px;">Remember me</span>
                    </label>
                </div>
            </div>
        </asp:Panel>
    </form>
</body>
</html>
