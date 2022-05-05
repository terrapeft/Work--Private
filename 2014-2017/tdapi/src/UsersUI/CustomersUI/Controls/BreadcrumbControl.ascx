<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="BreadcrumbControl.ascx.cs" Inherits="CustomersUI.Controls.BreadcrumbControl" %>
<%@ Import Namespace="System.Globalization" %>
<%@ Import Namespace="System.IO" %>

<div class="bdr-btm-dotted spc-pad-vrt spc-vrt-lrg">
    <span>My <%= CultureInfo.CurrentUICulture.TextInfo.ToTitleCase(Path.GetFileNameWithoutExtension(CurrentPage)) %></span>
</div>
