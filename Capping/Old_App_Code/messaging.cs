using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net.Mail;
using System.Web.Security;
using System.Net;

/// <summary>
/// Summary description for messaging
/// </summary>
public class messaging
{
	public messaging()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public static void SendEmail(string useremail, string subject, string body)
    {

        MailAddress from = new MailAddress("support@cappingclub.com", "CappingClub Support");
        MailAddress to = new MailAddress(useremail);
        MailMessage message = new System.Net.Mail.MailMessage(from, to);
        var client = new SmtpClient("smtp.gmail.com", 587)
        {
            Credentials = new NetworkCredential("support@sportofkings.us", "shrap911"),
            EnableSsl = true
        };

        message.Subject = subject;
        message.Body = body;

        client.Send(message);

    }
}