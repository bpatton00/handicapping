using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;

namespace Capping.process
{
    public partial class closeraces : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WageringConn"].ConnectionString);
            string sql_upd = "UPDATE races SET ropen = 'False' WHERE DATEADD(HOUR, (SELECT timeoffset FROM tracks WHERE tracks.id = races.track) * -1, DATEADD(ms, DATEDIFF(ms, '00:00:00', rtime), CONVERT(DATETIME, rdate))) <= GETDATE() AND ropen = 'True'";
            SqlCommand myCommand_upd = new SqlCommand(sql_upd, con);
            con.Open();
            myCommand_upd.ExecuteNonQuery();
            con.Close();
        }
    }
}