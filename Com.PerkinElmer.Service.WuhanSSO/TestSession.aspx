<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TestSession.aspx.cs" Inherits="Com.PerkinElmer.Service.WuhanSSO.TestSession" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <%=Session[Com.PerkinElmer.Service.WuhanSSO.Global.USER_SESSION]%>
    </div>
    </form>
</body>
</html>
