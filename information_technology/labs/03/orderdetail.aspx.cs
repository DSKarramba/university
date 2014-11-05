﻿using System;
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
    IDataReader reader  =  (IDataReader)dsOD.Select(new DataSourceSelectArguments()); 
    try 
    {
      while (reader.Read()) 
      { 
        HtmlTableRow row = new HtmlTableRow(); 
        HtmlTableCell cell = new HtmlTableCell(); 
        cell.InnerText = reader["i_id_orderdetail"].ToString();
        row.Cells.Add(cell);
        TableOrderDetail.Rows.Add(row);

        cell = new HtmlTableCell();
        cell.InnerText = reader["i_id_order"].ToString();
        row.Cells.Add(cell);
        TableOrderDetail.Rows.Add(row);

        cell = new HtmlTableCell();
        cell.InnerText = reader["i_id_good"].ToString();
        row.Cells.Add(cell);
        TableOrderDetail.Rows.Add(row);

        cell = new HtmlTableCell();
        cell.InnerText = reader["f_count"].ToString();
        row.Cells.Add(cell);
        TableOrderDetail.Rows.Add(row);

        cell = new HtmlTableCell();
        cell.InnerText = reader["m_price"].ToString();
        row.Cells.Add(cell);
        TableOrderDetail.Rows.Add(row);

        cell = new HtmlTableCell();
        cell.InnerText = reader["m_sum"].ToString();
        row.Cells.Add(cell);
        TableOrderDetail.Rows.Add(row);
      }
    }
    finally
    {
      reader.Close();
    }
  }

  protected void bt_Click(object sender, CommandEventArgs e)
  {
    string p = e.CommandArgument.ToString();
    Response.Redirect("~/" + p + ".aspx");
  }
}
