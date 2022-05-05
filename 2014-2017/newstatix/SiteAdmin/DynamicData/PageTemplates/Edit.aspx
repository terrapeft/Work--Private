<%@ Page Language="C#" MasterPageFile="~/SiteAdmin.master" CodeBehind="Edit.aspx.cs" Inherits="UsersUI.Edit" ValidateRequest="false" %>
<%@ Register TagPrefix="uc" TagName="Breadcrumb" Src="../../Controls/BreadcrumbControl.ascx" %>


<asp:Content ID="headContent" ContentPlaceHolderID="head" runat="Server">
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
	<asp:DynamicDataManager ID="DynamicDataManager1" runat="server" AutoLoadForeignKeys="true">
		<DataControls>
			<asp:DataControlReference ControlID="FormView1" />
		</DataControls>
	</asp:DynamicDataManager>

    <uc:Breadcrumb runat="server" ID="BreadcrumbControl1" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
		<ContentTemplate>
			<asp:ValidationSummary ID="ValidationSummary1" runat="server" EnableClientScript="true"
				HeaderText="List of validation errors" CssClass="DDValidator" />
			<asp:DynamicValidator runat="server" ID="DetailsViewValidator" ControlToValidate="FormView1" Display="None" CssClass="DDValidator" />

			<asp:FormView runat="server" ID="FormView1" DataSourceID="DetailsDataSource" DefaultMode="Edit"
				OnItemCommand="FormView1_ItemCommand" OnItemUpdated="FormView1_ItemUpdated" RenderOuterTable="false">
				<EditItemTemplate>
					<div class="edit-in-place">
					<table id="detailsTable" class="DDDetailsTable round" cellpadding="6">
						<asp:DynamicEntity runat="server" Mode="Edit" />
						<tr>
							<td colspan="2" align="right">
                                <asp:ImageButton CssClass="cancel-button command-button-right" ID="ImageButton1" runat="server" ImageUrl="~/Content/Images/apply.gif" CommandName="Update" Text="Update" />
								<span style="position:relative; left: -13px; top: 2px;"><asp:ImageButton runat="server" ImageUrl="~/Content/Images/cancel.gif" CommandName="Cancel" Text="Cancel" CausesValidation="false" /></span>
							</td>
						</tr>
					</table></div>
				</EditItemTemplate>
				<EmptyDataTemplate>
					<div class="DDNoItem">No such item.</div>
				</EmptyDataTemplate>
			</asp:FormView>

			<asp:EntityDataSource ID="DetailsDataSource" runat="server" EnableUpdate="true" />

			<asp:QueryExtender TargetControlID="DetailsDataSource" ID="DetailsQueryExtender" runat="server">
				<asp:DynamicRouteExpression />
			</asp:QueryExtender>
		</ContentTemplate>
	</asp:UpdatePanel>
</asp:Content>

