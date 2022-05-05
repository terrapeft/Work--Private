<%@ Page Language="C#" CodeBehind="Details.aspx.cs" Inherits="Statix.Details" %>

<%@ Register TagPrefix="ajaxToolkit" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit, Version=4.1.7.1213, Culture=neutral, PublicKeyToken=28f01b0e84b6d53e" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" />
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css" />
    <link href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" type="text/css" />
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet" />
    <link href="~/Content/Css/checkbox-buttons.css" rel="stylesheet" type="text/css" />
    <link href="/Content/Css/Styles.css" rel="stylesheet" type="text/css" />    
    <link href="~/App_Themes/General/dd.css" rel="stylesheet" type="text/css" />

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
        <link type="text/css" href="/Content/css/ie8.css" rel="stylesheet" />
        <script src="//oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
        <script src="//oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <style>
	        .hide-ie8 {display:none}
        </style>
    <![endif]-->
    <!--[if lt IE 8]>
        <link href="/Content/css/bootstrap-ie7.css" rel="stylesheet">
    <![endif]-->

</head>
<body style="padding: 10px;">
    <form id="form1" runat="server">
        <ajaxToolkit:ToolkitScriptManager runat="server" EnablePartialRendering="true" CombineScripts="false" ID="ScriptManager1">
            <Scripts>
                <asp:ScriptReference Name="jquery" />
                <asp:ScriptReference Path="//code.jquery.com/ui/1.11.2/jquery-ui.min.js" />
                <asp:ScriptReference Path="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js" />
                <asp:ScriptReference Path="../../Content/Scripts/twitter-bootstrap-hover-dropdown.min.js" />
                <asp:ScriptReference Path="../../Content/Scripts/users-ui.js" />
            </Scripts>
        </ajaxToolkit:ToolkitScriptManager>
        <asp:DynamicDataManager ID="DynamicDataManager1" runat="server" AutoLoadForeignKeys="true">
            <DataControls>
                <asp:DataControlReference ControlID="FormView1" />
            </DataControls>
        </asp:DynamicDataManager>
        <asp:UpdateProgress ID="UpdateProgress1" Visible="true" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
            <ProgressTemplate>
                <div class="centered panel panel-green shadow progress-panel" style="padding-top: 10px">
                    <img src="/Content/Images/animated-progress.gif" alt="Processing...">
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:FormView runat="server" ID="FormView1" DataSourceID="DetailsDataSource" RenderOuterTable="false">
                    <ItemTemplate>
                        <div class="edit-in-place">
                            <table style="width: 100%" id="detailsTable" class="DDDetailsTable" cellpadding="6">
                                <asp:DynamicEntity runat="server" />
                            </table>
                        </div>
                    </ItemTemplate>
                    <EmptyDataTemplate>
                        <div class="DDNoItem">No such item.</div>
                    </EmptyDataTemplate>
                </asp:FormView>
                <asp:EntityDataSource ID="DetailsDataSource" runat="server" EnableDelete="true" />
                <asp:QueryExtender TargetControlID="DetailsDataSource" ID="DetailsQueryExtender" runat="server">
                    <asp:DynamicRouteExpression />
                </asp:QueryExtender>
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
    <script>top.postMessage('Loaded', window.location.href);</script>
</body>
</html>