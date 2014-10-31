<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="main.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
  <head runat="server">
    <title>Акции | Чоко Пончики</title>
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
              <li class="selected">
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
            Ежегодно ИП <span class="bold">Чоко Пончики</span> проводит
            различные акции и конкурсы в честь праздников, например, на
            Новый год, День полярника, День китов и многие другие. <br />
            Каждые выходные проходит акция &quot;5&ndash;20&quot;: всем
            пингвинам младше 5 и старше 20 лет скидки на продукцию 80&#37;,
            так же всем полярникам вторая порция гомерических пончиков
            бесплатно.
          </p>
          <div class="post">
            <hr />
            <div class="post_wrapper">
              <img src="../img/event_east.jpg" style="height: 180px"/>
            </div>
            <p>
              <span class="bold" style="margin-right: 10px;">01.10.14</span>
              Конкурс <span class="bold">&quot;Пейзажи Антарктики&quot;</span>
              <br /> <br />
              
              Конкурс рисунков &quot;Пейзажи Антарктики&quot; среди полярников
              станции &quot;Восток&quot;. Спеши принять участие и выиграть
              вкусные призы! <br />
              Конкурс продлится до 12 декабря.
            </p>
          </div>
          <div class="post">
            <hr />
            <div class="post_wrapper">
              <img src="../img/prod_choc_ping.jpg" style="height: 180px"/>
            </div>
            <p>
              <span class="bold" style="margin-right: 10px;">15.06.14</span>
              Акция <span class="bold">&quot;Костюм с иголочки&quot;</span>
              <br /> <br />
              
              При покупке 2-х и более упаковок делового шоколада вы получаете
              в подарок шапку и галстук-бабочку выбранного вами цвета.
            </p>
          </div>
          <div class="post">
            <hr />
            <div class="post_wrapper">
              <img src="../img/event_pings.jpg" style="height: 180px"/>
            </div>
            <p>
              <span class="bold" style="margin-right: 10px;">02.02.14</span>
              Акция <span class="bold">&quot;Приведи с собой
              друзей&quot;</span>
              <br /> <br />
              
              За каждого приведенного друга получи две плитки повседневного
              шоколада в подарок!
            </p>
          </div>
          <hr />
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
