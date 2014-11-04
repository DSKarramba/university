<%@ Page Language="C#" AutoEventWireup="true" CodeFile="code_5.cs" Inherits="Default2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
  <head runat="server">
    <title>Page 5: prediction | Lab 2</title>
    <link href="style.css" rel="stylesheet" type="text/css" />    
  </head>
  <body>
    <form id="frm5" class="main" runat="server">
      <div id="nav">
        Перейти на страницы:
        <asp:Button ID="btP1" runat="server" class="button"
            Width="50px" Text="1" OnCommand="bt_Click" CommandArgument="1" ToolTip="Мини-чат" />
        <asp:Button ID="btP2" runat="server" class="button"
            Width="50px" Text="2" OnCommand="bt_Click" CommandArgument="2" ToolTip="Мини-опрос" />
        <asp:Button ID="btP3" runat="server" class="button"
            Width="50px" Text="3" OnCommand="bt_Click" CommandArgument="3" ToolTip="Игра в города"/>
        <asp:Button ID="btP4" runat="server" class="button"
            Width="50px" Text="4" OnCommand="bt_Click" CommandArgument="4" ToolTip="Игра в угадайку"/>
        <asp:Button ID="btP5" runat="server" class="button_sel"
            Width="50px" Text="5" OnCommand="bt_Click" CommandArgument="5" ToolTip="Предсказания" />
      </div>
      <table style="border: 0px; vertical-align: middle; margin: auto;">
        <tr>
          <th>Никнейм:</th>
          <td>
            <asp:TextBox ID="tbN" runat="server" style="margin-left: 15px"
              Width="200px"></asp:TextBox> <br />
          </td>
          <td rowspan='2' style="width: 200px; text-align: center; font-weight: bold;">
            Мини-предсказание
          </td>
        </tr>
        <tr>
          <th>Вопрос:</th>
          <td>
            <asp:TextBox ID="tbQ" runat="server" style="margin-left: 15px"
              Width="200px"></asp:TextBox> <br />
          </td>
        </tr>
      </table>
      <div id="two_buttons">
        <asp:Button ID="btPush" class="button" runat="server"
            Width="150px" Text="Отправить" OnClick="btSave_Click" />
        <asp:Button ID="btClear" class="button" runat="server"
            Width="150px" Text="Очистить" OnClick="btClear_Click" />
      </div>
      <div style="text-align: center">
        <asp:TextBox ID="LOG" runat="server" TextMode="MultiLine"
            ReadOnly="True"></asp:TextBox>
      </div>
    </form>
  </body>
</html>
