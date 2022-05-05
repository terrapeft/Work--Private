<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Informers.ascx.cs" Inherits="UsersUI.Controls.Informers" %>
<%@ Import Namespace="UsersDb" %>

<div>
	<script>
	    var updateInformersInterval = <%= ServiceConfig.Home_Page_Refresh_Interval * 60000 %>;
	</script>

	<img class="hpButton on-top" id="editLayoutButton" src="../Content/Images/edit.png" title="Edit">
	<img class="hpButton hpOk on-top" id="applyChangesButton" src="../Content/Images/ok.png" title="Apply and Save">
	<asp:ImageButton runat="server" CssClass="hpButton hpCancel on-top" ID="cancelChangesButton" ToolTip="Cancel" ImageUrl="~/Content/Images/cancel.png" OnClick="cancelChangesButton_OnClick" />
    <img class="hpButton hpRearrange on-top" id="rearrangeButton" src="../Content/Images/rearrange.png" title="Rearrange informers">
	<asp:Repeater runat="server" DataSourceID="repeaterDataSource" OnItemDataBound="repeater_ItemDataBound">
		<ItemTemplate>
			<div id="<%# Eval("Id") %>" class="informer" style="<%# Eval("InformerStyle") %>; background-color: <%# Eval("ContentColor") %>">
				<div class="informer-header" style="<%# Eval("TitleStyle") %>; background-color: <%# Eval("HeaderColor") %>"><%# Eval("Title") %></div>
				<div class="informer-content" style="<%# Eval("ContentStyle") %>">
					<asp:Xml ID="contentXml" runat="server" />
				</div>
				<div runat="server" id="footerDiv" class="informer-footer pull-bottom"/>
			</div>
		</ItemTemplate>
	</asp:Repeater>

	<asp:EntityDataSource ID="repeaterDataSource" runat="server" ConnectionString="name=UsersEntities" DefaultContainerName="UsersEntities" EnableFlattening="False" EntitySetName="Informers" EntityTypeFilter="Informer" OrderBy="it.Id" />

</div>
