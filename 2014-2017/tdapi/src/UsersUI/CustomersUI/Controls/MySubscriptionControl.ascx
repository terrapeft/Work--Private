<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MySubscriptionControl.ascx.cs" Inherits="CustomersUI.Controls.MySubscriptionControl" %>
<div>
    <h3 class="larger-caps" style="margin-bottom: -20px;">Available subscription packages</h3>

    <asp:MultiView runat="server" ID="multiView1">
        <Views>
            <asp:View ID="listPackagesView" runat="server">
                <asp:Repeater runat="server" ID="packagesRepeater" OnItemDataBound="packagesRepeater_OnItemDataBound">
                    <HeaderTemplate>
                        <table style="margin-left: 10px;" class="package-list">
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td valign="top">
                                <img src="/Content/Images/plus.png" class="package-expand-button" />
                            </td>
                            <td>
                                <asp:CheckBox CssClass="package-list-header" ID="CheckBox1" runat="server" value='<%# Eval("Id") %>' Text='<%# Eval("Name") %>' />
                                <div class="package-list-methods" runat="server" id="methodsDiv">
                                </div>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
                <table style="position: relative; top: 35px; right: 15px;" class="navbar-right">
                    <tr>
                        <td>
                            <asp:CheckBox runat="server" Checked="true" ID="notifyCheckBox" Text="Notify of acceptance by email" Style="margin-right: 10px;" /></td>
                        <td>
                            <asp:LinkButton runat="server" ID="saveButtonTop" OnClick="saveButton_OnClick" CssClass="btn-primary btn ">
        Send request
                            </asp:LinkButton></td>
                    </tr>
                </table>
                <br>
                <br>
                <br>
            </asp:View>
            <asp:View ID="afterSubmitView" runat="server">
                <div style="position: relative; top: 35px; margin-left: 0">
                    You can check the state of your request on <a href="/account">My Account page</a>.
                    <br>
                    <br>
                </div>
            </asp:View>
        </Views>
    </asp:MultiView>
</div>

<script>
    $(document).ready(function () {
        $(".package-list-methods").hide();
        $(".package-expand-button").click(function () {
            $(this).parent().parent().find('.package-list-methods').slideToggle(500);
            var cv = $(this).attr('src');
            $(this).attr('src', cv == '/Content/Images/plus.png' ? '/Content/Images/minus.png' : '/Content/Images/plus.png');
        });
    });
</script>
