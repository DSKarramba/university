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
  protected void Page_Load(object sender, EventArgs e)
  {
    if (Session["List"] != null)
    {
      List<string> l = (List<string>)Session["list"];
      LOG.Text = String.Join("\n", l);
    }
    else
    {
      Session["list"] = new List<string>{};
    }
    
    if (Session["nick"] != null)
    {
      tbN.Text = Session["nick"].ToString();
    }
  }
  
  public List<string> answers = new List<string>
  {
    "Определенно да", "Определенно нет", "Лучше не стоит", "Можно попробовать",
    "Трудный вопрос, не могу ответить", "Можно, если осторожно", "Да", "Нет",
    "Стоит хорошенько все обдумать", "Нет-нет-нет", "Скорее да, чем нет",
    "Скорее нет, чем да", "Ответа нет", "Решай самостоятельно"
  };
  
  protected void btSave_Click(object sender, EventArgs e)
  {
    string nickname, question, message;
    List<string> nicks, l;
    
    nickname = tbN.Text.ToString();
    question = tbQ.Text.ToString();
    l = (List<string>)Session["list"];
    int i = (new Random()).Next(answers.Count);
    message = answers[i];
    
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
    l.Insert(0, String.Format("[{2}] {0} вопрошает: {1}", nickname, question, DateTime.Now.ToString("HH:mm:ss")));
    l.Insert(0, String.Format("  Великий Рандом отвечает: {0}", message));    
    
    Session["nicks"] = nicks;
    Session["nick"] = nickname;
    Session["list"] = l;
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
