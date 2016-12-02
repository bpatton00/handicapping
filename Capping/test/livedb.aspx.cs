using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Caching;

public partial class test_livedb : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Label1.Text = "Cache Refresh: " +
    DateTime.Now.ToLongTimeString();

        using (var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["WageringConn"].ConnectionString))
        {
            using (SqlCommand command =
                new SqlCommand(GetSQL(), connection))
            {
                SqlCacheDependency dependency =
                    new SqlCacheDependency(command);
                // Refresh the cache after the number of minutes 
                // listed below if a change does not occur. 
                // This value could be stored in a configuration file. 
                int numberOfMinutes = 3;
                DateTime expires =
                    DateTime.Now.AddMinutes(numberOfMinutes);

                Response.Cache.SetExpires(expires);
                Response.Cache.SetCacheability(HttpCacheability.Public);
                Response.Cache.SetValidUntilExpires(true);

                Response.AddCacheDependency(dependency);

                connection.Open();

                GridView1.DataSource = command.ExecuteReader();
                GridView1.DataBind();
            }
        }
    }
    private string GetSQL()
    {
        return "SELECT UserName as Member, wager_earnings as Winnings  FROM tourn_entry INNER JOIN aspnet_Users ON aspnet_Users.UserId = tourn_entry.UserId WHERE tournid = '24'";
    }



}