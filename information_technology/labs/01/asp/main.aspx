<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="main.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
  <head runat="server">
    <title>Главная | Чоко Пончики</title>
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
                <asp:LinkButton id="lb_main" text="Главная" runat="server"
                  OnClick="lb_main_Click" />
              </li>
              <li>
                <asp:LinkButton id="lb_goods" text="Продукция" runat="server"
                  OnCommand="Redirect" CommandArgument="goods" />
              </li>
              <li>
                <asp:LinkButton id="lb_event" text="Акции" runat="server"
                  OnCommand="Redirect" CommandArgument="event" />
              </li>
              <li>
                <asp:LinkButton id="lb_job" text="Вакансии" runat="server"
                  OnCommand="Redirect" CommandArgument="job" />
              </li>
              <li>
                <asp:LinkButton id="lb_contacts" text="Контакты" runat="server"
                  OnCommand="Redirect" CommandArgument="contacts" />
              </li>
            </ul>
          </div>
        </div>
        <div id="content">
          <p>
            В настоящее время ИП <span class="bold">&quot;Чоко Пончики&quot;
            </span> является лучшим и единственным кондитерским предприятием в
            Антарктиде. В ассортименте предприятия более 25 наименований
            кондитерских изделий (пончиков, конфет, шоколада, зефира, и т. д.).
          </p>
          <div id="main_img">
            <img src="img/factory.jpg" style="height: 200px"/>
            <img src="img/worker.jpg"
              style="height: 200px; margin-left: 20px"/>
          </div>
          <p>
            Особой заботой руководства предприятия является отслеживание
            качества продукции и поддержка ее на должном уровне. <br />
            Продукция фабрики пользуется особым спросом среди местного
            населения, а также туристов и эмигрантов из других стран со всех
            континентов.
          </p>
        </div>
        <div id="footer">
          <span>
            Вся информация на данном сайте является плодом фантазии автора.
            Просьба не воспринимать ее всерьез. Все изображения на сайте были
            взяты из публичных источников, либо сделаны из таковых.
          </span>
        </div>
      </div>
    </form>
  </body>
</html>
