using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Capping.ascx
{
    public partial class myselections : System.Web.UI.UserControl
    {
        public Int64 tournamentid { get; set; }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            SqlDataSourceSelections.SelectParameters["tournid"].DefaultValue = tournamentid.ToString();
            GVTournamentSelections.DataBind();
        }
    

        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
    }
}