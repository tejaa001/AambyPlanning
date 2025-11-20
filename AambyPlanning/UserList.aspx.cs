using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AambyPlanning
{
    public partial class UserList : System.Web.UI.Page
    {
        // Static list to store users (in-memory storage for demo)
        private static List<User> userList = new List<User>();
        private static int nextUserId = 1;

        // User class to represent user data
        public class User
        {
            public int UserId { get; set; }
            public string Username { get; set; }
            public string EmployeeName { get; set; }
            public string EmployeeId { get; set; }
            public string Profile { get; set; }
            public string MobileNumber { get; set; }
            public string Email { get; set; }
            public int IsActive { get; set; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Initialize with some sample data if list is empty
                if (userList.Count == 0)
                {
                    InitializeSampleData();
                }

                LoadProfiles();
                BindGrid();
            }
        }

        // Initialize sample data for demo
        private void InitializeSampleData()
        {
            userList.Add(new User
            {
                UserId = nextUserId++,
                Username = "admin",
                EmployeeName = "Admin User",
                EmployeeId = "EMP001",
                Profile = "Administrator",
                MobileNumber = "9876543210",
                Email = "admin@example.com",
                IsActive = 1
            });

            userList.Add(new User
            {
                UserId = nextUserId++,
                Username = "jdoe",
                EmployeeName = "John Doe",
                EmployeeId = "EMP002",
                Profile = "Manager",
                MobileNumber = "9876543211",
                Email = "john.doe@example.com",
                IsActive = 1
            });

            userList.Add(new User
            {
                UserId = nextUserId++,
                Username = "jsmith",
                EmployeeName = "Jane Smith",
                EmployeeId = "EMP003",
                Profile = "Employee",
                MobileNumber = "9876543212",
                Email = "jane.smith@example.com",
                IsActive = 0
            });
        }

        // Load profiles into dropdown
        private void LoadProfiles()
        {
            ddlProfile.Items.Clear();
            ddlProfile.Items.Add(new ListItem("-- Select Profile --", ""));
            ddlProfile.Items.Add(new ListItem("Administrator", "Administrator"));
            ddlProfile.Items.Add(new ListItem("Manager", "Manager"));
            ddlProfile.Items.Add(new ListItem("Supervisor", "Supervisor"));
            ddlProfile.Items.Add(new ListItem("Employee", "Employee"));
            ddlProfile.Items.Add(new ListItem("Guest", "Guest"));
        }

        // Bind GridView with user data
        private void BindGrid()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("UserId", typeof(int));
            dt.Columns.Add("Username", typeof(string));
            dt.Columns.Add("EmployeeName", typeof(string));
            dt.Columns.Add("EmployeeId", typeof(string));
            dt.Columns.Add("Profile", typeof(string));
            dt.Columns.Add("MobileNumber", typeof(string));
            dt.Columns.Add("Email", typeof(string));
            dt.Columns.Add("IsActive", typeof(int));

            foreach (var user in userList)
            {
                dt.Rows.Add(
                    user.UserId,
                    user.Username,
                    user.EmployeeName,
                    user.EmployeeId,
                    user.Profile,
                    user.MobileNumber,
                    user.Email,
                    user.IsActive
                );
            }

            gvUsers.DataSource = dt;
            gvUsers.DataBind();
        }

        // GridView RowCommand event handler
        protected void gvUsers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditRow")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = gvUsers.Rows[rowIndex];

                // Get UserId from DataKeys
                int userId = Convert.ToInt32(gvUsers.DataKeys[rowIndex].Value);

                // Find user in list
                User user = userList.FirstOrDefault(u => u.UserId == userId);

                if (user != null)
                {
                    // Populate form fields
                    txtUserName.Text = user.Username;
                    txtEmpId.Text = user.EmployeeId;
                    txtEmpName.Text = user.EmployeeName;
                    ddlProfile.SelectedValue = user.Profile;
                    txtMobile.Text = user.MobileNumber;
                    txtEmail.Text = user.Email;

                    // Store UserId in ViewState for update
                    ViewState["EditUserId"] = userId;

                    // Show form and hide grid
                    dform.Visible = true;
                    dGrid.Visible = false;

                    ShowMessage("Edit user details and click Update to save changes.", "");
                }
            }
            else if (e.CommandName == "ToggleActive")
            {
                int userId = Convert.ToInt32(e.CommandArgument);

                // Find user and toggle active status
                User user = userList.FirstOrDefault(u => u.UserId == userId);

                if (user != null)
                {
                    user.IsActive = user.IsActive == 1 ? 0 : 1;
                    string status = user.IsActive == 1 ? "Active" : "Inactive";
                    ShowMessage($"User '{user.Username}' status changed to {status}.", "success");
                    BindGrid();
                }
            }
        }

        // Update button click event
        protected void btnEdit_Click(object sender, EventArgs e)
        {
            if (ViewState["EditUserId"] != null)
            {
                int userId = Convert.ToInt32(ViewState["EditUserId"]);
                User user = userList.FirstOrDefault(u => u.UserId == userId);

                if (user != null)
                {
                    // Validate unique constraints (excluding current user)
                    if (userList.Any(u => u.UserId != userId && u.EmployeeId.Equals(txtEmpId.Text.Trim(), StringComparison.OrdinalIgnoreCase)))
                    {
                        ShowMessage("Employee ID already exists for another user.", "error");
                        return;
                    }

                    if (userList.Any(u => u.UserId != userId && u.Email.Equals(txtEmail.Text.Trim(), StringComparison.OrdinalIgnoreCase)))
                    {
                        ShowMessage("Email already exists for another user.", "error");
                        return;
                    }

                    // Update user details
                    user.EmployeeId = txtEmpId.Text.Trim();
                    user.EmployeeName = txtEmpName.Text.Trim();
                    user.Profile = ddlProfile.SelectedValue;
                    user.MobileNumber = txtMobile.Text.Trim();
                    user.Email = txtEmail.Text.Trim();

                    ShowMessage($"User '{user.Username}' updated successfully!", "success");

                    // Clear form and show grid
                    ClearForm();
                    dform.Visible = false;
                    dGrid.Visible = true;
                    BindGrid();

                    ViewState["EditUserId"] = null;
                }
            }
        }

        // Back button click event
        protected void btnBack_Click(object sender, EventArgs e)
        {
            ClearForm();
            dform.Visible = false;
            dGrid.Visible = true;
            ViewState["EditUserId"] = null;
            lblStatus.Text = string.Empty;
            lblStatus.CssClass = "status-message";
        }

        // Employee ID TextChanged event
        protected void txtEmpId_TextChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(txtEmpId.Text))
            {
                int currentUserId = ViewState["EditUserId"] != null ? Convert.ToInt32(ViewState["EditUserId"]) : 0;

                if (userList.Any(u => u.UserId != currentUserId && u.EmployeeId.Equals(txtEmpId.Text.Trim(), StringComparison.OrdinalIgnoreCase)))
                {
                    ShowMessage("Employee ID already exists for another user.", "error");
                    txtEmpId.Focus();
                }
                else
                {
                    lblStatus.Text = string.Empty;
                    lblStatus.CssClass = "status-message";
                }
            }
        }

        // Email TextChanged event
        protected void txtEmail_TextChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(txtEmail.Text))
            {
                int currentUserId = ViewState["EditUserId"] != null ? Convert.ToInt32(ViewState["EditUserId"]) : 0;

                if (userList.Any(u => u.UserId != currentUserId && u.Email.Equals(txtEmail.Text.Trim(), StringComparison.OrdinalIgnoreCase)))
                {
                    ShowMessage("Email already exists for another user.", "error");
                    txtEmail.Focus();
                }
                else
                {
                    lblStatus.Text = string.Empty;
                    lblStatus.CssClass = "status-message";
                }
            }
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

        // Helper method to show messages
        private void ShowMessage(string message, string type)
        {
            lblStatus.Text = message;
            lblStatus.CssClass = string.IsNullOrEmpty(type) ? "status-message" : "status-message " + type;
        }
    }
}