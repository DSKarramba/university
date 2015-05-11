using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Xml.Linq;
using System.Data;
using System.Data.SqlClient;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]

public class Service : System.Web.Services.WebService {

    public Service () { 
    }

    [WebMethod]
    public string HelloWorld() {
      return "Привет всем!";
    }
    
    [WebMethod]
    public string sellerOrderSum() {
      String sCon = "Data Source=NEUTRINO\\SQLEXPRESS;Initial Catalog=labs;Integrated Security=True;Pooling=False";
      SqlConnection conn = new SqlConnection(sCon);
      SqlCommand cmd = new SqlCommand("AveragePrice", conn);
      cmd.CommandType = CommandType.StoredProcedure;
      SqlParameter avg = new SqlParameter("avg", SqlDbType.Int);
      avg.Direction = ParameterDirection.Output;
      cmd.Parameters.Add(avg);
      try
      {
          conn.Open();
          cmd.ExecuteNonQuery();
      }
      catch (Exception ex)
      {
          throw (ex);
      }
      finally
      {
          if (conn.State == ConnectionState.Open)
          {
              conn.Close();
          }
      }
      return avg.Value.ToString();
    }
    
}
