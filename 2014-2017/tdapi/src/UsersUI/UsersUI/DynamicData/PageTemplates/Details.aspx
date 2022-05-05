<%@ Page Language="C#" MasterPageFile="~/Site.master" CodeBehind="Details.aspx.cs" Inherits="UsersUI.Details" %>

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

            <asp:FormView runat="server" ID="FormView1" DataSourceID="DetailsDataSource" OnDataBound="FormView1_OnDataBound" OnItemDeleted="FormView1_ItemDeleted" RenderOuterTable="false">
                <ItemTemplate>
                    <div class="edit-in-place">
                        <table id="detailsTable" class="DDDetailsTable round" cellpadding="6">
                            <asp:DynamicEntity runat="server" />
                            <tr>
                                <td colspan="2" align="right">
                                    <a title="Back" class="cancel-button command-button-right" href="javascript: window.history.back();">
                                        <img alt="Back" src="/Content/Images/back-in-view.png">
                                    </a>
                                    <asp:DynamicHyperLink ID="editLink" runat="server" CssClass="cancel-button command-button-right" Action="Edit" ToolTip="Edit" Text='<img alt="Edit" src="/Content/Images/edit-item.gif">' />
                                    <span style="position: relative; left: -13px; top: 2px;">
                                        <asp:ImageButton ID="deleteButton" CssClass="cancel-button command-button-right" runat="server" ToolTip="Delete..." ImageUrl="~/Content/Images/delete-item.gif" CommandName="Delete" Text="Delete" CausesValidation="false" OnClientClick='return confirm("Are you sure you want to delete this item?");' /></span>
                                </td>
                            </tr>
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

            <br />
            <%--
			<div class="DDBottomHyperLink">
				<asp:DynamicHyperLink ID="ListHyperLink" runat="server" Action="List">Show all items</asp:DynamicHyperLink>
			</div>
            --%>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

