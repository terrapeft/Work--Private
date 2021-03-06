<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Popup.aspx.cs" Inherits="Statix.Popup" %>

<%@ Register TagPrefix="dd" Src="/DynamicData/PageTemplates/Controls/ListControl.ascx" TagName="list" %>
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
        <dd:list ID="List1" PageSize="10" HideHeader="True" runat="server" />
    </form>
    <script>top.postMessage('Loaded', window.location.href);</script>
</body>
</html>
