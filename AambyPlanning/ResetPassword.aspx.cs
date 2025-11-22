using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AambyPlanning
{
    public partial class ResetPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindUserDropdown();
            }
        }

        private void BindUserDropdown()
        {
            // Sample data - In a real application, this would come from a database
            ddlUser.Items.Clear();
            ddlUser.Items.Add(new ListItem("-- Select User --", "0"));
            ddlUser.Items.Add(new ListItem("John Doe", "1"));
            ddlUser.Items.Add(new ListItem("Jane Smith", "2"));
            ddlUser.Items.Add(new ListItem("Robert Johnson", "3"));
            ddlUser.Items.Add(new ListItem("Emily Davis", "4"));
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            if (ddlUser.SelectedValue == "0")
            {
                ShowMessage("Please select a user.", false);
                return;
            }

            // In a real application, you would reset the password here
            // This might involve generating a new password or sending a reset link
            ShowMessage($"Password reset successfully for {ddlUser.SelectedItem.Text}.", true);
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            // Redirect to home page or user list
            Response.Redirect("~/UserList.aspx");
        }

        private void ShowMessage(string message, bool isSuccess)
        {
            lblMessage.Text = message;
            lblMessage.CssClass = isSuccess ? "alert alert-success-custom d-block text-center" : "alert alert-error-custom d-block text-center";
        }
    }
}