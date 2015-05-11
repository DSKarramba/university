using System;
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

public partial class _Default : System.Web.UI.Page 
{
  protected void Page_Load(object sender, EventArgs e)
  {

  }

  protected void bt_Click(object sender, CommandEventArgs e)
  {
    string p = e.CommandArgument.ToString();
    Response.Redirect("~/" + p + ".aspx");
  }
  
  protected void gvOD_RowUpdating(object sender, GridViewUpdateEventArgs e)
  {
    String tmp;
    dsOD.UpdateParameters.Clear();

    int index = gvOD.EditIndex;
    GridViewRow row = gvOD.Rows[index];

    tmp = row.Cells[0].Text.ToString();
    dsOD.UpdateParameters.Add(new Parameter("p_i_id_orderdetail", TypeCode.Int32, tmp));

    if (e.NewValues["i_id_order"] != null)
      tmp = e.NewValues["i_id_order"].ToString();
    else
      tmp = row.Cells[1].Text.ToString();
    dsOD.UpdateParameters.Add(new Parameter("p_i_id_order", TypeCode.Int32, tmp));

    if (e.NewValues["i_id_good"] != null)
      tmp = e.NewValues["i_id_good"].ToString();
    else
      tmp = row.Cells[2].Text.ToString();
    dsOD.UpdateParameters.Add(new Parameter("p_i_id_good", TypeCode.Int32, tmp));

    if (e.NewValues["f_count"] != null)
      tmp = e.NewValues["f_count"].ToString();
    else
      tmp = row.Cells[3].Text.ToString();
    dsOD.UpdateParameters.Add(new Parameter("p_f_count", TypeCode.Single, tmp));

    if (e.NewValues["m_price"] != null)
      tmp = e.NewValues["m_price"].ToString();
    else
      tmp = row.Cells[4].Text.ToString();
    dsOD.UpdateParameters.Add(new Parameter("p_m_price", TypeCode.Single, tmp));

    dsOD.Update();
  }

  protected void gvOD_RowDeleting(object sender, GridViewDeleteEventArgs e)
  {
    String tmp;
    dsOD.DeleteParameters.Clear();

    int index = e.RowIndex;
    GridViewRow row = gvOD.Rows[index];

    tmp = row.Cells[0].Text.ToString();
    dsOD.DeleteParameters.Add(new Parameter("p_i_id_orderdetail", TypeCode.Int32, tmp));

    dsOD.Delete();
  }

  protected void bAdd_Click(object sender, EventArgs e)
  {
    String tmp;
    dsOD.InsertParameters.Clear();

    tmp = tbP.Text.ToString();
    dsOD.InsertParameters.Add(new Parameter("p_m_price", TypeCode.Single, tmp));

    tmp = tbC.Text.ToString();
    dsOD.InsertParameters.Add(new Parameter("p_f_count", TypeCode.Single, tmp));

    tmp = ddlO.SelectedValue.ToString();
    dsOD.InsertParameters.Add(new Parameter("p_i_id_order", TypeCode.Int32, tmp));

    tmp = ddlG.SelectedValue.ToString();
    dsOD.InsertParameters.Add(new Parameter("p_i_id_good", TypeCode.Int32, tmp));

    dsOD.Insert();
    tbP.Text = "";
    tbC.Text = "";
  }
}
