<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="main.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
  <head runat="server">
    <title>Вакансии | Чоко Пончики</title>
    <link rel="stylesheet" href="../css/style.css" type="text/css" />
    <link rel="shortcut icon" href="../img/favicon.ico" type="image/x-icon" />
  </head>
  <body>
    <form id="frm_main" runat="server">
      <div id="main">
        <div id="header">
          <div class="nav">
            <ul id="nav">
              <li>
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
              <li class="selected">
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
            В связи с развитием компании приглашаем на постоянную работу:
          </p>
          <ul class="list">
            <li>
              продавцов кондитерских изделий в фирменный павильон;
            </li>
            <li>
              кондитеров;
            </li>
            <li>
              пекарей;
            </li>
            <li>
              тестомесов;
            </li>
            <li>
              халвомесов;
            </li>
            <li>
              уборщиц.
            </li>
          </ul>

          <p>
            Условия: стабильная работа на фабрике по производству кондитерских
            изделий, высокая и своевременная оплата труда, полы с подогревом,
            официальные перерывы на горячий чай. <br />

            Требования: активность, ответственность, творческий подход к
            работе. <br />

            Пингвинам предоставляются услуги по подниманию с пола в случае ЧП.
          </p>
          
          <hr />
          
          <p>
            Резюме можно прислать в отдел по работе с персоналом:
            <span class="bold">illaech@gmail.com</span>.
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
