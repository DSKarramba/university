<%@ Page Language="C#" AutoEventWireup="true" CodeFile="code_2.cs" Inherits="Default2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
  <head runat="server">
    <title>Page 2: poll | Lab 2</title>
    <link href="style.css" rel="stylesheet" type="text/css" />    
  </head>
  <body>
    <form id="frm2" class="main" runat="server">
      <div id="nav">
        Перейти на страницы:
        <asp:Button ID="btP1" runat="server" class="button"
            Width="50px" Text="1" OnCommand="bt_Click" CommandArgument="1" ToolTip="Мини-чат" />
        <asp:Button ID="btP2" runat="server" class="button_sel"
            Width="50px" Text="2" OnCommand="bt_Click" CommandArgument="2" ToolTip="Мини-опрос" />
        <asp:Button ID="btP3" runat="server" class="button"
            Width="50px" Text="3" OnCommand="bt_Click" CommandArgument="3" ToolTip="Игра в города"/>
        <asp:Button ID="btP4" runat="server" class="button"
            Width="50px" Text="4" OnCommand="bt_Click" CommandArgument="4" ToolTip="Игра в угадайку"/>
        <asp:Button ID="btP5" runat="server" class="button"
            Width="50px" Text="5" OnCommand="bt_Click" CommandArgument="5" ToolTip="Предсказания" />
      </div>
      <table style="border: 0px; vertical-align: middle; margin: auto;">
        <tr>
          <th>Никнейм:</th>
          <td>
            <asp:TextBox ID="tbN" runat="server" style="margin-left: 15px"
              Width="200px"></asp:TextBox> <br />
          </td>
          <td style="width: 200px; text-align: center; font-weight: bold;">
            Мини-опрос
          </td>
        </tr>
      </table>
      <table id="quests">
        <tr>
          <th> Вы любите печеньки? </th>
          <td><asp:RadioButton ID="rbC1" runat="server" GroupName="Cookies" Text="Да" 
            Checked="True" />
          <td><asp:RadioButton ID="rbC2" runat="server" GroupName="Cookies" Text="Нет" /></td>
          <td><asp:RadioButton ID="rbC3" runat="server" GroupName="Cookies" Text="OM-NOM-NOM" /></td>
        </tr>
        <tr>
          <th> С какой стороны нужно начинать кушать рогалик? </th>
          <td><asp:RadioButton ID="rbL1" runat="server" GroupName="LuckyStar" 
              Text="С узкой" Checked="True" /></td>
          <td><asp:RadioButton ID="rbL2" runat="server" GroupName="LuckyStar" Text="С широкой" /></td>
          <td><asp:RadioButton ID="rbL3" runat="server" GroupName="LuckyStar" Text="С верхней" /></td>
        </tr>
        <tr>
          <th> Эль, Пси, ... </th>
          <td><asp:RadioButton ID="rbS1" runat="server" GroupName="SteinsGate" Text="Омега" 
              Checked="True" /></td>
          <td><asp:RadioButton ID="rbS2" runat="server" GroupName="SteinsGate" Text="Конгру" /></td>
          <td><asp:RadioButton ID="rbS3" runat="server" GroupName="SteinsGate" Text="Манго" /></td>
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
