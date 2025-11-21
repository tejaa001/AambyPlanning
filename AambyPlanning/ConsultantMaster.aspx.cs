using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using OfficeOpenXml;
using System.IO;

namespace AambyPlanning
{
    public partial class ConsultantMaster : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCities();
                BindConsultantsGrid();
            }
        }

        #region Load Cities
        private void LoadCities()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = "SELECT CityID, CityName FROM [Contracts].[CityMaster] ORDER BY CityName";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        con.Open();
                        SqlDataReader reader = cmd.ExecuteReader();
                        ddlCity.DataSource = reader;
                        ddlCity.DataTextField = "CityName";
                        ddlCity.DataValueField = "CityID";
                        ddlCity.DataBind();
                        ddlCity.Items.Insert(0, new ListItem("-- Select City --", "0"));
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading cities: " + ex.Message, "danger");
            }
        }
        #endregion

        #region Bind Consultants Grid
        private void BindConsultantsGrid()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = @"SELECT c.ConsultantID, c.ConsultantName, c.ContactPerson, 
                                    c.Address1, c.Address2, ISNULL(ct.CityName, 'N/A') AS CityName, 
                                    c.ContactNo, c.FaxNo, c.Email, c.Specialisation, 
                                    c.PAN, c.BSTNo, c.CSTNo, c.WCTNo, c.ServiceTaxNo, 
                                    c.PFNo, c.LabLicNo, c.ESICNo, c.ProfTaxNo, 
                                    c.BankName, c.AcNo, c.Branch, c.Remark, c.IsActive
                                    FROM [Contracts].[ConsultantMaster] c
                                    LEFT JOIN [Contracts].[CityMaster] ct ON c.CityID = ct.CityID
                                    ORDER BY c.ConsultantID DESC";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        con.Open();
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        gvConsultants.DataSource = dt;
                        gvConsultants.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading consultants: " + ex.Message, "danger");
            }
        }
        #endregion

        #region Save Consultant
        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            try
            {
                // Check for duplicate consultant name
                if (IsConsultantNameExists(txtConsultantName.Text.Trim(), 0))
                {
                    ShowMessage("A consultant with this name already exists!", "warning");
                    return;
                }

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = @"INSERT INTO [Contracts].[ConsultantMaster] 
                                    (ConsultantName, ContactPerson, Address1, Address2, CityID, 
                                    ContactNo, FaxNo, Email, Specialisation, PAN, BSTNo, CSTNo, 
                                    WCTNo, ServiceTaxNo, PFNo, LabLicNo, ESICNo, ProfTaxNo, 
                                    BankName, AcNo, Branch, Remark, IsActive, CreatedDate)
                                    VALUES 
                                    (@ConsultantName, @ContactPerson, @Address1, @Address2, @CityID, 
                                    @ContactNo, @FaxNo, @Email, @Specialisation, @PAN, @BSTNo, @CSTNo, 
                                    @WCTNo, @ServiceTaxNo, @PFNo, @LabLicNo, @ESICNo, @ProfTaxNo, 
                                    @BankName, @AcNo, @Branch, @Remark, 1, GETDATE())";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        AddConsultantParameters(cmd);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                ShowMessage("Consultant added successfully!", "success");
                ClearForm();
                BindConsultantsGrid();
            }
            catch (Exception ex)
            {
                ShowMessage("Error saving consultant: " + ex.Message, "danger");
            }
        }
        #endregion

        #region Update Consultant
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            try
            {
                int consultantID = Convert.ToInt32(hfConsultantID.Value);

                // Check for duplicate consultant name (excluding current record)
                if (IsConsultantNameExists(txtConsultantName.Text.Trim(), consultantID))
                {
                    ShowMessage("A consultant with this name already exists!", "warning");
                    return;
                }

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = @"UPDATE [Contracts].[ConsultantMaster] 
                                    SET ConsultantName = @ConsultantName, ContactPerson = @ContactPerson, 
                                    Address1 = @Address1, Address2 = @Address2, CityID = @CityID, 
                                    ContactNo = @ContactNo, FaxNo = @FaxNo, Email = @Email, 
                                    Specialisation = @Specialisation, PAN = @PAN, BSTNo = @BSTNo, 
                                    CSTNo = @CSTNo, WCTNo = @WCTNo, ServiceTaxNo = @ServiceTaxNo, 
                                    PFNo = @PFNo, LabLicNo = @LabLicNo, ESICNo = @ESICNo, 
                                    ProfTaxNo = @ProfTaxNo, BankName = @BankName, AcNo = @AcNo, 
                                    Branch = @Branch, Remark = @Remark, UpdatedDate = GETDATE()
                                    WHERE ConsultantID = @ConsultantID";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        AddConsultantParameters(cmd);
                        cmd.Parameters.AddWithValue("@ConsultantID", consultantID);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                ShowMessage("Consultant updated successfully!", "success");
                ClearForm();
                BindConsultantsGrid();
            }
            catch (Exception ex)
            {
                ShowMessage("Error updating consultant: " + ex.Message, "danger");
            }
        }
        #endregion

        #region Cancel Button
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ClearForm();
        }
        #endregion

        #region GridView Row Command
        protected void gvConsultants_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int consultantID = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "EditRow")
            {
                LoadConsultantForEdit(consultantID);
            }
            else if (e.CommandName == "DeleteRow")
            {
                DeleteConsultant(consultantID);
            }
            else if (e.CommandName == "ToggleActive")
            {
                ToggleActiveStatus(consultantID);
            }
        }
        #endregion

        #region Load Consultant for Edit
        private void LoadConsultantForEdit(int consultantID)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = @"SELECT * FROM [Contracts].[ConsultantMaster] 
                                    WHERE ConsultantID = @ConsultantID";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@ConsultantID", consultantID);
                        con.Open();
                        SqlDataReader reader = cmd.ExecuteReader();

                        if (reader.Read())
                        {
                            hfConsultantID.Value = consultantID.ToString();
                            txtConsultantName.Text = reader["ConsultantName"].ToString();
                            txtContactPerson.Text = reader["ContactPerson"].ToString();
                            txtAddress1.Text = reader["Address1"].ToString();
                            txtAddress2.Text = reader["Address2"].ToString();
                            
                            if (reader["CityID"] != DBNull.Value)
                                ddlCity.SelectedValue = reader["CityID"].ToString();
                            
                            txtContactNo.Text = reader["ContactNo"].ToString();
                            txtFaxNo.Text = reader["FaxNo"].ToString();
                            txtEmail.Text = reader["Email"].ToString();
                            txtSpecialisation.Text = reader["Specialisation"].ToString();
                            txtPAN.Text = reader["PAN"].ToString();
                            txtBSTNo.Text = reader["BSTNo"].ToString();
                            txtCSTNo.Text = reader["CSTNo"].ToString();
                            txtWCTNo.Text = reader["WCTNo"].ToString();
                            txtServiceTaxNo.Text = reader["ServiceTaxNo"].ToString();
                            txtPFNo.Text = reader["PFNo"].ToString();
                            txtLabLicNo.Text = reader["LabLicNo"].ToString();
                            txtESICNo.Text = reader["ESICNo"].ToString();
                            txtProfTaxNo.Text = reader["ProfTaxNo"].ToString();
                            txtBankName.Text = reader["BankName"].ToString();
                            txtAcNo.Text = reader["AcNo"].ToString();
                            txtBranch.Text = reader["Branch"].ToString();
                            txtRemark.Text = reader["Remark"].ToString();

                            lblFormTitle.Text = "Edit Consultant";
                            btnSave.Visible = false;
                            btnUpdate.Visible = true;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading consultant: " + ex.Message, "danger");
            }
        }
        #endregion

        #region Delete Consultant
        private void DeleteConsultant(int consultantID)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = "DELETE FROM [Contracts].[ConsultantMaster] WHERE ConsultantID = @ConsultantID";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@ConsultantID", consultantID);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                ShowMessage("Consultant deleted successfully!", "success");
                BindConsultantsGrid();
            }
            catch (Exception ex)
            {
                ShowMessage("Error deleting consultant: " + ex.Message, "danger");
            }
        }
        #endregion

        #region Toggle Active Status
        private void ToggleActiveStatus(int consultantID)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = @"UPDATE [Contracts].[ConsultantMaster] 
                                    SET IsActive = CASE WHEN IsActive = 1 THEN 0 ELSE 1 END, 
                                    UpdatedDate = GETDATE() 
                                    WHERE ConsultantID = @ConsultantID";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@ConsultantID", consultantID);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                ShowMessage("Status updated successfully!", "success");
                BindConsultantsGrid();
            }
            catch (Exception ex)
            {
                ShowMessage("Error updating status: " + ex.Message, "danger");
            }
        }
        #endregion

        #region Pagination
        protected void gvConsultants_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvConsultants.PageIndex = e.NewPageIndex;
            BindConsultantsGrid();
        }
        #endregion

        #region Export to Excel
        protected void btnExportExcel_Click(object sender, EventArgs e)
        {
            try
            {
                // Set EPPlus license context
                ExcelPackage.License.SetNonCommercialPersonal("MP_Tech_Solution");

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = @"SELECT c.ConsultantID, c.ConsultantName, c.ContactPerson, 
                                    c.Address1, c.Address2, ISNULL(ct.CityName, 'N/A') AS City, 
                                    c.ContactNo, c.FaxNo, c.Email, c.Specialisation, c.PAN, 
                                    c.BSTNo, c.CSTNo, c.WCTNo, c.ServiceTaxNo, c.PFNo, 
                                    c.LabLicNo, c.ESICNo, c.ProfTaxNo, c.BankName, c.AcNo, 
                                    c.Branch, c.Remark, 
                                    CASE WHEN c.IsActive = 1 THEN 'Active' ELSE 'Inactive' END AS Status,
                                    c.CreatedDate
                                    FROM [Contracts].[ConsultantMaster] c
                                    LEFT JOIN [Contracts].[CityMaster] ct ON c.CityID = ct.CityID
                                    ORDER BY c.ConsultantID DESC";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        con.Open();
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        using (ExcelPackage package = new ExcelPackage())
                        {
                            ExcelWorksheet worksheet = package.Workbook.Worksheets.Add("Consultants");

                            // Add headers
                            for (int i = 0; i < dt.Columns.Count; i++)
                            {
                                worksheet.Cells[1, i + 1].Value = dt.Columns[i].ColumnName;
                                worksheet.Cells[1, i + 1].Style.Font.Bold = true;
                                worksheet.Cells[1, i + 1].Style.Fill.PatternType = OfficeOpenXml.Style.ExcelFillStyle.Solid;
                                worksheet.Cells[1, i + 1].Style.Fill.BackgroundColor.SetColor(System.Drawing.Color.LightBlue);
                            }

                            // Add data
                            for (int i = 0; i < dt.Rows.Count; i++)
                            {
                                for (int j = 0; j < dt.Columns.Count; j++)
                                {
                                    worksheet.Cells[i + 2, j + 1].Value = dt.Rows[i][j].ToString();
                                }
                            }

                            // Auto-fit columns
                            worksheet.Cells[worksheet.Dimension.Address].AutoFitColumns();

                            // Generate file
                            string fileName = "Consultants_" + DateTime.Now.ToString("yyyyMMdd_HHmmss") + ".xlsx";
                            byte[] fileBytes = package.GetAsByteArray();

                            Response.Clear();
                            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                            Response.AddHeader("content-disposition", "attachment; filename=" + fileName);
                            Response.BinaryWrite(fileBytes);
                            Response.End();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error exporting to Excel: " + ex.Message, "danger");
            }
        }
        #endregion

        #region Helper Methods

        private void AddConsultantParameters(SqlCommand cmd)
        {
            cmd.Parameters.AddWithValue("@ConsultantName", txtConsultantName.Text.Trim());
            cmd.Parameters.AddWithValue("@ContactPerson", string.IsNullOrEmpty(txtContactPerson.Text.Trim()) ? (object)DBNull.Value : txtContactPerson.Text.Trim());
            cmd.Parameters.AddWithValue("@Address1", string.IsNullOrEmpty(txtAddress1.Text.Trim()) ? (object)DBNull.Value : txtAddress1.Text.Trim());
            cmd.Parameters.AddWithValue("@Address2", string.IsNullOrEmpty(txtAddress2.Text.Trim()) ? (object)DBNull.Value : txtAddress2.Text.Trim());
            cmd.Parameters.AddWithValue("@CityID", ddlCity.SelectedValue == "0" ? (object)DBNull.Value : ddlCity.SelectedValue);
            cmd.Parameters.AddWithValue("@ContactNo", string.IsNullOrEmpty(txtContactNo.Text.Trim()) ? (object)DBNull.Value : txtContactNo.Text.Trim());
            cmd.Parameters.AddWithValue("@FaxNo", string.IsNullOrEmpty(txtFaxNo.Text.Trim()) ? (object)DBNull.Value : txtFaxNo.Text.Trim());
            cmd.Parameters.AddWithValue("@Email", string.IsNullOrEmpty(txtEmail.Text.Trim()) ? (object)DBNull.Value : txtEmail.Text.Trim());
            cmd.Parameters.AddWithValue("@Specialisation", string.IsNullOrEmpty(txtSpecialisation.Text.Trim()) ? (object)DBNull.Value : txtSpecialisation.Text.Trim());
            cmd.Parameters.AddWithValue("@PAN", string.IsNullOrEmpty(txtPAN.Text.Trim()) ? (object)DBNull.Value : txtPAN.Text.Trim());
            cmd.Parameters.AddWithValue("@BSTNo", string.IsNullOrEmpty(txtBSTNo.Text.Trim()) ? (object)DBNull.Value : txtBSTNo.Text.Trim());
            cmd.Parameters.AddWithValue("@CSTNo", string.IsNullOrEmpty(txtCSTNo.Text.Trim()) ? (object)DBNull.Value : txtCSTNo.Text.Trim());
            cmd.Parameters.AddWithValue("@WCTNo", string.IsNullOrEmpty(txtWCTNo.Text.Trim()) ? (object)DBNull.Value : txtWCTNo.Text.Trim());
            cmd.Parameters.AddWithValue("@ServiceTaxNo", string.IsNullOrEmpty(txtServiceTaxNo.Text.Trim()) ? (object)DBNull.Value : txtServiceTaxNo.Text.Trim());
            cmd.Parameters.AddWithValue("@PFNo", string.IsNullOrEmpty(txtPFNo.Text.Trim()) ? (object)DBNull.Value : txtPFNo.Text.Trim());
            cmd.Parameters.AddWithValue("@LabLicNo", string.IsNullOrEmpty(txtLabLicNo.Text.Trim()) ? (object)DBNull.Value : txtLabLicNo.Text.Trim());
            cmd.Parameters.AddWithValue("@ESICNo", string.IsNullOrEmpty(txtESICNo.Text.Trim()) ? (object)DBNull.Value : txtESICNo.Text.Trim());
            cmd.Parameters.AddWithValue("@ProfTaxNo", string.IsNullOrEmpty(txtProfTaxNo.Text.Trim()) ? (object)DBNull.Value : txtProfTaxNo.Text.Trim());
            cmd.Parameters.AddWithValue("@BankName", string.IsNullOrEmpty(txtBankName.Text.Trim()) ? (object)DBNull.Value : txtBankName.Text.Trim());
            cmd.Parameters.AddWithValue("@AcNo", string.IsNullOrEmpty(txtAcNo.Text.Trim()) ? (object)DBNull.Value : txtAcNo.Text.Trim());
            cmd.Parameters.AddWithValue("@Branch", string.IsNullOrEmpty(txtBranch.Text.Trim()) ? (object)DBNull.Value : txtBranch.Text.Trim());
            cmd.Parameters.AddWithValue("@Remark", string.IsNullOrEmpty(txtRemark.Text.Trim()) ? (object)DBNull.Value : txtRemark.Text.Trim());
        }

        private bool IsConsultantNameExists(string consultantName, int excludeConsultantID)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = @"SELECT COUNT(*) FROM [Contracts].[ConsultantMaster] 
                                    WHERE ConsultantName = @ConsultantName 
                                    AND ConsultantID != @ConsultantID";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@ConsultantName", consultantName);
                        cmd.Parameters.AddWithValue("@ConsultantID", excludeConsultantID);
                        con.Open();
                        int count = (int)cmd.ExecuteScalar();
                        return count > 0;
                    }
                }
            }
            catch
            {
                return false;
            }
        }

        private void ClearForm()
        {
            hfConsultantID.Value = "0";
            txtConsultantName.Text = "";
            txtContactPerson.Text = "";
            txtAddress1.Text = "";
            txtAddress2.Text = "";
            ddlCity.SelectedIndex = 0;
            txtContactNo.Text = "";
            txtFaxNo.Text = "";
            txtEmail.Text = "";
            txtSpecialisation.Text = "";
            txtPAN.Text = "";
            txtBSTNo.Text = "";
            txtCSTNo.Text = "";
            txtWCTNo.Text = "";
            txtServiceTaxNo.Text = "";
            txtPFNo.Text = "";
            txtLabLicNo.Text = "";
            txtESICNo.Text = "";
            txtProfTaxNo.Text = "";
            txtBankName.Text = "";
            txtAcNo.Text = "";
            txtBranch.Text = "";
            txtRemark.Text = "";

            lblFormTitle.Text = "Add New Consultant";
            btnSave.Visible = true;
            btnUpdate.Visible = false;
        }

        private void ShowMessage(string message, string type)
        {
            pnlMessage.Visible = true;
            lblMessage.Text = message;
            pnlMessage.CssClass = "alert alert-" + type + " alert-dismissible fade show";
        }

        #endregion
    }
}