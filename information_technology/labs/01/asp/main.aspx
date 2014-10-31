<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="main.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
  <head runat="server">
    <title>������� | ���� �������</title>
    <link rel="stylesheet" href="../css/style.css" type="text/css" />
    <link rel="shortcut icon" href="../img/favicon.ico" type="image/x-icon" />
  </head>
  <body>
    <form id="frm_main" runat="server">
      <div id="main">
        <div id="header">
          <div class="nav">
            <ul id="nav">
              <li class="selected">
                <asp:LinkButton id="lb_main" text="�������" runat="server"
                  OnClick="lb_main_Click" />
              </li>
              <li>
                <asp:LinkButton id="lb_goods" text="���������" runat="server"
                  OnCommand="Redirect" CommandArgument="goods" />
              </li>
              <li>
                <asp:LinkButton id="lb_event" text="�����" runat="server"
                  OnCommand="Redirect" CommandArgument="event" />
              </li>
              <li>
                <asp:LinkButton id="lb_job" text="��������" runat="server"
                  OnCommand="Redirect" CommandArgument="job" />
              </li>
              <li>
                <asp:LinkButton id="lb_contacts" text="��������" runat="server"
                  OnCommand="Redirect" CommandArgument="contacts" />
              </li>
            </ul>
          </div>
        </div>
        <div id="content">
          <p>
            � ��������� ����� �� <span class="bold">&quot;���� �������&quot;
            </span> �������� ������ � ������������ ������������ ������������ �
            ����������. � ������������ ����������� ����� 25 ������������
            ������������ ������� (��������, ������, ��������, ������, � �. �.).
          </p>
          <div id="main_img">
            <img src="img/factory.jpg" style="height: 200px"/>
            <img src="img/worker.jpg"
              style="height: 200px; margin-left: 20px"/>
          </div>
          <p>
            ������ ������� ����������� ����������� �������� ������������
            �������� ��������� � ��������� �� �� ������� ������. <br />
            ��������� ������� ���������� ������ ������� ����� ��������
            ���������, � ����� �������� � ���������� �� ������ ����� �� ����
            �����������.
          </p>
        </div>
        <div id="footer">
          <span>
            ��� ���������� �� ������ ����� �������� ������ �������� ������.
            ������� �� ������������ �� �������. ��� ����������� �� ����� ����
            ����� �� ��������� ����������, ���� ������� �� �������.
          </span>
        </div>
      </div>
    </form>
  </body>
</html>
