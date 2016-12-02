using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Globalization;
using System.Text.RegularExpressions;
using System.Data.SqlClient;
/// <summary>
/// Summary description for shared
/// </summary>
public class shared
{
	public shared()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public static int GetRndImg()
    {
        int num = 0;
        Random rnd = new Random();
        num = rnd.Next(1, 5);

        return num;
    }
    public static string SaveFile(HttpPostedFile file, string newfilename, string savepath, string extension)
    {
        newfilename += extension;
        file.SaveAs(savepath + newfilename);
        return newfilename;
    }

    public static string FormatNumber(int num)
    {
        if (num >= 100000)
            return FormatNumber(num / 1000) + "K";
        if (num >= 10000)
        {
            return (num / 1000D).ToString("0.#") + "K";
        }
        return "$" + num.ToString("#,0");
    }
    public static System.Drawing.Color GetColor(string surface)
    {
        if (surface.Trim().ToUpper() == "T") { return System.Drawing.Color.Green; }
        if (surface.Trim().ToUpper() == "D") { return System.Drawing.Color.SaddleBrown; }
        return System.Drawing.Color.Black;
    }

    public static System.Drawing.Color GetColor_Returns(double avgreturn)
    {
        System.Drawing.Color clr = System.Drawing.ColorTranslator.FromHtml("#024457");

        if (avgreturn < 1.5) { clr = System.Drawing.Color.Gray; }
        if (avgreturn > 2) { clr = System.Drawing.Color.Green; }
        if (avgreturn >= 4) { clr = System.Drawing.Color.DarkGreen; }
        return clr;
    }

    public static string ConvertDist(int distance, string disttype)
    {
        if (disttype.Trim().ToUpper() == "F")
        {
            switch (distance)
            {
                case 400:
                    return "4f";
                case 450:
                    return "4.5f";
                case 500:
                    return "5f";
                case 550:
                    return "5.5f";
                case 600: 
                    return "6f";
                case 650:
                    return "6.5f";
                case 700:
                    return "7f";
                case 750:
                    return "7.5f";
                case 800:
                    return "1m";
                case 832: 
                    return "1m 70y";
                case 850:
                    return "1 1/16m";
                case 900:
                    return "1 1/8m";
                case 1000:
                    return "1 1/4m";
                case 1100:
                    return "1 3/8m";
                case 1200:
                    return "1 1/2m";
                case 1300:
                    return "1 5/8m";
                case 1400:
                    return "1 3/4m";
                case 1500:
                    return "1 7/8m";
                case 1600:
                    return "2m";
                case 1650:
                    return "2 1/16m";
                case 1700:
                    return "2 1/8m";
            }
        }
        return "n/a";
    }

    public static string ConvertToTime_Short(double secondcount)
    {
        string returnvalue = "";
        if (secondcount > 0)
        {
            int minutes = 0;
            minutes = (int)((secondcount / 60));
            secondcount = secondcount - (minutes * 60);
            if (minutes > 0) { returnvalue = minutes + ":" + secondcount.ToString("00.00"); }
            else { returnvalue = secondcount.ToString("00.00").TrimStart('0'); }
        }
        else
        {
            returnvalue = "";
        }

        return returnvalue;
    }

    public static double FracToDouble(string fracstring)
    {
        //if fracstring does not have a int and a space then add one e.g. 30/1 to 0 30/1
        if (!fracstring.Trim().Contains(" ")) { fracstring = "0 " + fracstring; }
        Regex re = new Regex(@"^\s*(\d+)(\s*\.(\d*)|\s+(\d+)\s*/\s*(\d+))?\s*$");
        Match m = re.Match(fracstring);
        double val = m.Groups[1].Success ? double.Parse(m.Groups[1].Value) : 0.0;

        if (m.Groups[3].Success)
        {
            val += double.Parse("0." + m.Groups[3].Value);
        }
        else
        {
            val += double.Parse(m.Groups[4].Value) / double.Parse(m.Groups[5].Value);
        }
        return val;
    }

    public static int GetFractionNum(String fracstring)
    {
        char[] delimChars = { '/' };
        string[] fracs = fracstring.Split(delimChars);
        return Convert.ToInt32(fracs[0]);
    }
    public static int GetFractionDenom(String fracstring)
    {
        char[] delimChars = { '/' };
        string[] fracs = fracstring.Split(delimChars);
        return Convert.ToInt32(fracs[1]);
    }

    public static DateTime ReFormatTime(DateTime racedate, string posttime)
    {

        string time = posttime;
        if (time.Length < 8) { time = "0" + time; }
        return DateTime.ParseExact(racedate.ToShortDateString() + " " + time, "M/d/yyyy HH:mm:ss", CultureInfo.InvariantCulture);
    }

    public static DateTime ConvertDateTimeToLocalTime(DateTime combinedracedate, Int64 trackid, int useroffset)
    {
        //start with the datetime from the import - convert to utc then convert back to usertime
        combinedracedate = combinedracedate.AddHours(races.GetTrackTimeOffset(trackid) * -1);
        combinedracedate = combinedracedate.AddHours(useroffset );

        return combinedracedate;
    }

    public static void SaveError(string s_page, string s_error)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WageringConn"].ConnectionString);
        string sql = "INSERT INTO errors (page, error) VALUES ('" + s_page + "', '" + s_error + "')";
        SqlCommand cmd_err = new SqlCommand(sql, con);
        con.Open();
        cmd_err.ExecuteNonQuery();
        con.Close();
    }
 
}