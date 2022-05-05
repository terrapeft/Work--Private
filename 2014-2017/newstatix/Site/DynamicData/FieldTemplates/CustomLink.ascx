<%@ Control Language="C#" CodeBehind="CustomLink.ascx.cs" Inherits="Statix.DynamicData.FieldTemplates.CustomLink" %>

<asp:Label class="disabled" runat="server" id="disabledLabel" Visible="false"/>
<a runat="server" title="Volumes" id="Link1" href="/view/{0}/{1}">View</a>
