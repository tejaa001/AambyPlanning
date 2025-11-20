<%@ Page Title="CreateUser" Language="C#" MasterPageFile="~/AdminZone.Master" AutoEventWireup="true" CodeBehind="CreateUser.aspx.cs" Inherits="AambyPlanning.CreateUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        /* Minimal Custom CSS - Only Essential Styles */
        .card-header-gradient {
            background:linear-gradient(135deg, #1a2a6c, #2a4b8d, #3a6cb0);
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
    </style>

    <div class="container-fluid px-3 py-4">
        <!-- Create User Card -->
        <div class="card shadow-sm border-0">
            <div class="card-header card-header-gradient text-white py-3">
                <h2 class="mb-0 d-flex align-items-center">
                    <i class="fa fa-user-plus me-2"></i>
                    Create New User
                </h2>
            </div>
            <div class="card-body bg-light p-4">
                <!-- Status Label -->
                <asp:Label ID="lblStatus" runat="server" CssClass="d-none"></asp:Label>

                <div class="row g-3" id="dform" runat="server">
                    <!-- User Name -->
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">
                            <i class="fa fa-user me-1 text-primary"></i>User Name
                            <span class="text-danger">*</span>
                        </label>
                        <asp:TextBox ID="txtUserName" runat="server" CssClass="form-control"
                            AutoPostBack="true" OnTextChanged="txtUserName_TextChanged"
                            placeholder="Enter User Name"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvUserName" runat="server"
                            ControlToValidate="txtUserName"
                            ErrorMessage="User Name is required"
                            ForeColor="#ef4444"
                            Display="Dynamic"
                            CssClass="small mt-1" />
                    </div>

                    <!-- Employee ID -->
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">
                            <i class="fa fa-id-badge me-1 text-info"></i>Employee ID
                            <span class="text-danger">*</span>
                        </label>
                        <asp:TextBox ID="txtEmpId" runat="server" CssClass="form-control"
                            AutoPostBack="true" OnTextChanged="txtEmpId_TextChanged"
                            placeholder="Enter Employee ID"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEmpId" runat="server"
                            ControlToValidate="txtEmpId"
                            ErrorMessage="Employee ID is required"
                            ForeColor="#ef4444"
                            Display="Dynamic"
                            CssClass="small mt-1" />
                    </div>

                    <!-- Employee Name -->
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">
                            <i class="fa fa-user-tie me-1 text-success"></i>Employee Name
                            <span class="text-danger">*</span>
                        </label>
                        <asp:TextBox ID="txtEmpName" runat="server" CssClass="form-control"
                            placeholder="Enter Employee Name"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEmpName" runat="server"
                            ControlToValidate="txtEmpName"
                            ErrorMessage="Employee Name is required"
                            ForeColor="#ef4444"
                            Display="Dynamic"
                            CssClass="small mt-1" />
                    </div>

                    <!-- Profile -->
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">
                            <i class="fa fa-briefcase me-1 text-warning"></i>Profile
                            <span class="text-danger">*</span>
                        </label>
                        <asp:DropDownList ID="ddlProfile" runat="server" CssClass="form-select">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvProfile" runat="server"
                            ControlToValidate="ddlProfile"
                            InitialValue=""
                            ErrorMessage="Please select a Profile"
                            ForeColor="#ef4444"
                            Display="Dynamic"
                            CssClass="small mt-1" />
                    </div>

                    <!-- Mobile -->
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">
                            <i class="fa fa-phone me-1 text-success"></i>Mobile Number
                            <span class="text-danger">*</span>
                        </label>
                        <asp:TextBox ID="txtMobile" runat="server" MaxLength="10" CssClass="form-control"
                            placeholder="Enter 10-digit Mobile Number"
                            oninput="this.value=this.value.replace(/[^0-9]/g,'');"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvMobile" runat="server"
                            ControlToValidate="txtMobile"
                            ErrorMessage="Mobile Number is required"
                            ForeColor="#ef4444"
                            Display="Dynamic"
                            CssClass="small mt-1" />
                        <asp:RegularExpressionValidator ID="revMobile" runat="server"
                            ControlToValidate="txtMobile"
                            ValidationExpression="^\d{10}$"
                            ErrorMessage="Mobile Number must be 10 digits"
                            ForeColor="#ef4444"
                            Display="Dynamic"
                            CssClass="small mt-1" />
                    </div>

                    <!-- Email -->
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">
                            <i class="fa fa-envelope me-1 text-danger"></i>Email
                            <span class="text-danger">*</span>
                        </label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"
                            AutoPostBack="true" OnTextChanged="txtEmail_TextChanged"
                            placeholder="Enter Email Address"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                            ControlToValidate="txtEmail"
                            ErrorMessage="Email is required"
                            ForeColor="#ef4444"
                            Display="Dynamic"
                            CssClass="small mt-1" />
                        <asp:RegularExpressionValidator ID="revEmail" runat="server"
                            ControlToValidate="txtEmail"
                            ValidationExpression="^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$"
                            ErrorMessage="Invalid Email format"
                            ForeColor="#ef4444"
                            Display="Dynamic"
                            CssClass="small mt-1" />
                    </div>

                    <!-- Buttons -->
                    <div class="col-12 mt-4 pt-3 border-top">
                        <div class="d-flex gap-2 justify-content-center">
                            <asp:Button ID="btnSave" Text="Save User" runat="server"
                                OnClick="btnSave_Click"
                                CssClass="btn btn-gradient-success px-4 fw-semibold" />

                            <asp:Button ID="btnClear" Text="Clear Form" runat="server"
                                OnClick="btnClear_Click"
                                CausesValidation="false"
                                CssClass="btn btn-gradient-danger px-4 fw-semibold" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
