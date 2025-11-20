using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AambyPlanning
{
    public partial class LoginPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Clear any previous messages
                lblMessage.Text = "";
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            //string username = txtUsername.Text.Trim();
            //string password = txtPassword.Text.Trim();
            string username = "admin";
            string password = "password";

            // Simple validation
            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                lblMessage.Text = "Please enter both username and password.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            // Simple authentication (in a real application, you would check against a database)
            if (username == "admin" && password == "password")
            {
                lblMessage.Text = "Login successful!";
                lblMessage.ForeColor = System.Drawing.Color.Green;
                // Redirect to another page or dashboard
                Response.Redirect("HomePage.aspx");
            }
            else
            {
                lblMessage.Text = "Invalid username or password.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }
    }
}