using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Capping.tooltips
{
    public partial class exotic_details : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string exotictype = Request.QueryString["exotic"];
            string abbrev = Request.QueryString["track"];

            bool isexacta = false;
            bool istrifecta = false;
            switch (exotictype)
            {
                case "ex_cold":
                    isexacta = true;
                    break;
                case "ex_box":
                    isexacta = true;
                    break;
                case "ex_boxplusone":
                    isexacta = true;
                    break;
                case "tri_cold":
                    istrifecta = true;
                    break;
                case "tri_box":
                    istrifecta = true;
                    break;
                case "tri_boxplusone":
                    istrifecta = true;
                    break;
            }
            if (isexacta)
            {
                //column name is passed in as a query string
                SqlDataSourceExotics.SelectCommand = "SELECT races.id, rdesc, rdate, rtime, distance, surface, purse, rnum, rtype, age_restr, tracks.abbrev , exacta as payout FROM races INNER JOIN tracks ON races.track = tracks.id WHERE " + exotictype + " = 1 AND abbrev = '" + abbrev + "' ORDER BY rdate DESC ";
            }
            if (istrifecta)
            {
                //column name is passed in as a query string
                SqlDataSourceExotics.SelectCommand = "SELECT races.id, rdesc, rdate, rtime, distance, surface, purse, rnum, rtype, age_restr, tracks.abbrev, trifecta as payout FROM races INNER JOIN tracks ON races.track = tracks.id WHERE " + exotictype + " = 1 AND abbrev = '" + abbrev + "' ORDER BY rdate DESC ";
            }
            GVExotics.DataBind();

        }
    }
}