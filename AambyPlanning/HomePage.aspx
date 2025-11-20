<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/AambyPlanning.Master" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="AambyPlanning.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <style>
        .hero-section {
            background: linear-gradient(135deg, #1a2a6c, #2a4b8d, #3a6cb0);
            color: white;
            padding: 50px 0;
            margin: -20px -12px 30px -12px;
            border-radius: 0 0 20px 20px;
        }

        .feature-card {
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            padding: 20px;
            height: 100%;
            background: white;
        }

        .feature-card:hover {
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .feature-icon {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, #2a4b8d, #3a6cb0);
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 15px;
        }

        .stat-card {
            text-align: center;
            padding: 20px;
            background: white;
            border-radius: 8px;
            border: 1px solid #e0e0e0;
        }

        .stat-number {
            font-size: 1.8rem;
            font-weight: 600;
            color: #2a4b8d;
        }

        .quick-link-card {
            background: white;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            padding: 20px;
            text-align: center;
        }

        .quick-link-card:hover {
            border-color: #2a4b8d;
        }

        .quick-link-icon {
            font-size: 2rem;
            color: #2a4b8d;
            margin-bottom: 10px;
        }
    </style>

    <!-- Hero Section -->
    <div class="hero-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center">
                    <h1 class="h2 mb-3">Welcome to Aamby Planning</h1>
                    <p class="mb-4">
                        Streamline your business operations with our comprehensive planning and management system.
                    </p>
                    
                </div>
            </div>
        </div>
    </div>

    <!-- Features Section -->
    <div class="container my-5" id="features">
        <div class="text-center mb-4">
            <h2 class="h4 mb-2">Key Features</h2>
            <p class="text-muted">Everything you need to manage your planning business efficiently</p>
        </div>

        <div class="row g-3">
            <div class="col-md-6 col-lg-4">
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="bi bi-people-fill text-white"></i>
                    </div>
                    <h5 class="mb-2">Customer Management</h5>
                    <p class="text-muted small mb-0">
                        Efficiently manage customer information and maintain detailed records.
                    </p>
                </div>
            </div>

            <div class="col-md-6 col-lg-4">
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="bi bi-diagram-3-fill text-white"></i>
                    </div>
                    <h5 class="mb-2">Master Data Control</h5>
                    <p class="text-muted small mb-0">
                        Centralize all master data for seamless operations.
                    </p>
                </div>
            </div>

            <div class="col-md-6 col-lg-4">
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="bi bi-cash-coin text-white"></i>
                    </div>
                    <h5 class="mb-2">Transaction Processing</h5>
                    <p class="text-muted small mb-0">
                        Handle all financial transactions with accuracy.
                    </p>
                </div>
            </div>

            <div class="col-md-6 col-lg-4">
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="bi bi-bar-chart-line-fill text-white"></i>
                    </div>
                    <h5 class="mb-2">Comprehensive Reports</h5>
                    <p class="text-muted small mb-0">
                        Generate detailed reports to make informed decisions.
                    </p>
                </div>
            </div>

            <div class="col-md-6 col-lg-4">
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="bi bi-percent text-white"></i>
                    </div>
                    <h5 class="mb-2">GST Compliance</h5>
                    <p class="text-muted small mb-0">
                        Stay compliant with GST regulations.
                    </p>
                </div>
            </div>

            <div class="col-md-6 col-lg-4">
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="bi bi-shield-lock-fill text-white"></i>
                    </div>
                    <h5 class="mb-2">Secure & Reliable</h5>
                    <p class="text-muted small mb-0">
                        Your data is protected with enterprise-grade security.
                    </p>
                </div>
            </div>
        </div>
    </div>

    <!-- Statistics Section -->
    <div class="bg-light py-4 my-5">
        <div class="container">
            <div class="row g-3">
                <div class="col-md-3 col-sm-6">
                    <div class="stat-card">
                        <div class="stat-number">
                            <asp:Label ID="lblTotalCustomers" runat="server" Text="0"></asp:Label>
                        </div>
                        <div class="text-muted small">Active Customers</div>
                    </div>
                </div>

                <div class="col-md-3 col-sm-6">
                    <div class="stat-card">
                        <div class="stat-number">
                            <asp:Label ID="lblTotalPlots" runat="server" Text="0"></asp:Label>
                        </div>
                        <div class="text-muted small">Available Plots</div>
                    </div>
                </div>

                <div class="col-md-3 col-sm-6">
                    <div class="stat-card">
                        <div class="stat-number">
                            <asp:Label ID="lblTotalPlans" runat="server" Text="0"></asp:Label>
                        </div>
                        <div class="text-muted small">Active Plans</div>
                    </div>
                </div>

                <div class="col-md-3 col-sm-6">
                    <div class="stat-card">
                        <div class="stat-number">
                            <asp:Label ID="lblTotalTransactions" runat="server" Text="0"></asp:Label>
                        </div>
                        <div class="text-muted small">Transactions</div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Quick Links Section -->
    <div class="container my-5">
        <div class="text-center mb-4">
            <h2 class="h4 mb-2">Quick Access</h2>
            <p class="text-muted">Jump directly to the most frequently used sections</p>
        </div>

        <div class="row g-3">
            <div class="col-md-3 col-sm-6">
                <a href="PlanMaster.aspx" class="text-decoration-none">
                    <div class="quick-link-card">
                        <i class="bi bi-clipboard-data quick-link-icon"></i>
                        <div class="text-dark">Plan Master</div>
                    </div>
                </a>
            </div>

            <div class="col-md-3 col-sm-6">
                <a href="YearMaster.aspx" class="text-decoration-none">
                    <div class="quick-link-card">
                        <i class="bi bi-calendar-range quick-link-icon"></i>
                        <div class="text-dark">EMI Master</div>
                    </div>
                </a>
            </div>

            <div class="col-md-3 col-sm-6">
                <a href="PlotMaster.aspx" class="text-decoration-none">
                    <div class="quick-link-card">
                        <i class="bi bi-map quick-link-icon"></i>
                        <div class="text-dark">Plot Master</div>
                    </div>
                </a>
            </div>

            <div class="col-md-3 col-sm-6">
                <a href="CustomerMaster.aspx" class="text-decoration-none">
                    <div class="quick-link-card">
                        <i class="bi bi-person-badge quick-link-icon"></i>
                        <div class="text-dark">Customer Master</div>
                    </div>
                </a>
            </div>
        </div>
    </div>

    

</asp:Content>
