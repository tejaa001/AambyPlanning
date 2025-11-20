<%@ Page Title="User List" Language="C#" MasterPageFile="~/AdminZone.Master" AutoEventWireup="true" CodeBehind="UserList.aspx.cs" Inherits="AambyPlanning.UserList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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
    </style>

    <div class="container-fluid px-3 py-4">
        <!-- User Card -->
        <div class="card shadow-sm border-0 mb-4">
            <div class="card-header card-header-gradient text-white py-3">
                <h2 class="mb-0 d-flex align-items-center">
                    <i class="fa fa-users me-2"></i>
                    User List
                </h2>
            </div>
            <div class="card-body bg-light p-4">
                <!-- Status Label -->
                <asp:Label ID="lblStatus" runat="server" CssClass="d-none"></asp:Label>

                <!-- Edit Form (Hidden by default) -->
                <div class="row g-3" id="dform" runat="server" visible="false">
                    <!-- User Name -->
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">
                            <i class="fa fa-user me-1 text-primary"></i>User Name
                            <span class="text-danger">*</span>
                        </label>
                        <asp:TextBox ID="txtUserName" runat="server" CssClass="form-control" ReadOnly="true"
                            placeholder="Auto-filled Username"></asp:TextBox>
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
                    </div>

                    <!-- Employee Name -->
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">
                            <i class="fa fa-user-tie me-1 text-success"></i>Employee Name
                            <span class="text-danger">*</span>
                        </label>
                        <asp:TextBox ID="txtEmpName" runat="server" CssClass="form-control"
                            placeholder="Enter Employee Name"></asp:TextBox>
                    </div>

                    <!-- Profile -->
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">
                            <i class="fa fa-briefcase me-1 text-warning"></i>Profile
                            <span class="text-danger">*</span>
                        </label>
                        <asp:DropDownList ID="ddlProfile" runat="server" CssClass="form-select">
                        </asp:DropDownList>
                    </div>

                    <!-- Mobile -->
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">
                            <i class="fa fa-phone me-1 text-success"></i>Mobile Number
                            <span class="text-danger">*</span>
                        </label>
                        <asp:TextBox ID="txtMobile" runat="server" MaxLength="10" CssClass="form-control"
                            placeholder="Enter 10-digit number"
                            oninput="this.value=this.value.replace(/[^0-9]/g,'');"></asp:TextBox>
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
                    </div>

                    <!-- Buttons -->
                    <div class="col-12 mt-4 pt-3 border-top">
                        <div class="d-flex gap-2 justify-content-center">
                            <asp:Button ID="btnEdit" Text="Update" runat="server"
                                OnClick="btnEdit_Click"
                                CssClass="btn btn-gradient-success px-4 fw-semibold" />

                            <asp:Button ID="btnBack" Text="Back" runat="server"
                                OnClick="btnBack_Click"
                                CssClass="btn btn-gradient-danger px-4 fw-semibold" />
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- GridView Container -->
        <div class="card shadow-sm border-0" id="dGrid" runat="server">
            <div class="card-body p-3">
                <div class="table-responsive">
                    <asp:GridView ID="gvUsers" runat="server" DataKeyNames="UserId" AutoGenerateColumns="False" 
                        CssClass="table table-hover table-bordered align-middle mb-0" OnRowCommand="gvUsers_RowCommand">
                        <HeaderStyle CssClass="table-primary text-center fw-semibold" />
                        <RowStyle CssClass="text-center" />
                        <Columns>
                            <asp:BoundField DataField="UserID" HeaderText="User ID" ReadOnly="True" />
                            <asp:BoundField DataField="Username" HeaderText="Username" />
                            <asp:BoundField DataField="EmployeeName" HeaderText="Employee Name" />
                            <asp:BoundField DataField="EmployeeId" HeaderText="Employee Id" />
                            <asp:BoundField DataField="Profile" HeaderText="Profile" />
                            <asp:BoundField DataField="MobileNumber" HeaderText="Mobile Number" />
                            <asp:BoundField DataField="Email" HeaderText="Email" />
                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <asp:Button
                                        ID="btnActive"
                                        runat="server"
                                        Text='<%# (Convert.ToInt32(Eval("IsActive")) == 1) ? "Active" : "Inactive" %>'
                                        CommandArgument='<%# Eval("UserId") %>'
                                        CommandName="ToggleActive"
                                        CssClass='<%# (Convert.ToInt32(Eval("IsActive")) == 1) ? "btn btn-sm btn-success" : "btn btn-sm btn-danger" %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <asp:Button
                                        ID="btnEditRow"
                                        runat="server"
                                        Text="Edit"
                                        CommandArgument="<%# Container.DataItemIndex %>"
                                        CommandName="EditRow"
                                        CssClass="btn btn-sm btn-gradient-primary" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
