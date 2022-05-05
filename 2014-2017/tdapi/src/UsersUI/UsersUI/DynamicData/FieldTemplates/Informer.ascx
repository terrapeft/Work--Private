<%@ Control Language="C#" CodeBehind="Informer.ascx.cs" Inherits="UsersUI.DynamicData.FieldTemplates.Informer" %>

<asp:HyperLink ID="HyperLink1" runat="server"
    Text="<%# GetDisplayString() %>"
    NavigateUrl="<%# GetNavigateUrl() %>"  />

