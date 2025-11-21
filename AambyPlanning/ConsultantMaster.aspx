<%@ Page Title="Consultant Master" Language="C#" MasterPageFile="~/AambyPlanning.Master" AutoEventWireup="true" CodeBehind="ConsultantMaster.aspx.cs" Inherits="AambyPlanning.ConsultantMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        /* Minimal Custom CSS - Only Essential Styles */
        .card-header-gradient {
            background: linear-gradient(135deg, #1a2a6c, #2a4b8d, #3a6cb0);
        }
        
        .btn-gradient-success {
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            border: none;
            color: white;
        }
        
        .btn-gradient-danger {
            background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
            border: none;
            color: white;
        }
        
        .btn-gradient-primary {
            background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
            border: none;
            color: white;
        }

        .btn-gradient-warning {
            background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
            border: none;
            color: white;
        }

        .btn-gradient-info {
            background: linear-gradient(135deg, #06b6d4 0%, #0891b2 100%);
            border: none;
            color: white;
        }

        /* Sticky Table Header */
        .table-responsive {
            max-height: 600px;
            overflow-y: auto;
            position: relative;
        }

        .table-responsive .table thead th {
            position: sticky;
            top: 0;
            z-index: 10;
            background-color: #b8daff !important;
            box-shadow: 0 2px 2px -1px rgba(0, 0, 0, 0.4);
        }
    </style>

    <div class="container-fluid px-3 py-4">
        <!-- Alert Messages -->
        <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="alert alert-dismissible fade show" role="alert">
            <asp:Label ID="lblMessage" runat="server"></asp:Label>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </asp:Panel>

        <!-- Consultant Form Card -->
        <div class="card shadow-sm border-0 mb-4">
            <div class="card-header card-header-gradient text-white py-3">
                <h2 class="mb-0 d-flex align-items-center justify-content-between">
                    <span>
                        <i class="fa fa-user-tie me-2"></i>
                        <asp:Label ID="lblFormTitle" runat="server" Text="Add New Consultant"></asp:Label>
                    </span>
                    <asp:Button ID="btnExportExcel" runat="server" Text="Export to Excel" 
                        OnClick="btnExportExcel_Click" CssClass="btn btn-light btn-sm" />
                </h2>
            </div>
            <div class="card-body bg-light p-4">
                <asp:HiddenField ID="hfConsultantID" runat="server" Value="0" />
                
                <div class="row g-3">
                    <!-- Consultant Name -->
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">
                            <i class="fa fa-user me-1 text-primary"></i>Consultant Name
                            <span class="text-danger">*</span>
                        </label>
                        <asp:TextBox ID="txtConsultantName" runat="server" CssClass="form-control" 
                            placeholder="Enter Consultant Name" MaxLength="200"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvConsultantName" runat="server" 
                            ControlToValidate="txtConsultantName" ErrorMessage="Consultant Name is required" 
                            CssClass="text-danger small" Display="Dynamic" ValidationGroup="ConsultantValidation"></asp:RequiredFieldValidator>
                    </div>

                    <!-- Contact Person -->
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">
                            <i class="fa fa-user-circle me-1 text-info"></i>Contact Person
                        </label>
                        <asp:TextBox ID="txtContactPerson" runat="server" CssClass="form-control" 
                            placeholder="Enter Contact Person Name" MaxLength="200"></asp:TextBox>
                    </div>

                    <!-- Address 1 -->
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">
                            <i class="fa fa-map-marker-alt me-1 text-success"></i>Address Line 1
                        </label>
                        <asp:TextBox ID="txtAddress1" runat="server" CssClass="form-control" 
                            placeholder="Enter Address Line 1" MaxLength="250"></asp:TextBox>
                    </div>

                    <!-- Address 2 -->
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">
                            <i class="fa fa-map-marker me-1 text-success"></i>Address Line 2
                        </label>
                        <asp:TextBox ID="txtAddress2" runat="server" CssClass="form-control" 
                            placeholder="Enter Address Line 2" MaxLength="250"></asp:TextBox>
                    </div>

                    <!-- City -->
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">
                            <i class="fa fa-city me-1 text-warning"></i>City
                        </label>
                        <asp:DropDownList ID="ddlCity" runat="server" CssClass="form-select">
                            <asp:ListItem Value="0" Text="-- Select City --"></asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <!-- Contact No -->
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">
                            <i class="fa fa-phone me-1 text-primary"></i>Contact Number
                        </label>
                        <asp:TextBox ID="txtContactNo" runat="server" CssClass="form-control" 
                            placeholder="Enter Contact Number" MaxLength="15"></asp:TextBox>
                    </div>

                    <!-- Fax No -->
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">
                            <i class="fa fa-fax me-1 text-secondary"></i>Fax Number
                        </label>
                        <asp:TextBox ID="txtFaxNo" runat="server" CssClass="form-control" 
                            placeholder="Enter Fax Number" MaxLength="20"></asp:TextBox>
                    </div>

                    <!-- Email -->
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">
                            <i class="fa fa-envelope me-1 text-danger"></i>Email
                        </label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" 
                            placeholder="Enter Email Address" MaxLength="150" TextMode="Email"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="revEmail" runat="server" 
                            ControlToValidate="txtEmail" ErrorMessage="Invalid Email Format" 
                            ValidationExpression="^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$" 
                            CssClass="text-danger small" Display="Dynamic" ValidationGroup="ConsultantValidation"></asp:RegularExpressionValidator>
                    </div>

                    <!-- Specialisation -->
                    <div class="col-md-12">
                        <label class="form-label fw-semibold">
                            <i class="fa fa-certificate me-1 text-info"></i>Specialisation
                        </label>
                        <asp:TextBox ID="txtSpecialisation" runat="server" CssClass="form-control" 
                            placeholder="Enter Specialisation" TextMode="MultiLine" Rows="2"></asp:TextBox>
                    </div>

                    <!-- Tax & Registration Details Section -->
                    <div class="col-12 mt-3">
                        <h5 class="text-primary border-bottom pb-2">
                            <i class="fa fa-file-invoice me-2"></i>Tax & Registration Details
                        </h5>
                    </div>

                    <!-- PAN -->
                    <div class="col-md-4">
                        <label class="form-label fw-semibold">
                            <i class="fa fa-id-card me-1 text-primary"></i>PAN
                        </label>
                        <asp:TextBox ID="txtPAN" runat="server" CssClass="form-control" 
                            placeholder="Enter PAN Number" MaxLength="20"></asp:TextBox>
                    </div>

                    <!-- BST No -->
                    <div class="col-md-4">
                        <label class="form-label fw-semibold">
                            <i class="fa fa-file-alt me-1 text-info"></i>BST No
                        </label>
                        <asp:TextBox ID="txtBSTNo" runat="server" CssClass="form-control" 
                            placeholder="Enter BST Number" MaxLength="50"></asp:TextBox>
                    </div>

                    <!-- CST No -->
                    <div class="col-md-4">
                        <label class="form-label fw-semibold">
                            <i class="fa fa-file-alt me-1 text-success"></i>CST No
                        </label>
                        <asp:TextBox ID="txtCSTNo" runat="server" CssClass="form-control" 
                            placeholder="Enter CST Number" MaxLength="50"></asp:TextBox>
                    </div>

                    <!-- WCT No -->
                    <div class="col-md-4">
                        <label class="form-label fw-semibold">
                            <i class="fa fa-file-alt me-1 text-warning"></i>WCT No
                        </label>
                        <asp:TextBox ID="txtWCTNo" runat="server" CssClass="form-control" 
                            placeholder="Enter WCT Number" MaxLength="50"></asp:TextBox>
                    </div>

                    <!-- Service Tax No -->
                    <div class="col-md-4">
                        <label class="form-label fw-semibold">
                            <i class="fa fa-file-alt me-1 text-danger"></i>Service Tax No
                        </label>
                        <asp:TextBox ID="txtServiceTaxNo" runat="server" CssClass="form-control" 
                            placeholder="Enter Service Tax Number" MaxLength="50"></asp:TextBox>
                    </div>

                    <!-- PF No -->
                    <div class="col-md-4">
                        <label class="form-label fw-semibold">
                            <i class="fa fa-file-alt me-1 text-primary"></i>PF No
                        </label>
                        <asp:TextBox ID="txtPFNo" runat="server" CssClass="form-control" 
                            placeholder="Enter PF Number" MaxLength="50"></asp:TextBox>
                    </div>

                    <!-- Lab Lic No -->
                    <div class="col-md-4">
                        <label class="form-label fw-semibold">
                            <i class="fa fa-file-alt me-1 text-info"></i>Lab License No
                        </label>
                        <asp:TextBox ID="txtLabLicNo" runat="server" CssClass="form-control" 
                            placeholder="Enter Lab License Number" MaxLength="50"></asp:TextBox>
                    </div>

                    <!-- ESIC No -->
                    <div class="col-md-4">
                        <label class="form-label fw-semibold">
                            <i class="fa fa-file-alt me-1 text-success"></i>ESIC No
                        </label>
                        <asp:TextBox ID="txtESICNo" runat="server" CssClass="form-control" 
                            placeholder="Enter ESIC Number" MaxLength="50"></asp:TextBox>
                    </div>

                    <!-- Prof Tax No -->
                    <div class="col-md-4">
                        <label class="form-label fw-semibold">
                            <i class="fa fa-file-alt me-1 text-warning"></i>Professional Tax No
                        </label>
                        <asp:TextBox ID="txtProfTaxNo" runat="server" CssClass="form-control" 
                            placeholder="Enter Professional Tax Number" MaxLength="50"></asp:TextBox>
                    </div>

                    <!-- Banking Details Section -->
                    <div class="col-12 mt-3">
                        <h5 class="text-primary border-bottom pb-2">
                            <i class="fa fa-university me-2"></i>Banking Details
                        </h5>
                    </div>

                    <!-- Bank Name -->
                    <div class="col-md-4">
                        <label class="form-label fw-semibold">
                            <i class="fa fa-university me-1 text-primary"></i>Bank Name
                        </label>
                        <asp:TextBox ID="txtBankName" runat="server" CssClass="form-control" 
                            placeholder="Enter Bank Name" MaxLength="250"></asp:TextBox>
                    </div>

                    <!-- Account No -->
                    <div class="col-md-4">
                        <label class="form-label fw-semibold">
                            <i class="fa fa-credit-card me-1 text-info"></i>Account Number
                        </label>
                        <asp:TextBox ID="txtAcNo" runat="server" CssClass="form-control" 
                            placeholder="Enter Account Number" MaxLength="50"></asp:TextBox>
                    </div>

                    <!-- Branch -->
                    <div class="col-md-4">
                        <label class="form-label fw-semibold">
                            <i class="fa fa-code-branch me-1 text-success"></i>Branch
                        </label>
                        <asp:TextBox ID="txtBranch" runat="server" CssClass="form-control" 
                            placeholder="Enter Branch Name" MaxLength="150"></asp:TextBox>
                    </div>

                    <!-- Remark -->
                    <div class="col-md-12">
                        <label class="form-label fw-semibold">
                            <i class="fa fa-comment me-1 text-secondary"></i>Remark
                        </label>
                        <asp:TextBox ID="txtRemark" runat="server" CssClass="form-control" 
                            placeholder="Enter Remarks" TextMode="MultiLine" Rows="2"></asp:TextBox>
                    </div>

                    <!-- Buttons -->
                    <div class="col-12 mt-4 pt-3 border-top">
                        <div class="d-flex gap-2 justify-content-center">
                            <asp:Button ID="btnSave" Text="Save Consultant" runat="server"
                                OnClick="btnSave_Click" ValidationGroup="ConsultantValidation"
                                CssClass="btn btn-gradient-success px-4 fw-semibold" />

                            <asp:Button ID="btnUpdate" Text="Update Consultant" runat="server"
                                OnClick="btnUpdate_Click" ValidationGroup="ConsultantValidation"
                                CssClass="btn btn-gradient-warning px-4 fw-semibold" Visible="false" />

                            <asp:Button ID="btnCancel" Text="Cancel" runat="server"
                                OnClick="btnCancel_Click"
                                CssClass="btn btn-gradient-danger px-4 fw-semibold" />
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- GridView Container -->
        <div class="card shadow-sm border-0">
            <div class="card-header card-header-gradient text-white py-3">
                <h4 class="mb-0">
                    <i class="fa fa-list me-2"></i>Consultant List
                </h4>
            </div>
            <div class="card-body p-3">
                <div class="table-responsive">
                    <asp:GridView ID="gvConsultants" runat="server" DataKeyNames="ConsultantID" 
                        AutoGenerateColumns="False" AllowPaging="True" PageSize="50"
                        CssClass="table table-hover table-bordered align-middle mb-0" 
                        OnRowCommand="gvConsultants_RowCommand" OnPageIndexChanging="gvConsultants_PageIndexChanging">
                        <HeaderStyle CssClass="table-primary text-center fw-semibold" />
                        <RowStyle CssClass="text-center" />
                        <PagerStyle CssClass="pagination-ys" HorizontalAlign="Center" />
                        <PagerSettings Mode="NumericFirstLast" FirstPageText="First" LastPageText="Last" PageButtonCount="10" />
                        <Columns>
                            <asp:BoundField DataField="ConsultantID" HeaderText="ID" ReadOnly="True" ItemStyle-Width="50px" />
                            <asp:BoundField DataField="ConsultantName" HeaderText="Consultant Name" ItemStyle-Width="150px" />
                            <asp:BoundField DataField="ContactPerson" HeaderText="Contact Person" ItemStyle-Width="120px" />
                            <asp:BoundField DataField="Address1" HeaderText="Address 1" ItemStyle-Width="150px" />
                            <asp:BoundField DataField="Address2" HeaderText="Address 2" ItemStyle-Width="150px" />
                            <asp:BoundField DataField="CityName" HeaderText="City" ItemStyle-Width="100px" />
                            <asp:BoundField DataField="ContactNo" HeaderText="Contact No" ItemStyle-Width="100px" />
                            <asp:BoundField DataField="FaxNo" HeaderText="Fax No" ItemStyle-Width="100px" />
                            <asp:BoundField DataField="Email" HeaderText="Email" ItemStyle-Width="150px" />
                            <asp:BoundField DataField="Specialisation" HeaderText="Specialisation" ItemStyle-Width="150px" />
                            <asp:BoundField DataField="PAN" HeaderText="PAN" ItemStyle-Width="100px" />
                            <asp:BoundField DataField="BSTNo" HeaderText="BST No" ItemStyle-Width="100px" />
                            <asp:BoundField DataField="CSTNo" HeaderText="CST No" ItemStyle-Width="100px" />
                            <asp:BoundField DataField="WCTNo" HeaderText="WCT No" ItemStyle-Width="100px" />
                            <asp:BoundField DataField="ServiceTaxNo" HeaderText="Service Tax No" ItemStyle-Width="120px" />
                            <asp:BoundField DataField="PFNo" HeaderText="PF No" ItemStyle-Width="100px" />
                            <asp:BoundField DataField="LabLicNo" HeaderText="Lab Lic No" ItemStyle-Width="100px" />
                            <asp:BoundField DataField="ESICNo" HeaderText="ESIC No" ItemStyle-Width="100px" />
                            <asp:BoundField DataField="ProfTaxNo" HeaderText="Prof Tax No" ItemStyle-Width="100px" />
                            <asp:BoundField DataField="BankName" HeaderText="Bank Name" ItemStyle-Width="120px" />
                            <asp:BoundField DataField="AcNo" HeaderText="Account No" ItemStyle-Width="120px" />
                            <asp:BoundField DataField="Branch" HeaderText="Branch" ItemStyle-Width="120px" />
                            <asp:BoundField DataField="Remark" HeaderText="Remark" ItemStyle-Width="150px" />
                            
                            <asp:TemplateField HeaderText="Status" ItemStyle-Width="80px">
                                <ItemTemplate>
                                    <asp:Button
                                        ID="btnActive"
                                        runat="server"
                                        Text='<%# (Convert.ToBoolean(Eval("IsActive"))) ? "Active" : "Inactive" %>'
                                        CommandArgument='<%# Eval("ConsultantID") %>'
                                        CommandName="ToggleActive"
                                        CssClass='<%# (Convert.ToBoolean(Eval("IsActive"))) ? "btn btn-sm btn-success" : "btn btn-sm btn-danger" %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            
                            <asp:TemplateField HeaderText="Actions" ItemStyle-Width="120px">
                                <ItemTemplate>
                                    <asp:Button
                                        ID="btnEdit"
                                        runat="server"
                                        Text="Edit"
                                        CommandArgument='<%# Eval("ConsultantID") %>'
                                        CommandName="EditRow"
                                        CssClass="btn btn-sm btn-gradient-primary me-1" />
                                    <asp:Button
                                        ID="btnDelete"
                                        runat="server"
                                        Text="Delete"
                                        CommandArgument='<%# Eval("ConsultantID") %>'
                                        CommandName="DeleteRow"
                                        CssClass="btn btn-sm btn-gradient-danger"
                                        OnClientClick="return confirm('Are you sure you want to delete this consultant?');" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

