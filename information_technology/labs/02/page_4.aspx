<%@ Page Language="C#" AutoEventWireup="true" CodeFile="code_4.cs" Inherits="Default2" %>

<%@ Register assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI" tagprefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
  <head runat="server">
    <title>Page 4: guess | Lab 2</title>
    <link href="style.css" rel="stylesheet" type="text/css" />    
  </head>
  <body>
    <form id="frm4" class="main" runat="server">
      <div id="nav">
        Перейти на страницы:
        <asp:Button ID="btP1" runat="server" class="button"
            Width="50px" Text="1" OnCommand="bt_Click" CommandArgument="1" ToolTip="Мини-чат" />
        <asp:Button ID="btP2" runat="server" class="button"
            Width="50px" Text="2" OnCommand="bt_Click" CommandArgument="2" ToolTip="Мини-опрос" />
        <asp:Button ID="btP3" runat="server" class="button"
            Width="50px" Text="3" OnCommand="bt_Click" CommandArgument="3" ToolTip="Игра в города"/>
        <asp:Button ID="btP4" runat="server" class="button_sel"
            Width="50px" Text="4" OnCommand="bt_Click" CommandArgument="4" ToolTip="Игра в угадайку"/>
        <asp:Button ID="btP5" runat="server" class="button"
            Width="50px" Text="5" OnCommand="bt_Click" CommandArgument="5" ToolTip="Предсказания" />
      </div>
      <table style="border: 0px; vertical-align: middle; margin: auto auto 15px;">
        <tr>
          <th>Никнейм:</th>
          <td>
            <asp:TextBox ID="tbN" runat="server" style="margin-left: 15px"
              Width="200px"></asp:TextBox> <br />
          </td>
          <td style="width: 200px; text-align: center; font-weight: bold;">
            Мини-игра в угадайку
          </td>
        </tr>
      </table>
      <table id="shells">
        <tr>
          <td>
            <asp:image runat="server" ImageUrl="img/box.png" id="img0" />
          </td>
          <td>
            <asp:image runat="server" ImageUrl="img/box.png" id="img1" />
          </td>
          <td>
            <asp:image runat="server" ImageUrl="img/box.png" id="img2" />
          </td>
          <td>
            <asp:image runat="server" ImageUrl="img/box.png" id="img3" />
          </td>
          <td>
            <asp:image runat="server" ImageUrl="img/box.png" id="img4" />
          </td>
        </tr>
        <tr>
          <td>
            <asp:RadioButton ID="rb0" runat="server" checked="true" GroupName="box" />
          </td>
          <td>
            <asp:RadioButton ID="rb1" runat="server" GroupName="box" />
          </td>
          <td>
            <asp:RadioButton ID="rb2" runat="server" GroupName="box" />
          </td>
          <td>
            <asp:RadioButton ID="rb3" runat="server" GroupName="box" />
          </td>
          <td>
            <asp:RadioButton ID="rb4" runat="server" GroupName="box" />
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
