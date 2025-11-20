<%@ Page Title="CreateProfile" Language="C#" MasterPageFile="~/AdminZone.Master" AutoEventWireup="true" CodeBehind="CreateProfile.aspx.cs" Inherits="AambyPlanning.CreateProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        /* Minimal Custom CSS - Only Essential Styles */
        .card-header-gradient {
            background:  linear-gradient(135deg, #1a2a6c, #2a4b8d, #3a6cb0);
        }

        .btn-gradient-primary {
            background:  linear-gradient(135deg, #3a6cb0);
            border: none;
            color: white;
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

        .alert-success-custom {
            background: #d1fae5;
            color: #065f46;
            border: 1px solid #6ee7b7;
        }

        .alert-error-custom {
            background: #fee2e2;
            color: #991b1b;
            border: 1px solid #fca5a5;
        }

        .section-card {
            transition: transform 0.2s ease;
        }

        .section-card:hover {
            transform: translateY(-2px);
        }
    </style>

    <div class="container-fluid px-3 py-4">
        <!-- Create Profile Card -->
        <div class="card shadow-sm border-0">
            <div class="card-header card-header-gradient text-white py-3">
                <h2 class="mb-0 d-flex align-items-center">
                    <i class="fa fa-id-badge me-2"></i>
                    Create Profile
                </h2>
            </div>
            <div class="card-body bg-light p-4">
                <!-- Status Label -->
                <div class="text-center mb-3">
                    <asp:Label ID="lblStatus" runat="server" CssClass="fw-bold fs-6"></asp:Label>
                </div>

                <div class="row g-4" id="dform" runat="server">
                    <!-- Profile Name Section -->
                    <div class="col-md-6 col-12">
                        <div class="section-card p-3 border rounded-3 bg-white shadow-sm h-100">
                            <label for="txtProfileName" class="form-label fw-bold text-secondary">
                                <i class="fa fa-id-badge me-2 text-primary"></i>Profile Name
                                <span class="text-danger">*</span>
                            </label>
                            <asp:TextBox ID="txtProfileName" runat="server" 
                                Placeholder="Enter Profile Name"
                                CssClass="form-control mb-3 border-primary shadow-sm" />
                            <asp:RequiredFieldValidator ID="rfvProfileName" runat="server"
                                ControlToValidate="txtProfileName"
                                ErrorMessage="Profile Name is required"
                                ForeColor="#ef4444"
                                Display="Dynamic"
                                CssClass="small mt-1" />

                            <asp:Button ID="btnAddProfile" runat="server" 
                                Text="Add Profile"
                                CssClass="btn btn-gradient-primary fw-semibold shadow-sm"
                                OnClick="btnAddProfile_Click" />
                        </div>
                    </div>

                    <!-- Permission Section -->
                    <div class="col-md-6 col-12">
                        <div class="section-card p-3 border rounded-3 bg-white shadow-sm h-100">
                            <label for="ddlProfiles" class="form-label fw-bold text-secondary">
                                <i class="fa fa-key me-2 text-success"></i>Permission
                                <span class="text-danger">*</span>
                            </label>
                            <asp:DropDownList ID="ddlProfiles" runat="server" 
                                AutoPostBack="true"
                                CssClass="form-select mb-3 border-success shadow-sm"
                                OnSelectedIndexChanged="ddlProfiles_SelectedIndexChanged">
                                <asp:ListItem Text="-- Select Profile --" Value="0" />
                            </asp:DropDownList>

                            <div class="checkboxes ps-2" id="check" runat="server" visible="false">
                                <asp:CheckBoxList ID="chkForms" runat="server" 
                                    RepeatDirection="Vertical"
                                    CssClass="form-check text-start fw-semibold text-dark" />
                            </div>

                            <div class="d-flex justify-content-between mt-3 gap-2">
                                <asp:Button ID="btnSavePermissions" runat="server"
                                    CssClass="btn btn-gradient-success px-4 fw-semibold shadow-sm"
                                    Text="Save Permissions"
                                    OnClick="btnSavePermissions_Click" />

                                <asp:Button ID="btnClear" runat="server"
                                    CssClass="btn btn-gradient-danger px-4 fw-semibold shadow-sm"
                                    Text="Clear"
                                    CausesValidation="false"
                                    OnClick="btnClear_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
