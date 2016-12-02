using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Capping.tools
{
    public partial class cceval : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected string GetPanelClass(Double correct, Double total)
        {
            if (correct > 0)
            {
                double pct = correct / total;
                if (pct > .2) { return "panel panel-success"; }
                if (pct > .1) { return "panel panel-info"; }
            }


            return "panel panel-default";


        }

        protected double ROI(string wtype, int numraces, int numcorrect, double amountwon)
        {
            double roi = 0;

            //wager amount
            //all data is normalized to $1.0 wagers when importing
            double wager = 1.0;
            int numbets = 0;
            switch (wtype)
            {
                case "excold":
                    numbets = 1;
                    break;
                case "exbox":
                    numbets = 2;
                    break;
                case "exboxplus":
                    numbets = 6;
                    break;
                case "tricold":
                    numbets = 1;
                    break;
                case "tribox":
                    numbets = 6;
                    break;
                case "triboxplus":
                    numbets = 24;
                    break;
            }

            double amountperbet = numbets * wager;
            double totalbet = amountperbet * numraces;
            roi = (amountwon / totalbet) - 1;

            return Math.Round(roi, 4);
        }

        protected string GetROIIcon(string wtype, int numraces, int numcorrect, double amountwon)
        {
            string icon = "";
            double thisroi = ROI(wtype, numraces, numcorrect, amountwon);
            icon = picks.GetROIIcon(thisroi);

            return icon;
        }
    }
}