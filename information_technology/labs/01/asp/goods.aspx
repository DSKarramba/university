<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="main.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
  <head runat="server">
    <title>Продукция | Чоко Пончики</title>
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
              <li class="selected">
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
            В ассортименте <span class="bold">&quot;Чоко Пончики&quot;</span>
            26 наименований кондитерских изделий. Самые успешные товары по
            мнению наших покупателей:
          </p>
          
          <table>
            <tr>
              <th rowspan="2">
                <img src="../img/prod_choc_ping.jpg" style="height: 200px"/>
              </th>
              <td class="note">Шоколад &quot;Деловой&quot;</td>
            </tr>
            <tr>
              <td class="slogan">Надеть галстук перед поеданием</td>
            </tr>
          </table>
          
          <table>
            <tr>
              <th rowspan="2">
                <img src="../img/prod_cc_whales.jpg" style="height: 200px"/>
              </th>
              <td class="note">Кексы &quot;Касаточка&quot;</td>
            </tr>
            <tr>
              <td class="slogan">Съешь или будешь съеден</td>
            </tr>
          </table>
          
          <table>
            <tr>
              <th rowspan="2">
                <img src="../img/prod_don_simp.jpg" style="height: 200px"/>
              </th>
              <td class="note">Пончик &quot;Гомерический&quot;</td>
            </tr>
            <tr>
              <td class="slogan">Ммм&hellip; пончик</td>
            </tr>
          </table>
          
          <table>
            <tr>
              <th rowspan="2">
                <img src="../img/prod_sw_bear.jpg" style="height: 200px"/>
              </th>
              <td class="note">Конфеты &quot;Белый мишка&quot;</td>
            </tr>
            <tr>
              <td class="slogan">Найди себе мишку по вкусу</td>
            </tr>
          </table>
          
          <table>
            <tr>
              <th rowspan="2">
                <img src="../img/prod_mm_choc.jpg" style="height: 200px"/>
              </th>
              <td class="note">Зефир &quot;В шоколаде&quot;</td>
            </tr>
            <tr>
              <td class="slogan">Просто зефир в шоколаде</td>
            </tr>
          </table>
          
          <table>
            <tr>
              <th rowspan="2">
                <img src="../img/prod_choc_fish.png" style="height: 200px"/>
              </th>
              <td class="note">Темный шоколад &quot;Повседневный&quot;</td>
            </tr>
            <tr>
              <td class="slogan">Разнообразь свой рыбный рацион рыбным
                десертом</td>
            </tr>
          </table>
          
          <table>
            <tr>
              <th rowspan="2">
                <img src="../img/prod_choc_diag.jpg" style="height: 200px"/>
              </th>
              <td class="note">Шоколад &quot;Диаграмма&quot;</td>
            </tr>
            <tr>
              <td class="slogan">Самое время подправить результаты</td>
            </tr>
          </table>
          
          <hr />
          <p>
            С отзывами, пожеланиями и предложениями по поводу выпускаемой
            продукции обращаться в отдел по связям с общественностью по
            электронной почте: <span class="bold">illaech@gmail.com</span>.
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
