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
using System.Web.Services;
using System.Xml.Linq;

public partial class forms_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
      if (!IsPostBack)
      {
        ws.ServiceSoapClient client = new ws.ServiceSoapClient();
        tbHello.Text = client.HelloWorld();
      }
    }
    
    protected void DO_Click(object sender, EventArgs e)
    {
      ws.ServiceSoapClient client = new ws.ServiceSoapClient();
      tbSOS.Text = client.sellerOrderSum();
    }
}
