<%@ Control Language="C#" CodeBehind="EmailTemplate.ascx.cs" Inherits="UsersUI.DynamicData.FieldTemplates.EmailTemplate" %>
<%@ Import Namespace="UsersDb" %>
<br>
<b>Format:</b>&nbsp;&nbsp;<span runat="server" id="formatSpan"><%= ServiceConfig.Trial_Notification_Email_Format%></span>
<span class="admin-reference">&nbsp;<%= Resources.TrialAdmin_Reference_to_Trial_CUI_Group%></span><br>
<b>Subject:</b>&nbsp;&nbsp;<span runat="server" id="subjSpan"></span><br>
<br>
<strong>NB!</strong> Template contains URLs with hardcoded database alias, which must be updated in case of alias change.
<br>
<br>
<iframe runat="server" id="previewIframe" style="width: 100%; height: 450px; border: solid 1px #d3d3d3"></iframe>
<div runat="server" id="Literal1"></div>