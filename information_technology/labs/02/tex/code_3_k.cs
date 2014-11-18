using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

public partial class Default2 : System.Web.UI.Page
{
  public List<string> citylist = new List<string>{
    "Москва",    "Санкт-Петербург", "Новосибирск", "Екатеринбург", "Нижний Новгород",
    "Казань",    "Самара",          "Омск",        "Челябинск",    "Ростов-на-Дону",
    "Уфа",       "Волгоград",       "Красноярск",  "Пермь",        "Воронеж",
    "Саратов",   "Краснодар",       "Тольятти",    "Тюмень",       "Ижевск",
    "Барнаул",   "Ульяновск",       "Иркутск",     "Владивосток",  "Ярославль",
    "Хабаровск", "Махачкала",       "Оренбург",    "Новокузнецк",  "Томск",
    "Кемерово",  "Рязань",          "Астрахань",   "Пенза",        "Набережные Челны",
    "Липецк"
  };
  
  protected void Page_Load(object sender, EventArgs e)
  {
    if (Session["list"] != null)
    {
      List<string> l = (List<string>)Session["list"];
      LOG.Text = String.Join("\n", l);
    }
    else
    {
      Session["list"] = new List<string>{};
    }
    
    if (Session["used"] == null)
    {
      bool[] u = Enumerable.Repeat(false, citylist.Count).ToArray();
      int i = 0, ch = -1;
      char letter = '0';
      string cityname;
      object[] x = {true}, y;
      
      while (ch == -1)
      {
        i = (new Random()).Next(u.Length);
        cityname = citylist[i];
        y = LetterAcc(cityname, u);
        ch = (int)y[0];
        letter = (char)y[1];
      }
      u[i] = true;

      Session["used"] = u;
      Session["letter"] = letter;

      List<string> li = (List<string>)Session["list"];

      string message = String.Format("\"{0}\"", citylist[i]);
      li.Insert(0, String.Format("[{0}] Игра в города началась!", DateTime.Now.ToString("HH:mm:ss")));
      li.Insert(0, String.Format("[{1}] Рандом: {0}", message, DateTime.Now.ToString("HH:mm:ss")));
      li.Insert(0, String.Format("  Ваш город на букву {0}!", letter));
      Session["list"] = li;
      LOG.Text = String.Join("\n", li);
    }

    if (Session["nick"] != null)
    {
      tbN.Text = Session["nick"].ToString();
    }
  }
  
  protected object[] CityAcc(char l, bool[] u)
  {
    bool hadcity = false;
    char let;
    int i;
    for (i = 0; i < citylist.Count; i++)
    {
      let = citylist[i][0];
      if (let == l && !u[i])
      {
        hadcity = true;
        break;
      }
    }
    object[] x = {hadcity, i};
    return x;
  }
  
  protected object[] LetterAcc(string cityname, bool[] u)
  {
    bool ach = false;
    int ch = cityname.Length - 1;
    char letter = '0';
    object[] x;
    while (!ach && ch >= 0)
    {
      letter = Char.ToUpper(cityname[ch]);
      x = CityAcc(letter, u);
      ach = (bool)x[0];
      if (ach)
      {
        break;
      }
      else
      {
        ch--;
      }
    }
    object[] y = {ch, letter};
    return y;
  }
  
  protected void btSave_Click(object sender, EventArgs e)
  {
    string nickname, message = "", cityname;
    List<string> nicks, l;
    bool[] u;
    char letter;
    int ind;
    
    nickname = tbN.Text.ToString();
    cityname = tbC.Text.ToString();
    l = (List<string>)Session["list"];
    u = (bool[])Session["used"];
    letter = (char)Session["letter"];

    bool bot = false;
    if (cityname[0] == letter)
    {
      ind = citylist.IndexOf(cityname);
      
      if (ind != -1 && !u[ind])
      {
        u[ind] = true;
        message = String.Format("\"{0}\", ход другого игрока", cityname);
        letter = Char.ToUpper(cityname[cityname.Length - 1]);
        
        bot = true;
      }
      else
        if (ind != -1 && u[ind])
        {
          message = String.Format("\"{0}\" уже был!", cityname);
        }
        else
        {
          message = String.Format("\"{0}\" нет в нашей базе!", cityname);
        }
    }
    else
    {
      message = String.Format("Вам на букву {0}!", letter);
    }
    
    if (Session["nicks"] != null)
    {
      nicks = (List<string>)Session["nicks"];
    }
    else
    {
      nicks = new List<string>{"admin"};
    }
    if (nicks.IndexOf(nickname) == -1)
    {
      l.Insert(0, String.Format("[{1}] {0} присоединяется к чату.", nickname, DateTime.Now.ToString("HH:mm:ss")));
      nicks.Add(nickname);
    }
    
    l.Insert(0, String.Format("[{2}] {0}: {1}", nickname, cityname, DateTime.Now.ToString("HH:mm:ss")));
    l.Insert(0, String.Format("  {0}", message));
    
    if (bot)
    {    
      int c = cityname.Length - 1, i = 0;
      bool acc = false;
      
      while (!acc && c >= 0)
      {
        letter = Char.ToUpper(cityname[c]);
        l.Insert(0, String.Format("  Рандом ищет город на {0}...", letter));
        object[] x = CityAcc(letter, u);
        acc = (bool)x[0];
        if (acc) {
          i = (int)x[1];
          u[i] = true;
          cityname = citylist[i];
          letter = Char.ToUpper(cityname[cityname.Length - 1]);
          l.Insert(0, "  И находит!");
          l.Insert(0, String.Format("[{1}] Рандом: {0}", cityname, DateTime.Now.ToString("HH:mm:ss")));
          
          object[] y = LetterAcc(cityname, u);
          int ch = (int)y[0];
          letter = (char)y[1];
          if (ch == -1)
          {
            l.Insert(0, "  Увы, доступных городов нет. Делаем сброс");
            u = Enumerable.Repeat(false, citylist.Count).ToArray();
            while (ch == -1)
            {
              i = (new Random()).Next(u.Length);
              cityname = citylist[i];
              y = LetterAcc(cityname, u);
              ch = (int)y[0];
              letter = (char)y[1];
            }
            u[i] = true;
            
            l.Insert(0, "");
            
            message = String.Format("\"{0}\"", cityname);
            l.Insert(0, String.Format("[{0}] Игра в города началась!", DateTime.Now.ToString("HH:mm:ss")));
            l.Insert(0, String.Format("[{1}] Рандом: {0}", message, DateTime.Now.ToString("HH:mm:ss")));
          }
          break;
        }
        else
        {
          c--;
          l.Insert(0, "  Увы, не нашел. Придеться брать предыдущую букву");
        }
      }
      if (c == -1)
      {
        l.Insert(0, "  Увы, доступных городов нет. Делаем сброс");
        u = Enumerable.Repeat(false, citylist.Count).ToArray();
        int ch = -1;
        object[] y;
        bool x = true;
        while (ch == -1)
        {
          i = (new Random()).Next(u.Length);
          cityname = citylist[i];
          y = LetterAcc(cityname, u);
          ch = (int)y[0];
          letter = (char)y[1];
        }
        u[i] = true;
        
        l.Insert(0, "");
        
        message = String.Format("\"{0}\"", cityname);
        l.Insert(0, String.Format("[{0}] Игра в города началась!", DateTime.Now.ToString("HH:mm:ss")));
        l.Insert(0, String.Format("[{1}] Рандом: {0}", message, DateTime.Now.ToString("HH:mm:ss")));
      }
      l.Insert(0, String.Format("  Ваш город на букву {0}!", letter));
    }
    
    Session["nicks"] = nicks;
    Session["list"] = l;
    Session["letter"] = letter;
    Session["used"] = u;
    Session["nick"] = nickname;
    LOG.Text = String.Join("\n", l);
  }

  protected void bt_Click(object sender, CommandEventArgs e)
  {
    string p = e.CommandArgument.ToString();
    Response.Redirect("~/page_" + p + ".aspx");
  }
  
  protected void btClear_Click(object sender, EventArgs e)
  {
    Session.Clear();
    Response.Redirect(Request.RawUrl);
  }
}
