using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AambyPlanning
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            try
            {
                // Clear user session
                Session.Clear();
                Session.Abandon();

                // Clear authentication cookie if using forms authentication
                if (Request.Cookies["ASP.NET_SessionId"] != null)
                {
                    HttpCookie cookie = new HttpCookie("ASP.NET_SessionId", "");
                    cookie.Expires = DateTime.Now.AddYears(-1);
                    Response.Cookies.Add(cookie);
                }

                // Redirect to login page
                Response.Redirect("~/LoginPage.aspx");
            }
            catch (Exception ex)
            {
                // Log the exception (in a real application, use proper logging)
                // For now, we'll just redirect to login
                Response.Redirect("~/LoginPage.aspx");
            }
        }
    }
}