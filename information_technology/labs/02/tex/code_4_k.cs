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
    
    img0.ImageUrl = "img/box.png";
    img1.ImageUrl = "img/box.png";
    img2.ImageUrl = "img/box.png";
    img3.ImageUrl = "img/box.png";
    img4.ImageUrl = "img/box.png";
  }

  protected void img_Click(object sender, CommandEventArgs e)
  {
    int i = int.Parse(e.CommandArgument.ToString());
    Session["chosen"] = i;
  }
  
  protected void btSave_Click(object sender, EventArgs e)
  {
    string nickname, message;
    List<string> nicks, l;
    
    nickname = tbN.Text.ToString();
    int rand = (new Random()).Next(5);
    int chosen = rb0.Checked ? 0 : rb1.Checked ? 1 : rb2.Checked ? 2 : rb3.Checked ? 3 : 4;
    
    switch (rand)
    {
      case 0:
        img0.ImageUrl = "img/ball.png";
        break;
      case 1:
        img1.ImageUrl = "img/ball.png";
        break;
      case 2:
        img2.ImageUrl = "img/ball.png";
        break;
      case 3:
        img3.ImageUrl = "img/ball.png";
        break;
      case 4:
        img4.ImageUrl = "img/ball.png";
        break;
    }
    message = String.Format("выбрал {0} и нашел мяч! Грац", rand + 1);
    
    if (chosen != rand)
    {
      int cat = (new Random()).Next(27);
      switch (chosen)
      {
        case 0:
          img0.ImageUrl = "img/cat_" + cat.ToString() + ".png";
          break;
        case 1:
          img1.ImageUrl = "img/cat_" + cat.ToString() + ".png";
          break;
        case 2:
          img2.ImageUrl = "img/cat_" + cat.ToString() + ".png";
          break;
        case 3:
          img3.ImageUrl = "img/cat_" + cat.ToString() + ".png";
          break;
        case 4:
          img4.ImageUrl = "img/cat_" + cat.ToString() + ".png";
          break;
      }
      message = String.Format("выбрал {0}, а мяч оказался в {1}. Держи кота!", chosen + 1, rand + 1);
    }
    
    l = (List<string>)Session["list"];
    
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
    l.Insert(0, String.Format("[{2}] {0} {1}", nickname, message, DateTime.Now.ToString("HH:mm:ss")));
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
