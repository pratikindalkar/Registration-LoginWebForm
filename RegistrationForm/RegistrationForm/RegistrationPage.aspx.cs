using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RegistrationForm
{
    public partial class RegistrationPage : System.Web.UI.Page
    {
        string ExistingPath = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                InitializePage();
            }
        }

        private void InitializePage()
        {
            if (Session["UserID"] != null && Session["UserName"] != null)
            {
                lblWelcome.Text = "Welcome, " + Session["UserName"].ToString() + "!";
                lblWelcome.Visible = true;
                btnUpdate.Visible = false;
                btnClear.Visible = false;
                GridView1.Visible = true;
                btnLogIn.Visible = false;
            }
            else
            {
                lblWelcome.Visible = false;
                GridView1.Visible = false;
                btnUpdate.Visible = false;
                btnClear.Visible = false;
                btnLogout.Visible = false;
                btnLogIn.Visible = true;
            }
            GetAllData();
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                if (txtPass.Text.Trim().Contains(txtUname.Text.Trim()))
                {
                    lblResult.Text = "Password cannot contain the username.";
                    lblResult.Visible = true;
                    return;
                }

                List<string> imagePaths = new List<string>();

                if (fileUploadImage.HasFiles)
                {
                    foreach (HttpPostedFile uploadedFile in fileUploadImage.PostedFiles)
                    {
                        string fileExtension = Path.GetExtension(uploadedFile.FileName).ToLower();

                        if (fileExtension != ".jpg" && fileExtension != ".jpeg" && fileExtension != ".png" && fileExtension != ".gif")
                        {
                            lblResult.Text = "Invalid file type. Only .jpg, .jpeg, .png, and .gif are allowed.";
                            lblResult.Visible = true;
                            return;
                        }

                        if (uploadedFile.ContentLength > 2 * 1024 * 1024)
                        {
                            lblResult.Text = "File size exceeds the 2 MB limit.";
                            lblResult.Visible = true;
                            return;
                        }
                        string fileName = Path.GetFileName(uploadedFile.FileName);
                        string imagePath = "~/Images/" + fileName;
                        uploadedFile.SaveAs(Server.MapPath(imagePath));
                        imagePaths.Add(imagePath);
                    }
                }
                string imagePathsString = string.Join(",", imagePaths);

                List<string> selectedSkills = CheckBoxList1.Items.Cast<ListItem>()
                                          .Where(li => li.Selected)
                                          .Select(li => li.Text)
                                          .ToList();
                string selectedSkillsString = string.Join(",", selectedSkills);

                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["RegistrationConnectionString"].ConnectionString))
                {
                    con.Open();
                    using (SqlCommand cmd = new SqlCommand("InsertRegistrationDetails", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@FirstName", txtFirstName.Text.Trim());
                        cmd.Parameters.AddWithValue("@LastName", txtLastName.Text.Trim());
                        cmd.Parameters.AddWithValue("@UserName", txtUname.Text.Trim());
                        cmd.Parameters.AddWithValue("@Password", txtPass.Text.Trim());
                        cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                        cmd.Parameters.AddWithValue("@Mobile", txtMob.Text.Trim());
                        cmd.Parameters.AddWithValue("@Gender", rbtnM.Checked ? "M" : (rbtnF.Checked ? "F" : ""));
                        cmd.Parameters.AddWithValue("@Age", int.TryParse(txtAge.Text.Trim(), out int age) ? (object)age : DBNull.Value);
                        cmd.Parameters.AddWithValue("@Course", DropDownList1.SelectedItem.Text);
                        cmd.Parameters.AddWithValue("@Hobbies", (chk1.Checked ? chk1.Text + " " : "") + (chk2.Checked ? chk2.Text + " " : "") + (chk3.Checked ? chk3.Text + " " : "").Trim());
                        cmd.Parameters.AddWithValue("@Address", txtAddress.Text.Trim());
                        cmd.Parameters.AddWithValue("@ImagePaths", imagePathsString);
                        cmd.Parameters.AddWithValue("@Skills", selectedSkillsString);
                        cmd.Parameters.AddWithValue("@CreateDT", DateTime.Now);
                        if (Session["UserName"] != null)
                        {
                            cmd.Parameters.AddWithValue("@Unname", Session["UserName"].ToString());
                        }
                        SqlParameter returnValue = new SqlParameter
                        {
                            ParameterName = "@ReturnValue",
                            SqlDbType = SqlDbType.Int,
                            Direction = ParameterDirection.ReturnValue
                        };
                        cmd.Parameters.Add(returnValue);
                        cmd.ExecuteNonQuery();

                        int result = (int)returnValue.Value;
                        if (result == 1)
                        {
                            Response.Write("<script>alert('User registered successfully!')</script>");
                        }
                        else if (result == 2)
                        {
                            Response.Write("<script>alert('Duplicate Email found. Please use a different email address.')</script>");
                        }
                        else if (result == 3)
                        {
                            Response.Write("<script>alert('Duplicate Mobile number found. Please use a different mobile number.')</script>");
                        }
                        else if (result == 4)
                        {
                            Response.Write("<script>alert('Duplicate User name found. Please use a different User name.')</script>");
                        }
                        else
                        {
                            Response.Write("<script>alert('Something went wrong, try again.')</script>");
                        }

                        lblResult.Visible = true;

                        ClearForm();
                        GetAllData();
                    }
                }
            }
            catch (Exception ex)
            {
                lblResult.Text = "Error: " + ex.Message;
                lblResult.Visible = true;
            }
        }


        protected void onRowCommand1(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                int userId = Convert.ToInt32(e.CommandArgument);
                LoadUserData(userId);
            }
            else if (e.CommandName == "Delete")
            {
                int userId = Convert.ToInt32(e.CommandArgument);
                DeleteUser(userId);
            }
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            int userId = Convert.ToInt32(GridView1.DataKeys[e.NewEditIndex].Value);
            LoadUserData(userId);
        }

        protected void OnRowDeleting1(object sender, GridViewDeleteEventArgs e)
        {
            
        }

        private void GetAllData()
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["RegistrationConnectionString"].ConnectionString))
            {
                SqlDataAdapter da = new SqlDataAdapter("GetAllData", con);
                da.SelectCommand.CommandType = CommandType.StoredProcedure;
                DataTable dt = new DataTable();
                da.Fill(dt);
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
        }

        private void LoadUserData(int userID)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["RegistrationConnectionString"].ConnectionString))
            {
                SqlDataAdapter da = new SqlDataAdapter("GetUserData", con);
                da.SelectCommand.CommandType = CommandType.StoredProcedure;
                da.SelectCommand.Parameters.AddWithValue("@UserID", userID);

                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    DataRow row = dt.Rows[0];
                    txtFirstName.Text = row["FirstName"].ToString();
                    txtLastName.Text = row["LastName"].ToString();
                    txtUname.Text = row["UserName"].ToString();
                    txtEmail.Text = row["Email"].ToString();
                    txtMob.Text = row["Mobile"].ToString();
                    txtAge.Text = row["Age"].ToString();
                    txtAddress.Text = row["Address"].ToString();
                    DropDownList1.SelectedValue = row["Course"].ToString();

                    if (row["Gender"].ToString() == "M")
                    {
                        rbtnM.Checked = true;
                    }
                    else if (row["Gender"].ToString() == "F")
                    {
                        rbtnF.Checked = true;
                    }

                    string[] hobbies = row["Hobbies"].ToString().Split(' ');
                    chk1.Checked = hobbies.Contains(chk1.Text);
                    chk2.Checked = hobbies.Contains(chk2.Text);
                    chk3.Checked = hobbies.Contains(chk3.Text);

                    string[] skills = row["Skills"].ToString().Split(',');
                    foreach (ListItem item in CheckBoxList1.Items)
                    {
                        item.Selected = skills.Contains(item.Text);
                    }

                    ViewState["UserID"] = userID;
                    btnUpdate.Visible = true;
                    btnCancel.Visible = true;
                    btnSubmit.Visible = false;
                }
            }
        }

        private void DeleteUser(int userId)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["RegistrationConnectionString"].ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("DeleteUser", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@UserID", userId);
                        cmd.Parameters.AddWithValue("@Unname", Session["UserName"].ToString());
                        con.Open();
                        int result = cmd.ExecuteNonQuery();
                        if (result > 0)
                        {
                            Response.Write("<script>alert('User deleted successfully!')</script>");
                            ClearForm();
                            GetAllData();
                        }
                        else
                        {
                            Response.Write("<script>alert('Deletion failed. Please try again.')</script>");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "')</script>");
            }
        }

        protected void btnUpdate_Click1(object sender, EventArgs e)
        {
            try
            {
                if (ViewState["UserID"] == null || Session["UserID"] == null || Session["UserName"] == null)
                {
                    Response.Write("<script>alert('UserID or UserName is not set.')</script>");
                    return;
                }

                int userId = Convert.ToInt32(ViewState["UserID"]);
                int modifyUID = Convert.ToInt32(Session["UserID"]);

                // Retrieve existing image paths
                string existingImagePaths = GetExistingImagePaths(userId);
                List<string> imagePaths = new List<string>();

                if (fileUploadImage.HasFiles)
                {
                    foreach (HttpPostedFile uploadedFile in fileUploadImage.PostedFiles)
                    {
                        string fileExtension = Path.GetExtension(uploadedFile.FileName).ToLower();

                        if (fileExtension != ".jpg" && fileExtension != ".jpeg" && fileExtension != ".png" && fileExtension != ".gif")
                        {
                            lblResult.Text = "Invalid file type. Only .jpg, .jpeg, .png, and .gif are allowed.";
                            lblResult.Visible = true;
                            return;
                        }

                        if (uploadedFile.ContentLength > 2 * 1024 * 1024)
                        {
                            lblResult.Text = "File size exceeds the 2 MB limit.";
                            lblResult.Visible = true;
                            return;
                        }
                        string fileName = Path.GetFileName(uploadedFile.FileName);
                        string imagePath = "~/Images/" + fileName;
                        uploadedFile.SaveAs(Server.MapPath(imagePath));
                        imagePaths.Add(imagePath);
                    }
                }

                string imagePathsString = string.Join(",", imagePaths);
                string finalImagePaths = string.IsNullOrEmpty(imagePathsString) ? existingImagePaths : imagePathsString;

                List<string> selectedSkills = CheckBoxList1.Items.Cast<ListItem>()
                                                                  .Where(li => li.Selected)
                                                                  .Select(li => li.Text)
                                                                  .ToList();
                string selectedSkillsString = string.Join(",", selectedSkills);

                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["RegistrationConnectionString"].ConnectionString))
                {
                    con.Open();
                    using (SqlCommand cmd = new SqlCommand("UpdateUser", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.AddWithValue("@UserID", userId);
                        cmd.Parameters.AddWithValue("@FirstName", txtFirstName.Text.Trim());
                        cmd.Parameters.AddWithValue("@LastName", txtLastName.Text.Trim());
                        cmd.Parameters.AddWithValue("@UserName", txtUname.Text.Trim());
                        cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                        cmd.Parameters.AddWithValue("@Mobile", txtMob.Text.Trim());

                        string gender = rbtnM.Checked ? "M" : (rbtnF.Checked ? "F" : "");
                        cmd.Parameters.AddWithValue("@Gender", gender);

                        cmd.Parameters.AddWithValue("@Age", int.TryParse(txtAge.Text.Trim(), out int age) ? (object)age : DBNull.Value);
                        cmd.Parameters.AddWithValue("@Course", DropDownList1.SelectedItem.Text);

                        string hobbies = (chk1.Checked ? chk1.Text + " " : "") +
                                         (chk2.Checked ? chk2.Text + " " : "") +
                                         (chk3.Checked ? chk3.Text + " " : "");
                        cmd.Parameters.AddWithValue("@Hobbies", hobbies.Trim());

                        cmd.Parameters.AddWithValue("@Address", txtAddress.Text.Trim());

                        cmd.Parameters.AddWithValue("@ImagePaths", string.IsNullOrEmpty(finalImagePaths) ? (object)DBNull.Value : finalImagePaths);
                        cmd.Parameters.AddWithValue("@Skills", selectedSkillsString);
                        cmd.Parameters.AddWithValue("@Unname", Session["UserName"].ToString());
                        cmd.Parameters.AddWithValue("@ModifyUID", modifyUID);
                        cmd.Parameters.AddWithValue("@ModifyDT", DateTime.Now);

                        SqlParameter returnValue = new SqlParameter
                        {
                            ParameterName = "@ReturnValue",
                            SqlDbType = SqlDbType.Int,
                            Direction = ParameterDirection.ReturnValue
                        };
                        cmd.Parameters.Add(returnValue);

                        cmd.ExecuteNonQuery();

                        int result = (int)returnValue.Value;
                        if (result == 1)
                        {
                            Response.Write("<script>alert('User updated successfully!')</script>");
                            ClearForm();
                            btnSubmit.Visible = true;
                            btnCancel.Visible = true;
                            btnUpdate.Visible = false;
                            btnClear.Visible = false;
                        }
                        else if (result == 2)
                        {
                            Response.Write("<script>alert('Duplicate Email found. Please use a different email address.')</script>");
                        }
                        else if (result == 3)
                        {
                            Response.Write("<script>alert('Duplicate Mobile number found. Please use a different mobile number.')</script>");
                        }
                        else if (result == 4)
                        {
                            Response.Write("<script>alert('Duplicate User name found. Please use a different User name.')</script>");
                        }
                        else
                        {
                            Response.Write("<script>alert('Something went wrong, try again.')</script>");
                        }

                        lblResult.Visible = true;

                        ClearForm();
                        GetAllData();
                    }
                }
            }
            catch (Exception ex)
            {
                lblResult.Text = "Error: " + ex.Message;
                lblResult.Visible = true;
            }
        }

        private string GetExistingImagePaths(int userID)
        {
            string existingImagePaths = string.Empty;
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["RegistrationConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("GetExistingImagePaths", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@UserID", userID);
                    con.Open();
                    existingImagePaths = cmd.ExecuteScalar()?.ToString() ?? string.Empty;
                }
            }
            return existingImagePaths;
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

            foreach (ListItem item in CheckBoxList1.Items)
            {
                item.Selected = false;
            }

            ResetDropdown(DropDownList1);
        }

        private void ResetDropdown(DropDownList ddl)
        {
            if (ddl.Items.Count > 0)
            {
                ddl.SelectedIndex = 0;
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            FormsAuthentication.SignOut();
            Response.Redirect("LoginPage.aspx");
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ClearForm();
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ClearForm();
        }

        protected string BindImages(object dataItem)
        {
            DataRowView rowView = (DataRowView)dataItem;
            string imagePathsString = rowView["ImagePath"].ToString();
            string[] imagePaths = imagePathsString.Split(',');

            StringBuilder html = new StringBuilder();

            foreach (string path in imagePaths)
            {
                if (!string.IsNullOrWhiteSpace(path))
                {
                    string resolvedUrl = ResolveUrl(path);
                    html.Append($"<img src='{resolvedUrl}' width='100px' height='100px' style='margin-right:5px;' alt='Profile Image' />");
                }
            }
            return html.ToString();
        }

        protected void btnLogIn_Click(object sender, EventArgs e)
        {
            Response.Redirect("LoginPage.aspx");
        }

        //protected void SubmitButton_Click1(object sender, EventArgs e)
        //{
        //    string selectedSkills = string.Empty;
        //    foreach (ListItem item in CheckBoxList1.Items)
        //    {
        //        if (item.Selected)
        //        {
        //            selectedSkills += item.Text + ", ";
        //        }
        //    }
        //    if (selectedSkills.Length > 0)
        //    {
        //        selectedSkills = selectedSkills.Substring(0, selectedSkills.Length - 2);
        //    }
        //    lblResult.Text = "Selected Skills: " + selectedSkills;
        //    lblResult.Visible = true;
        //}
    }
}
