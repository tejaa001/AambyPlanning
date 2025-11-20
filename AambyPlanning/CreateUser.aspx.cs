using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AambyPlanning
{
    public partial class CreateUser : System.Web.UI.Page
    {
        // Static lists to store created users (in-memory storage for demo)
        private static List<string> createdUserNames = new List<string>();
        private static List<string> createdEmployeeIds = new List<string>();
        private static List<string> createdEmails = new List<string>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProfiles();
            }
        }

        // Load profiles into dropdown (hardcoded for demo)
        private void LoadProfiles()
        {
            ddlProfile.Items.Clear();
            ddlProfile.Items.Add(new ListItem("-- Select Profile --", ""));
            ddlProfile.Items.Add(new ListItem("Administrator", "1"));
            ddlProfile.Items.Add(new ListItem("Manager", "2"));
            ddlProfile.Items.Add(new ListItem("Supervisor", "3"));
            ddlProfile.Items.Add(new ListItem("Employee", "4"));
            ddlProfile.Items.Add(new ListItem("Guest", "5"));
        }

        // Check if username already exists
        protected void txtUserName_TextChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(txtUserName.Text))
            {
                if (CheckUserNameExists(txtUserName.Text.Trim()))
                {
                    ShowMessage("User Name already exists. Please choose a different one.", "error");
                    txtUserName.Focus();
                }
                else
                {
                    // Clear the error message if username is unique
                    lblStatus.Text = string.Empty;
                    lblStatus.CssClass = "status-message";
                }
            }
        }

        // Check if employee ID already exists
        protected void txtEmpId_TextChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(txtEmpId.Text))
            {
                if (CheckEmployeeIdExists(txtEmpId.Text.Trim()))
                {
                    ShowMessage("Employee ID already exists. Please enter a different one.", "error");
                    txtEmpId.Focus();
                }
                else
                {
                    // Clear the error message if employee ID is unique
                    lblStatus.Text = string.Empty;
                    lblStatus.CssClass = "status-message";
                }
            }
        }

        // Check if email already exists
        protected void txtEmail_TextChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(txtEmail.Text))
            {
                if (CheckEmailExists(txtEmail.Text.Trim()))
                {
                    ShowMessage("Email already exists. Please use a different email.", "error");
                    txtEmail.Focus();
                }
                else
                {
                    // Clear the error message if email is unique
                    lblStatus.Text = string.Empty;
                    lblStatus.CssClass = "status-message";
                }
            }
        }

        // Save button click event
        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    string userName = txtUserName.Text.Trim();
                    string empId = txtEmpId.Text.Trim();
                    string email = txtEmail.Text.Trim();

                    // Additional validations
                    if (CheckUserNameExists(userName))
                    {
                        ShowMessage("User Name already exists. Please choose a different one.", "error");
                        return;
                    }

                    if (CheckEmployeeIdExists(empId))
                    {
                        ShowMessage("Employee ID already exists. Please enter a different one.", "error");
                        return;
                    }

                    if (CheckEmailExists(email))
                    {
                        ShowMessage("Email already exists. Please use a different email.", "error");
                        return;
                    }

                    // Store user data in static lists (simulating database save)
                    createdUserNames.Add(userName);
                    createdEmployeeIds.Add(empId);
                    createdEmails.Add(email);

                    // Show success message
                    ShowMessage($"User '{txtEmpName.Text.Trim()}' created successfully! (Demo Mode - No Database)", "success");
                    
                    // Clear form after successful save
                    ClearForm();
                }
                catch (Exception ex)
                {
                    ShowMessage("Error: " + ex.Message, "error");
                }
            }
        }

        // Clear button click event
        protected void btnClear_Click(object sender, EventArgs e)
        {
            ClearForm();
        }

        // Helper method to clear form
        private void ClearForm()
        {
            txtUserName.Text = string.Empty;
            txtEmpId.Text = string.Empty;
            txtEmpName.Text = string.Empty;
            ddlProfile.SelectedIndex = 0;
            txtMobile.Text = string.Empty;
            txtEmail.Text = string.Empty;
        }

        // Check if username exists (in-memory check)
        private bool CheckUserNameExists(string userName)
        {
            return createdUserNames.Contains(userName, StringComparer.OrdinalIgnoreCase);
        }

        // Check if employee ID exists (in-memory check)
        private bool CheckEmployeeIdExists(string empId)
        {
            return createdEmployeeIds.Contains(empId, StringComparer.OrdinalIgnoreCase);
        }

        // Check if email exists (in-memory check)
        private bool CheckEmailExists(string email)
        {
            return createdEmails.Contains(email, StringComparer.OrdinalIgnoreCase);
        }

        // Helper method to show messages
        private void ShowMessage(string message, string type)
        {
            lblStatus.Text = message;
            lblStatus.CssClass = "status-message " + type;
        }
    }
}