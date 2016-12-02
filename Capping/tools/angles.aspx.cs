using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Capping.tools
{
    public partial class angles : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected string GetROIIcon(int numraces, double amountwon)
        {
            string icon = "";
            if (numraces > 0)
            {
                double thisroi = Math.Round(amountwon / (Convert.ToDouble(numraces) * 2), 2) - 1;
                if (thisroi >= .60) { icon = "<i style=\"color:green\" class=\"fa fa-angle-double-up\"></i>"; }
                if (thisroi > 0 && thisroi < .60) { icon = "<i style=\"color:green\" class=\"fa fa-angle-up\"></i>"; }
                if (thisroi <= -.25) { icon = "<i style=\"color:red\" class=\"fa fa-angle-down\"></i>"; }
            }
            
            return icon;
        }

    }
}