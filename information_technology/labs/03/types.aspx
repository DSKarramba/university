<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="types.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title>Страница Types</title>
  <link href="style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="frm5" class="main" runat="server">
      <div id="nav">
        Перейти на страницы: <br />
        <asp:Button ID="btP1" runat="server" class="button"
            Text="or_det" OnCommand="bt_Click" CommandArgument="orderdetail" />
        <asp:Button ID="btP2" runat="server" class="button"
            Text="order" OnCommand="bt_Click" CommandArgument="order" />
        <asp:Button ID="btP3" runat="server" class="button"
            Text="sellers" OnCommand="bt_Click" CommandArgument="sellers" />
        <asp:Button ID="btP4" runat="server" class="button"
            Text="clients" OnCommand="bt_Click" CommandArgument="clients" />
        <asp:Button ID="btP5" runat="server" class="button_sel"
            Text="types" OnCommand="bt_Click" CommandArgument="types" />
        <asp:Button ID="btP6" runat="server" class="button"
            Text="goods" OnCommand="bt_Click" CommandArgument="goods" />
        <asp:Button ID="btP7" runat="server" class="button"
            Text="groups" OnCommand="bt_Click" CommandArgument="groups" />
      </div>
      <div>
        <table class="data" id='TableTypes' runat="server">
          <tr>
            <th>i_id_type</th>
            <th>vc_name</th>
          </tr>
        </table>
      </div>
      <div>
        <asp:SqlDataSource ID="dsT" runat="server" 
          ConnectionString="<%$ ConnectionStrings:labsConnectionString %>" 
          SelectCommand="SELECT tbTypes.* FROM tbTypes" 
          DataSourceMode="DataReader"></asp:SqlDataSource>
      </div>
    </form>
</body>
</html>
