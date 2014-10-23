<%@ Page Language="C#" AutoEventWireup="true" CodeFile="code.cs" Inherits="Default2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
  <head runat="server">
    <title>Page 2 | Lab 2</title>
  </head>
  <body>
    <form id="frm2" runat="server">
      <table style="border: 0px; vertical-align: middle">
        <tr>
          <th>Ваше имя:</th>
          <td>
            <asp:TextBox ID="tbN" runat="server" style="margin-left: 15px"
              Width="200px"></asp:TextBox> <br />
          </td>
          <td>
            <asp:Label ID="lblN" runat="server" Visible="False"></asp:Label>
          </td>
        </tr>
        <tr>
          <th>Ваш возраст:</th>
          <td>
            <asp:TextBox ID="tbA" runat="server" style="margin-left: 15px"
              Width="200px"></asp:TextBox> <br />
          </td>
          <td>
            <asp:Label ID="lblA" runat="server" Visible="False"></asp:Label>
          </td>
        </tr>
        <tr>
          <th>Ваш пол:</th>
          <td>
            <asp:DropDownList ID="ddlS" runat="server" style="margin-left: 15px" Width="200px">
              <asp:ListItem Value="0">мужской</asp:ListItem>
              <asp:ListItem Value="1">женский</asp:ListItem>
              <asp:ListItem Value="2">другой</asp:ListItem>
              <asp:ListItem Value="3">неизвестный</asp:ListItem>
            </asp:DropDownList>
          </td>
          <td>
            <asp:Label ID="lblS" runat="server" Visible="False"></asp:Label>
          </td>
        </tr>
      </table>
      <div>
        <asp:Button ID="btSave" runat="server" style="margin: 20px 0 0 20px" 
            Width="150px" Text="Записать значения" OnClick="btSave_Click" />
        <asp:Button ID="btClear" runat="server" style="margin: 20px 0 0 20px" 
            Width="150px" Text="Очистить сессию" OnClick="btClear_Click" />
      </div>
      <div>
        Перейти на страницы:
        <asp:Button ID="btP1" runat="server" style="margin: 10px 0 0 25px" 
            Width="50px" Text="1" OnCommand="bt_Click" CommandArgument="1" />
        <asp:Button ID="btP2" runat="server" style="margin: 10px 0 0 25px" 
            Width="50px" Text="2" OnCommand="bt_Click" CommandArgument="2" />
        <asp:Button ID="btP3" runat="server" style="margin: 10px 0 0 25px" 
            Width="50px" Text="3" OnCommand="bt_Click" CommandArgument="3" />
        <asp:Button ID="btP4" runat="server" style="margin: 10px 0 0 25px" 
            Width="50px" Text="4" OnCommand="bt_Click" CommandArgument="4" />
        <asp:Button ID="btP5" runat="server" style="margin: 10px 0 0 25px" 
            Width="50px" Text="5" OnCommand="bt_Click" CommandArgument="5" />
      </div>
    </form>
  </body>
</html>
