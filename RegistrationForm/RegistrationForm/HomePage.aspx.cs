using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.IO;

namespace RegistrationForm
{
    public partial class HomePage : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["RegistrationConnectionString"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            btnUpdate.Visible= false;
            btnCancel.Visible= false;
        }

        //protected void btnSubmit_Click(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        if (txtPass.Text.Trim().Contains(txtUname.Text.Trim()))
        //        {
        //            lblResult.Text = "Password cannot contain the username.";
        //            lblResult.Visible = true;
        //            return;
        //        }

        //        string imagePath = string.Empty;
        //        if (fileUploadImage.HasFile)
        //        {
        //            string[] allowedExtensions = { ".jpg", ".jpeg", ".png", ".gif" };
        //            string fileExtension = Path.GetExtension(fileUploadImage.PostedFile.FileName).ToLower();

        //            if (!allowedExtensions.Contains(fileExtension))
        //            {
        //                lblResult.Text = "Invalid file type. Only .jpg, .jpeg, .png, and .gif are allowed.";
        //                lblResult.Visible = true;
        //                return;
        //            }

        //            if (fileUploadImage.PostedFile.ContentLength > 2 * 1024 * 1024)
        //            {
        //                lblResult.Text = "File size exceeds the 2 MB limit.";
        //                lblResult.Visible = true;
        //                return;
        //            }

        //            string fileName = Path.GetFileName(fileUploadImage.PostedFile.FileName);
        //            imagePath = "~/Images/" + fileName;
        //            fileUploadImage.SaveAs(Server.MapPath(imagePath));
        //        }

        //        int createUID;
        //        if (Session["UserID"] != null)
        //        {
        //            createUID = Convert.ToInt32(Session["UserID"]);
        //        }
        //        else
        //        {
        //            createUID = 1;
        //        }

        //        DateTime createDT = DateTime.Now;

        //        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["RegistrationConnectionString"].ConnectionString))
        //        {
        //            con.Open();
        //            using (SqlCommand cmd = new SqlCommand("InsertRegistrationDetails", con))
        //            {
        //                cmd.CommandType = CommandType.StoredProcedure;
        //                cmd.Parameters.AddWithValue("@FirstName", txtFirstName.Text.Trim());
        //                cmd.Parameters.AddWithValue("@LastName", txtLastName.Text.Trim());
        //                cmd.Parameters.AddWithValue("@UserName", txtUname.Text.Trim());
        //                cmd.Parameters.AddWithValue("@Password", txtPass.Text.Trim());
        //                cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
        //                cmd.Parameters.AddWithValue("@Mobile", txtMob.Text.Trim());

        //                string gender = rbtnM.Checked ? "M" : (rbtnF.Checked ? "F" : "");
        //                cmd.Parameters.AddWithValue("@Gender", gender);

        //                cmd.Parameters.AddWithValue("@Age", int.TryParse(txtAge.Text.Trim(), out int age) ? (object)age : DBNull.Value);
        //                cmd.Parameters.AddWithValue("@Course", DropDownList1.SelectedItem.Text);

        //                string hobbies = (chk1.Checked ? chk1.Text + " " : "") +
        //                                 (chk2.Checked ? chk2.Text + " " : "") +
        //                                 (chk3.Checked ? chk3.Text + " " : "");
        //                cmd.Parameters.AddWithValue("@Hobbies", hobbies.Trim());

        //                cmd.Parameters.AddWithValue("@Address", txtAddress.Text.Trim());
        //                cmd.Parameters.AddWithValue("@Image", imagePath);

        //                if (Session["UserName"] != null)
        //                {
        //                    cmd.Parameters.AddWithValue("@Unname", Session["UserName"].ToString());
        //                }

        //                //cmd.Parameters.AddWithValue("@CreateUID", createUID);
        //                cmd.Parameters.AddWithValue("@CreateDT", createDT);

        //                SqlParameter returnValue = new SqlParameter
        //                {
        //                    ParameterName = "@ReturnValue",
        //                    SqlDbType = SqlDbType.Int,
        //                    Direction = ParameterDirection.ReturnValue
        //                };
        //                cmd.Parameters.Add(returnValue);

        //                cmd.ExecuteNonQuery();

        //                int result = (int)returnValue.Value;

        //                if (result == 1)
        //                {
        //                    Response.Write("<script>alert('Data Registered successfully.')</script>");
        //                    ClearForm();
        //                    GetAllData();
        //                }
        //                else if (result == 2)
        //                {
        //                    Response.Write("<script>alert('Duplicate Email found. Please use a different email address.')</script>");
        //                }
        //                else if (result == 3)
        //                {
        //                    Response.Write("<script>alert('Duplicate Mobile number found. Please use a different mobile number.')</script>");
        //                }
        //                else if (result == 4)
        //                {
        //                    Response.Write("<script>alert('Duplicate User name found. Please use a different User name.')</script>");
        //                }
        //                else
        //                {
        //                    Response.Write("<script>alert('Something went wrong, try again.')</script>");
        //                }
        //            }
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        Response.Write("<script>alert('Error: " + ex.Message + "')</script>");
        //    }
        //}

        protected void checkConnection()
        {
            if (con.State == ConnectionState.Closed)
            {
                con.Open();
            }
        }

        private void ClearForm()
        {
            txtFirstName.Text = string.Empty;
            txtLastName.Text = string.Empty;
            txtUname.Text = string.Empty;
            txtPass.Text = string.Empty;
            txtEmail.Text = string.Empty;
            txtMob.Text = string.Empty;
            txtAge.Text = string.Empty;
            txtAddress.Text = string.Empty;

            rbtnM.Checked = false;
            rbtnF.Checked = false;

            chk1.Checked = false;
            chk2.Checked = false;
            chk3.Checked = false;

            if (DropDownList1.Items.Count > 0)
            {
                DropDownList1.SelectedIndex = 0;
            }
        }
    }
}