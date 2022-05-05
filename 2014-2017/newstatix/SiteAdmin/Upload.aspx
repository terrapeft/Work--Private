<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Upload.aspx.cs" MasterPageFile="SiteAdmin.master" Inherits="AdministrativeUI.Upload" %>

<asp:Content ID="headContent" ContentPlaceHolderID="head" runat="Server">
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdateProgress ID="UpdateProgress1" Visible="true" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
        <ProgressTemplate>
            <div class="centered panel panel-green shadow progress-panel" style="padding-top: 10px">
                <img src="/Content/Images/animated-progress.gif" alt="Processing...">
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="Container">
                <div class="col-md-6 col-md-offset-3">
                    <table class="upload-table">
                        <tr>
                            <td>
                                <asp:ValidationSummary ID="ValidationSummary1" runat="server" EnableClientScript="true"
                                    DisplayMode="SingleParagraph"
                                    CssClass="DDValidator" />
                            </td>
                        </tr>
                        <tr>
                            <td style="vertical-align: top; padding-bottom: 20px;">
                                <table width="100%">
                                    <tr>
                                        <td><b>Theme:</b></td>
                                        <td>
                                            <asp:DropDownList runat="server" CssClass="DDFilter" AutoPostBack="True" ID="themeDdl">
                                                <Items>
                                                    <asp:ListItem Text="Statix" Value="General" />
                                                    <asp:ListItem Text="Newedge" Value="Newedge" />
                                                    <asp:ListItem Text="BNP Paribas" Value="Bp2s" />
                                                </Items>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><b>PNG&nbsp;only:</b></td>
                                        <td>
                                            <div class="input-group">
                                                <span class="input-group-btn">
                                                    <span class="btn btn-default btn-file">Browse…
                                            <input type="file" runat="server" id="fileUpload1" />
                                                    </span>
                                                </span>
                                                <input type="text" class="form-control" upload-file>
                                                <span class="input-group-btn">
                                                    <button class="btn btn-default" title="Upload" runat="server" onserverclick="uploadButton_OnClick">
                                                        <span class="glyphicon glyphicon-upload"></span>
                                                    </button>
                                                </span>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td style="vertical-align: top; text-align: center;">
                                <div style="border: 1px dashed #ccc; padding: 20px; margin: 0 2px;">
                                    <img runat="server" id="currentBannerImg" />
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
