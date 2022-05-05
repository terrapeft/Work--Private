<%@ Page Language="C#" CodeBehind="Register.aspx.cs" Inherits="Statix._Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Statix Register</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.css" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap-theme.css" />
    <link href="/App_Themes/General/Site.css" rel="stylesheet" type="text/css" />
    <link href="/Content/Css/Styles.css" rel="stylesheet" type="text/css" />
</head>

<body>
    <form runat="server">
        <asp:Panel ID="Panel1" runat="server" CssClass="container centered" DefaultButton="btnSubmit">
            <div style="width: 320px" class="panel panel-default centered shadow">
                <div class="panel-heading">
                    <table width="100%">
                        <tr>
                            <td>
                                <h3 class="panel-title no-wrap">Registration</h3>
                            </td>
                            <td align="right">
                                <img style="width: 95px;" src="App_Themes/General/Images/logo.png" />
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="clear" style="margin: 15px;">
                    <asp:Label ID="confirmationLabel" runat="server" Visible="false"/>
                    <div class="input-group">
                        <label class="input-group-addon">Name</label>
                        <asp:TextBox ID="txtUserName" runat="server" CssClass="form-control" placeholder="Enter name" autocomplete="off" />
                    </div>
                    <div class="input-group">
                        <label class="input-group-addon">Email</label>
                        <asp:TextBox ID="txtUserEmail" CssClass="form-control" placeholder="Enter email" runat="server" />
                    </div>
                    <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_OnClick" Text="Send Request" CssClass="btn btn-default" />
                </div>
            </div>
        </asp:Panel>
    </form>
</body>
</html>
