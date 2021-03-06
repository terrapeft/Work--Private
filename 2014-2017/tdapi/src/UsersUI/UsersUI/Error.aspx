<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Error.aspx.cs" Inherits="UsersUI.Error" %>
<%@ Import Namespace="System.Globalization" %>
<%@ Import Namespace="UsersDb" %>
<%@ Import Namespace="UsersDb.DataContext" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
	<title>TradeData Administrative Interface</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" />
	<link href="~/Content/Css/Site.css" rel="stylesheet" type="text/css" />
</head>

<body>

	<div class="table-bordered centered">
		<div class="panel-body">
			<h3>Sorry, An Error Has Occurred</h3>
			<br />
			An error has occurred during current request.<br />
			<br />
			Please <a href="mailto:<%=UsersDb.ServiceConfig.Error_500_Contact_Person %>&Subject=FOWTDAPI UI Error 500&Body=Reported at <%=DateTime.Now.ToString(CultureInfo.InvariantCulture)%> local time.">contact us</a>.
			<% if (UsersDataContext.IsAdministrator) {%>
			<br>
			<br>
			 <a href="/elmah.axd">View details.</a>
			<% } %>
		</div>
	</div>

</body>
</html>