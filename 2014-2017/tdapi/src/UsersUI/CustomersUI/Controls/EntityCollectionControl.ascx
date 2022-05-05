<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EntityCollectionControl.ascx.cs" Inherits="CustomersUI.Controls.EntityCollectionControl" %>
<%@ Import Namespace="System.Data.Objects.DataClasses" %>
<%@ Register TagPrefix="uc" TagName="EntityData" Src="~/Controls/EntityDataControl.ascx" %>

<ul id="pagination" class="pagination-sm pull-right"></ul>
<br />
<div>
    <div id="page-content">
        <asp:Repeater ID="repeater1" runat="server" OnItemDataBound="repeater1_OnItemDataBound">
            <ItemTemplate>
                <div id="request-container">
                    <h4><strong>Request Id: <%# Eval("Id") %></strong></h4>
                    <uc:EntityData ID="requestEntity" runat="server" Entity="<%# (EntityObject)Container.DataItem %>" />
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</div>
<script>
    var pager = new SimplePager();

    $('#pagination').twbsPagination({
        totalPages: Math.ceil($('#page-content #request-container').length / pager.requestsPerPage),
        visiblePages: 5,
        loop: false,
        first: "<i class='fa fa-chevron-left'></i><i class='fa fa-chevron-left'></i>",
        prev: "<i class='fa fa-chevron-left'>",
        next: "<i class='fa fa-chevron-right'></i>",
        last: "<i class='fa fa-chevron-right'></i><i class='fa fa-chevron-right'></i>",
        disabledClass: "",
        onPageClick: function (event, page) {
            pager.showPage(page);
        }
    });

    pager.requestsPerPage = 3;
    pager.paragraphs = $('#page-content #request-container');
    pager.showPage(1);
</script>
