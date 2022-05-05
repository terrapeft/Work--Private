<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SimplePager.ascx.cs" Inherits="CustomersUI.Controls.Pager.SimplePager" %>

<asp:HiddenField runat="server" ID="totalPagesField" />

<ul class="pagination pull-right" style="margin: 0">
    <li class="first">
        <asp:LinkButton CommandName="first" CommandArgument="0" runat="server" ID="firstButton" OnCommand="button_OnCommand">
            <i class="fa fa-chevron-left"></i><i class="fa fa-chevron-left"></i>
        </asp:LinkButton>
    </li>
    <li class="prev">
        <asp:LinkButton CommandName="prev" runat="server" ID="prevButton" OnCommand="button_OnCommand">
            <i class="fa fa-chevron-left"></i>
        </asp:LinkButton>
    </li>
    <asp:Repeater ID="pagerRepeater" runat="server" OnItemCommand="pagerRepeater_ItemCommand">
        <ItemTemplate>
            <li class="<%# Eval("Class") %>">
                <asp:LinkButton CommandName="page" CommandArgument='<%# Eval("PageNum") %>' Text='<%# Eval("Text") %>' runat="server" />
            </li>
        </ItemTemplate>
    </asp:Repeater>
    <li class="next">
        <asp:LinkButton CommandName="next" runat="server" ID="nextButton" OnCommand="button_OnCommand">
            <i class="fa fa-chevron-right"></i>
        </asp:LinkButton>
    </li>
    <li class="last">
        <asp:LinkButton CommandName="Last" runat="server" ID="lastButton" OnCommand="button_OnCommand">
            <i class="fa fa-chevron-right"></i><i class="fa fa-chevron-right"></i>
        </asp:LinkButton>
    </li>
</ul>
