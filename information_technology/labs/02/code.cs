using System;
using System.Collections;
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
    if (Session["name"] != null)
    {
      lblN.Visible = true;
      lblN.Text = Session["name"].ToString();
    }
    if (Session["age"] != null)
    {
      lblA.Visible = true;
      lblA.Text = Session["age"].ToString();
    }
    if (Session["sex"] != null)
    {
      lblS.Visible = true;
      lblS.Text = Session["sex"].ToString();
    }
  }
  
  public string[] GetData()
  {
    int a = -1;
    string n = "", s;
    string[] d = {"", "", ""};

    if (tbN.Text.ToString() != "") n = tbN.Text.ToString();
    
    if (tbA.Text.ToString() != "") a = Math.Abs(int.Parse(tbA.Text.ToString()));
    
    s = ddlS.SelectedItem.Text;
    
    d[0] = a.ToString();
    d[1] = n;
    d[2] = s;
    
    return d;
  }
  
  protected void btSave_Click(object sender, EventArgs e)
  {
    int a;
    string[] d;

    d = GetData();
    a = int.Parse(d[0]);

    if (d[1] != "")
    {
      Session["name"] = d[1];
      lblN.Visible = true;
      lblN.Text = d[1];
    }
    if (a != -1)
    {
      Session["age"] = a;
      lblA.Visible = true;
      lblA.Text = a.ToString();
    }
    Session["sex"] = d[2];
    lblS.Visible = true;
    lblS.Text = d[2];
  }

  protected void bt_Click(object sender, CommandEventArgs e)
  {
    int a;
    string p;
    string[] d;

    d = GetData();
    a = int.Parse(d[0]);
    
    p = e.CommandArgument.ToString();

    if (d[1] != "") Session["name"] = d[1];
    if (a != -1) Session["age"] = a;
    Session["sex"] = d[2];

    Response.Redirect("~/page_" + p + ".aspx");
  }
  
  protected void btClear_Click(object sender, EventArgs e)
  {
    Session.Clear();
    Response.Redirect(Request.RawUrl);
  }
}
