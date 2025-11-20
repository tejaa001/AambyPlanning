using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace AambyPlanning
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadStatistics();
            }
        }

        private void LoadStatistics()
        {
            try
            {
                // Load statistics from database
                LoadCustomerCount();
                LoadPlotCount();
                LoadPlanCount();
                LoadTransactionCount();
            }
            catch (Exception ex)
            {
                // Log error (you can implement logging as needed)
                // For now, set default values
                lblTotalCustomers.Text = "0";
                lblTotalPlots.Text = "0";
                lblTotalPlans.Text = "0";
                lblTotalTransactions.Text = "0";
            }
        }

        private void LoadCustomerCount()
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["AambyPlanningConnectionString"]?.ConnectionString;
                
                if (string.IsNullOrEmpty(connectionString))
                {
                    lblTotalCustomers.Text = "0";
                    return;
                }

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = "SELECT COUNT(*) FROM CustomerMaster WHERE IsActive = 1";
                    SqlCommand cmd = new SqlCommand(query, con);
                    con.Open();
                    int count = (int)cmd.ExecuteScalar();
                    lblTotalCustomers.Text = count.ToString();
                }
            }
            catch
            {
                lblTotalCustomers.Text = "0";
            }
        }

        private void LoadPlotCount()
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["AambyPlanningConnectionString"]?.ConnectionString;
                
                if (string.IsNullOrEmpty(connectionString))
                {
                    lblTotalPlots.Text = "0";
                    return;
                }

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = "SELECT COUNT(*) FROM PlotMaster WHERE IsActive = 1";
                    SqlCommand cmd = new SqlCommand(query, con);
                    con.Open();
                    int count = (int)cmd.ExecuteScalar();
                    lblTotalPlots.Text = count.ToString();
                }
            }
            catch
            {
                lblTotalPlots.Text = "0";
            }
        }

        private void LoadPlanCount()
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["AambyPlanningConnectionString"]?.ConnectionString;
                
                if (string.IsNullOrEmpty(connectionString))
                {
                    lblTotalPlans.Text = "0";
                    return;
                }

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = "SELECT COUNT(*) FROM PlanMaster WHERE IsActive = 1";
                    SqlCommand cmd = new SqlCommand(query, con);
                    con.Open();
                    int count = (int)cmd.ExecuteScalar();
                    lblTotalPlans.Text = count.ToString();
                }
            }
            catch
            {
                lblTotalPlans.Text = "0";
            }
        }

        private void LoadTransactionCount()
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["AambyPlanningConnectionString"]?.ConnectionString;
                
                if (string.IsNullOrEmpty(connectionString))
                {
                    lblTotalTransactions.Text = "0";
                    return;
                }

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    // Adjust this query based on your actual transaction table name
                    string query = "SELECT COUNT(*) FROM Transactions";
                    SqlCommand cmd = new SqlCommand(query, con);
                    con.Open();
                    int count = (int)cmd.ExecuteScalar();
                    lblTotalTransactions.Text = count.ToString();
                }
            }
            catch
            {
                lblTotalTransactions.Text = "0";
            }
        }
    }
}