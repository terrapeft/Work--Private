<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EntityDataControl.ascx.cs" Inherits="CustomersUI.Controls.EntityDataControl" %>

<asp:Repeater ID="repeater1" runat="server">
	<HeaderTemplate>
		<table id="detailsTable" class="DDDetailsTable" cellpadding="6" width="100%">
	</HeaderTemplate>
	<ItemTemplate>
		<tr class="tr-item">
			<td class="de-name" >
				<%#Eval("PropertyName")%>
			</td>
			<td class="de-value" >
				<%# Eval("PropertyValue").ToString()%>
			</td>
		</tr>
	</ItemTemplate>
	<AlternatingItemTemplate>
		<tr class="tr-alt">
			<td class="de-name-alt" >
				<%#Eval("PropertyName")%>
			</td>
			<td class="de-value-alt">
				<%#Eval("PropertyValue").ToString()%>
			</td>
		</tr>
	</AlternatingItemTemplate>
	<FooterTemplate>
		</table>
	</FooterTemplate>
</asp:Repeater>
