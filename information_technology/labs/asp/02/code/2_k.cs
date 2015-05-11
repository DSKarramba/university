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
  
  protected void btSave_Click(object sender, EventArgs e)
  {
    string nickname, message = "";
    List<string> nicks, l;
    int cookie, luckystar, steinsgate;
    
    nickname = tbN.Text.ToString();
    l = (List<string>)Session["list"];
    if (Session["nicks"] != null)
    {
      nicks = (List<string>)Session["nicks"];
    }
    else
    {
      nicks = new List<string> { };
    }

    if (nicks.IndexOf(nickname) == -1)
    {
      l.Insert(0, String.Format("[{1}] {0} �������������� � ����.", nickname, DateTime.Now.ToString("HH:mm:ss")));
      nicks.Add(nickname);
    }
    l.Insert(0, String.Format("[{1}] {0} �������� �����...", nickname, DateTime.Now.ToString("HH:mm:ss")));

    cookie = rbC1.Checked ? 0 : rbC2.Checked ? 1 : 2;
    switch (cookie)
    {
      case 0:
        message = " - �������� ������� :)";
        break;
      case 1:
        message = ", �� ����� ����";
        break;
      case 2:
        message = ", OM NOM NOM NOM";
        break;
    }
    l.Insert(0, String.Format("  {0}{1}", nickname, message));

    luckystar = rbL1.Checked ? 0 : rbL2.Checked ? 1 : 2;
    switch (luckystar)
    {
      case 0:
        message = ", �� ���� ���� ���أ��� � �������!";
        break;
      case 1:
        message = ", �� ���� ���� ���أ��� � �����!";
        break;
      case 2:
        message = ", ���... � ����� ������� �������?";
        break;
    }
    l.Insert(0, String.Format("  {0}{1}", nickname, message));

    steinsgate = rbS1.Checked ? 0 : rbS2.Checked ? 1 : 2;
    switch (steinsgate)
    {
      case 0:
        message = ", ...";
        break;
      case 1:
        message = ", ��-��-��!";
        break;
      case 2:
        message = ", OM MANGO NOM NOM";
        break;
    }
    l.Insert(0, String.Format("  {0}{1}", nickname, message));
    
    Session["nicks"] = nicks;
    Session["list"] = l;
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
