using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AambyPlanning
{
    public partial class CreateProfile : System.Web.UI.Page
    {
        // Static in-memory storage for demo purposes
        private static List<ProfileData> profiles = new List<ProfileData>();
        private static List<string> availableForms = new List<string>
        {
            "Dashboard",
            "User Management",
            "Create User",
            "User List",
            "Profile Management",
            "Create Profile",
            "Reports",
            "Settings",
            "Audit Logs",
            "System Configuration"
        };

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Initialize with some demo profiles
                if (profiles.Count == 0)
                {
                    profiles.Add(new ProfileData
                    {
                        ProfileId = 1,
                        ProfileName = "Administrator",
                        Permissions = new List<string> { "Dashboard", "User Management", "Create User", "User List", "Profile Management", "Create Profile", "Reports", "Settings", "Audit Logs", "System Configuration" }
                    });
                    profiles.Add(new ProfileData
                    {
                        ProfileId = 2,
                        ProfileName = "Manager",
                        Permissions = new List<string> { "Dashboard", "User Management", "User List", "Reports" }
                    });
                    profiles.Add(new ProfileData
                    {
                        ProfileId = 3,
                        ProfileName = "User",
                        Permissions = new List<string> { "Dashboard", "Reports" }
                    });
                }

                LoadProfiles();
            }
        }

        private void LoadProfiles()
        {
            ddlProfiles.Items.Clear();
            ddlProfiles.Items.Add(new ListItem("-- Select Profile --", "0"));

            foreach (var profile in profiles)
            {
                ddlProfiles.Items.Add(new ListItem(profile.ProfileName, profile.ProfileId.ToString()));
            }
        }

        protected void btnAddProfile_Click(object sender, EventArgs e)
        {
            try
            {
                string profileName = txtProfileName.Text.Trim();

                if (string.IsNullOrEmpty(profileName))
                {
                    ShowMessage("Please enter a profile name.", false);
                    return;
                }

                // Check if profile already exists
                if (profiles.Any(p => p.ProfileName.Equals(profileName, StringComparison.OrdinalIgnoreCase)))
                {
                    ShowMessage("Profile name already exists. Please choose a different name.", false);
                    return;
                }

                // Add new profile
                int newId = profiles.Count > 0 ? profiles.Max(p => p.ProfileId) + 1 : 1;
                profiles.Add(new ProfileData
                {
                    ProfileId = newId,
                    ProfileName = profileName,
                    Permissions = new List<string>()
                });

                ShowMessage($"Profile '{profileName}' created successfully!", true);
                txtProfileName.Text = string.Empty;
                LoadProfiles();
            }
            catch (Exception ex)
            {
                ShowMessage($"Error creating profile: {ex.Message}", false);
            }
        }

        protected void ddlProfiles_SelectedIndexChanged(object sender, EventArgs e)
        {
            int selectedProfileId = int.Parse(ddlProfiles.SelectedValue);

            if (selectedProfileId == 0)
            {
                check.Visible = false;
                return;
            }

            // Load permissions for selected profile
            var selectedProfile = profiles.FirstOrDefault(p => p.ProfileId == selectedProfileId);
            if (selectedProfile != null)
            {
                check.Visible = true;
                chkForms.Items.Clear();

                foreach (var form in availableForms)
                {
                    ListItem item = new ListItem(form, form);
                    item.Selected = selectedProfile.Permissions.Contains(form);
                    chkForms.Items.Add(item);
                }
            }
        }

        protected void btnSavePermissions_Click(object sender, EventArgs e)
        {
            try
            {
                int selectedProfileId = int.Parse(ddlProfiles.SelectedValue);

                if (selectedProfileId == 0)
                {
                    ShowMessage("Please select a profile to save permissions.", false);
                    return;
                }

                var selectedProfile = profiles.FirstOrDefault(p => p.ProfileId == selectedProfileId);
                if (selectedProfile != null)
                {
                    // Update permissions
                    selectedProfile.Permissions.Clear();
                    foreach (ListItem item in chkForms.Items)
                    {
                        if (item.Selected)
                        {
                            selectedProfile.Permissions.Add(item.Value);
                        }
                    }

                    ShowMessage($"Permissions saved successfully for '{selectedProfile.ProfileName}'!", true);
                }
            }
            catch (Exception ex)
            {
                ShowMessage($"Error saving permissions: {ex.Message}", false);
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtProfileName.Text = string.Empty;
            ddlProfiles.SelectedIndex = 0;
            check.Visible = false;
            chkForms.Items.Clear();
            lblStatus.Text = string.Empty;
            lblStatus.CssClass = string.Empty;
        }

        private void ShowMessage(string message, bool isSuccess)
        {
            lblStatus.Text = message;
            lblStatus.CssClass = isSuccess ? "alert alert-success-custom rounded p-2" : "alert alert-error-custom rounded p-2";
        }

        // Helper class for profile data
        private class ProfileData
        {
            public int ProfileId { get; set; }
            public string ProfileName { get; set; }
            public List<string> Permissions { get; set; }
        }
    }
}