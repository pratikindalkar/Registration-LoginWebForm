using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Security;
using System.Web.UI;

namespace RegistrationForm
{
    public partial class LoginPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            Response.Redirect("RegistrationPage.aspx");
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                string UMob = txtUMob.Text.Trim();
                string Pass = txtLPass.Text.Trim();

                string connectionString = ConfigurationManager.ConnectionStrings["RegistrationConnectionString"].ConnectionString;

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = "SELECT UserID, UserName, CreateUID, CreateDT FROM RegistrationDetails WHERE (Email = @UMob OR UserName = @UMob OR Mobile = @UMob) AND Password = @Pass";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@UMob", UMob);
                        cmd.Parameters.AddWithValue("@Pass", Pass);

                        con.Open();
                        SqlDataReader reader = cmd.ExecuteReader();

                        if (reader.Read())
                        {
                            Session["UserID"] = reader["UserID"];
                            Session["UserName"] = reader["UserName"];
                            Session["CreateUID"] = reader["CreateUID"];
                            Session["CreateDT"] = reader["CreateDT"];

                            FormsAuthentication.SetAuthCookie(UMob, false);
                            Response.Redirect("RegistrationPage.aspx");
                        }
                        else
                        {
                            lblError.Text = "Invalid username or password.";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "An error occurred: " + ex.Message;
            }
        }
    }
}
