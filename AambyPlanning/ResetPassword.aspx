<%@ Page Title="Reset Password" Language="C#"
MasterPageFile="~/AdminZone.Master" AutoEventWireup="true"
CodeBehind="ResetPassword.aspx.cs" Inherits="AambyPlanning.ResetPassword" %>

<asp:Content
  ID="Content1"
  ContentPlaceHolderID="ContentPlaceHolder1"
  runat="server"
>
  <style>
    /* Custom CSS - Only Essential Styles */
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
    <!-- Reset Password Card -->
    <div class="card shadow-sm border-0">
      <div class="card-header card-header-gradient text-white py-3">
        <h2 class="mb-0 d-flex align-items-center">
          <i class="fa fa-key me-2"></i>
          Reset User Password
        </h2>
      </div>
      <div class="card-body bg-light p-4">
        <!-- Status Label -->
        <asp:Label ID="lblMessage" runat="server" CssClass="d-none"></asp:Label>

        <div class="row g-3">
          <!-- User Selection -->
          <div class="col-md-8 mx-auto d-flex align-items-center flex-column">
            <label class="form-label fw-semibold">
              <i class="fa fa-user me-1 text-primary"></i>Select User
              <span class="text-danger">*</span>
            </label>
            <div class="row justify-content-center">
              <div class="col-md-8 col-sm-12">
                <asp:DropDownList
                  ID="ddlUser"
                  CssClass="form-select "
                  AutoPostBack="true"
                  runat="server"
                >
                  <asp:ListItem
                    Value="0"
                    Text="-- Select User --"
                    Selected="True"
                  ></asp:ListItem>
                </asp:DropDownList>
              </div>
            </div>
          </div>
        </div>

        <!-- Buttons -->
        <div class="col-12 mt-4 pt-3 border-top">
          <div class="d-flex gap-2 justify-content-center">
            <asp:Button
              ID="btnChangePassword"
              runat="server"
              CssClass="btn btn-gradient-success px-4 fw-semibold"
              Text="Reset Password"
              OnClick="btnChangePassword_Click"
            />

            <asp:Button
              ID="btnCancel"
              runat="server"
              CssClass="btn btn-gradient-danger px-4 fw-semibold"
              Text="Cancel"
              OnClick="btnCancel_Click"
            />
          </div>
        </div>
      </div>
    </div>
  </div>
</asp:Content>
