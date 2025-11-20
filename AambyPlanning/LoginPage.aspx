<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginPage.aspx.cs" Inherits="AambyPlanning.LoginPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
  <head runat="server">
    <meta charset="utf-8" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"
    />
    <title>Login | Aamby Planning - Secure Access</title>
    <meta name="description" content="Secure login portal for Aamby Planning application" />
    
    <style type="text/css">
      * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
      }

      body {
        font-family: Arial, sans-serif;
        background-color: #f0f0f0;
        display: flex;
        align-items: center;
        justify-content: center;
        min-height: 100vh;
        padding: 20px;
      }

      .login-wrapper {
        width: 100%;
        max-width: 400px;
      }

      .login-container {
        width: 100%;
      }

      .login-card {
        background: white;
        border: 1px solid #ddd;
        border-radius: 8px;
      }

      .login-header {
        background:linear-gradient(135deg, #1a2a6c, #2a4b8d, #3a6cb0) !important;
        color: white;
        padding: 30px 20px;
        text-align: center;
        border-radius: 8px 8px 0 0;
      }

      .brand-logo {
        margin-bottom: 15px;
      }

      .logo-icon {
        display: inline-block;
        /*background-color:  rgb(0 0 0 / 39%);*/
        padding: 10px;
        border-radius: 8px;
      }

      .logo-icon img {
        display: block;
        max-width: 170px;
        height: auto;
      }

      .login-header h2 {
        font-size: 24px;
        margin-bottom: 5px;
      }

      .login-header p {
        font-size: 14px;
        margin: 0;
      }

      .login-body {
        padding: 30px 20px;
      }

      .form-group {
        margin-bottom: 20px;
      }

      .form-label {
        display: block;
        margin-bottom: 8px;
        font-weight: bold;
        font-size: 14px;
        color: #333;
      }

      .input-group {
        display: flex;
      }

      .input-group-text {
        background-color: #f5f5f5;
        border: 1px solid #ccc;
        border-right: none;
        padding: 10px 12px;
        border-radius: 4px 0 0 4px;
      }

      .input-group-text svg {
        width: 16px;
        height: 16px;
        color: #666;
      }

      .form-control {
        flex: 1;
        padding: 10px 12px;
        border: 1px solid #ccc;
        border-left: none;
        border-radius: 0 4px 4px 0;
        font-size: 14px;
      }

      .form-control:focus {
        outline: none;
        border-color: #4a5568;
      }

      .input-group:focus-within .input-group-text {
        border-color: #4a5568;
      }

      .btn-login {
        width: 100%;
        padding: 12px;
         background:linear-gradient(135deg, #1a2a6c, #2a4b8d, #3a6cb0) !important;
        color: white;
        border: none;
        border-radius: 4px;
        font-size: 16px;
        cursor: pointer;
        margin-top: 10px;
      }

      .btn-login:hover {
        background-color: #2d3748;
      }

      .message {
        margin-top: 20px;
        padding: 12px;
        border-radius: 4px;
        text-align: center;
        font-size: 14px;
      }

      .message.success {
        background-color: #d4edda;
        color: #155724;
        border: 1px solid #c3e6cb;
      }

      .message.error {
        background-color: #f8d7da;
        color: #721c24;
        border: 1px solid #f5c6cb;
      }

      .login-footer {
        padding: 15px 20px;
         background:linear-gradient(135deg, #1a2a6c, #2a4b8d, #3a6cb0) !important;
        border-top: 1px solid #ddd;
        color:white;
        text-align: center;
        border-radius: 0 0 8px 8px;
      }

      .login-footer p {
        margin: 0;
        font-size: 12px;

      }

      @media (max-width: 480px) {
        .login-body {
          padding: 20px 15px;
        }

        .login-header {
          padding: 25px 15px;
        }

        .logo-icon img {
          max-width: 120px;
        }
      }
    </style>
  </head>
  <body>
    <div class="login-wrapper">
      <form id="form1" runat="server" class="login-container">
        <div class="card login-card">
          <div class="card-header login-header">
            <div class="brand-logo">
              <div class="logo-icon">
                <img src="assets/AambyPlanningLogo.png" alt="Aamby Planning Logo" />
              </div>
            </div>
            <h2 class="mb-0">Welcome Back</h2>
            <p class="mb-0 mt-2">Sign in to access your account</p>
          </div>

          <div class="card-body login-body">
            <div class="form-group">
              <asp:Label
                ID="Label1"
                runat="server"
                Text="Username"
                AssociatedControlID="txtUsername"
                CssClass="form-label"
              ></asp:Label>
              <div class="input-group">
                <span class="input-group-text">
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    width="18"
                    height="18"
                    fill="currentColor"
                    viewBox="0 0 16 16"
                  >
                    <path
                      d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0zm4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10z"
                    />
                  </svg>
                </span>
                <asp:TextBox
                  ID="txtUsername"
                  runat="server"
                  CssClass="form-control"
                  placeholder="Enter your username"
                  autocomplete="username"
                ></asp:TextBox>
              </div>
            </div>

            <div class="form-group">
              <asp:Label
                ID="Label2"
                runat="server"
                Text="Password"
                AssociatedControlID="txtPassword"
                CssClass="form-label"
              ></asp:Label>
              <div class="input-group">
                <span class="input-group-text">
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    width="18"
                    height="18"
                    fill="currentColor"
                    viewBox="0 0 16 16"
                  >
                    <path
                      d="M8 1a2 2 0 0 1 2 2v4H6V3a2 2 0 0 1 2-2zm3 6V3a3 3 0 0 0-6 0v4a2 2 0 0 0-2 2v5a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2zM5 8h6a1 1 0 0 1 1 1v5a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1V9a1 1 0 0 1 1-1z"
                    />
                  </svg>
                </span>
                <asp:TextBox
                  ID="txtPassword"
                  runat="server"
                  TextMode="Password"
                  CssClass="form-control"
                  placeholder="Enter your password"
                  autocomplete="current-password"
                ></asp:TextBox>
              </div>
            </div>

            <div class="d-grid">
              <asp:Button
                ID="btnLogin"
                runat="server"
                Text="Sign In"
                OnClick="btnLogin_Click"
                CssClass="btn btn-login"
              />
            </div>

            <div class="message">
              <asp:Label ID="lblMessage" runat="server"></asp:Label>
            </div>
          </div>

          <div class="login-footer">
            <p>&copy; 2025 Aamby Planning. All rights reserved.</p>
          </div>
        </div>
      </form>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  </body>
</html>
