<%@ Page Language="C#" AutoEventWireup="true" UnobtrusiveValidationMode="None" CodeBehind="RegistrationPage.aspx.cs" Inherits="RegistrationForm.RegistrationPage" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Registration Form</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        .form-control {
            margin-bottom: 15px;
        }
        .multiselect-checkbox {
            padding: 10px;
            border: 1px solid #ddd;
            background-color: #f9f9f9;
        }
        .input-multiselect {
            cursor: pointer;
        }
        .custom-checkbox input[type="checkbox"] {
            margin-right: 10px;
        }
    </style>
    <script type="text/javascript">
        function showDropdown() {
            var panel = document.getElementById('<%= PanelCountry.ClientID %>');
            panel.style.display = 'block';
        }

        function hideDropdown() {
            var panel = document.getElementById('<%= PanelCountry.ClientID %>');
            panel.style.display = 'none';
        }

        function selectCountry(value) {
            var textbox = document.getElementById('<%= txtCountry.ClientID %>');
            textbox.value = value;
            hideDropdown();
        }

        function allowOnlyLetters(event) {
            var charCode = event.which ? event.which : event.keyCode;
            return (charCode >= 65 && charCode <= 90) || (charCode >= 97 && charCode <= 122) || [8, 9, 27, 13].indexOf(charCode) !== -1;
        }

        function ValidateGender(sender, args) {
            args.IsValid = document.getElementById('<%= rbtnM.ClientID %>').checked || document.getElementById('<%= rbtnF.ClientID %>').checked;
        }

        function ValidateHobbies(sender, args) {
            args.IsValid = document.getElementById('<%= chk1.ClientID %>').checked || document.getElementById('<%= chk2.ClientID %>').checked || document.getElementById('<%= chk3.ClientID %>').checked;
        }

        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            var input = evt.target.value;
            return (charCode >= 48 && charCode <= 57) || charCode === 8 || charCode === 46;
        }

        function isNumberKeyy(evt) {
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            var input = evt.target.value;
            return (charCode >= 48 && charCode <= 57) || charCode === 8 || charCode === 46;
        }

        function validateFile() {
            var fileInput = document.getElementById('<%= fileUploadImage.ClientID %>');
            var filePath = fileInput.value;
            var allowedExtensions = /(\.jpg|\.jpeg|\.png)$/i;
            if (!allowedExtensions.exec(filePath)) {
                alert('Invalid file type. Only .jpg, .jpeg, and .png are allowed.');
                fileInput.value = '';
                return false;
            }
            return true;
        }

        function validateForm() {
            return validateFile();
        }
    </script>
</head>
<body>
    <form id="form2" runat="server" onsubmit="return validateForm()">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <h2 class="text-center">Registration Form</h2>
                    <asp:ValidationSummary ID="ValidationSummary2" runat="server" ShowMessageBox="True" ShowSummary="False" />
                    <div style="text-align: right;">
                        <asp:Label ID="Label2" runat="server" Text=""></asp:Label>
                        <br />
                        <asp:Button ID="Button1" runat="server" Text="Logout" OnClick="btnLogout_Click" />
                        <asp:Button ID="Button2" runat="server" Text="Log In" OnClick="btnLogIn_Click" />
                    </div>
                    <table class="table">
                        <tr>
                            <td><asp:Label ID="Label5" runat="server" Text="First Name: "></asp:Label></td>
                            <td>
                                <asp:TextBox ID="TextBox2" runat="server" ToolTip="Please Provide your first name" onkeypress="return allowOnlyLetters(event)"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage="Please enter First Name" ValidationGroup="vgSubmit" ControlToValidate="TextBox2">Required</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="Label6" runat="server" Text="Last Name: "></asp:Label></td>
                            <td>
                                <asp:TextBox ID="TextBox3" runat="server" ToolTip="Please Provide your Last name" onkeypress="return allowOnlyLetters(event)"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ErrorMessage="Please enter Last Name" ValidationGroup="vgSubmit" ControlToValidate="TextBox3">Required</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="Label7" runat="server" Text="User Name: "></asp:Label></td>
                            <td>
                                <asp:TextBox ID="TextBox4" runat="server" ToolTip="Please Provide your User name"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ErrorMessage="Please enter User Name" ValidationGroup="vgSubmit" ControlToValidate="TextBox4">Required</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="Label8" runat="server" Text="Password: "></asp:Label></td>
                            <td>
                                <asp:TextBox ID="TextBox5" runat="server" TextMode="Password" ToolTip="Please Provide Password"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ControlToValidate="TextBox5" ValidationGroup="vgSubmit" ErrorMessage="Please enter Password">Required</asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="TextBox5" ValidationGroup="vgSubmit" ErrorMessage="Password must be at least 8 characters long and contain at least 1 uppercase letter, 1 lowercase letter, and 1 special character." ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$"></asp:RegularExpressionValidator>
                            </td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="Label9" runat="server" Text="Confirm Password: "></asp:Label></td>
                            <td>
                                <asp:TextBox ID="TextBox6" runat="server" TextMode="Password" ToolTip="Please Provide Password"></asp:TextBox>
                                <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToCompare="TextBox5" ControlToValidate="TextBox6" ValidationGroup="vgSubmit" ErrorMessage="Password & Confirm Password Must be Same">Must be same as Password</asp:CompareValidator>
                            </td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="Label10" runat="server" Text="E-mail: "></asp:Label></td>
                            <td>
                                <asp:TextBox ID="TextBox7" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ControlToValidate="TextBox7" ValidationGroup="vgSubmit" ErrorMessage="Please enter E-mail">Required</asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="TextBox7" ErrorMessage="Invalid e-mail id" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">Invalid e-mail id</asp:RegularExpressionValidator>
                            </td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="Label11" runat="server" Text="Mobile No.: "></asp:Label></td>
                            <td>
                                <asp:TextBox ID="TextBox8" runat="server" MaxLength="10" onkeypress="return isNumberKey(event)"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" ControlToValidate="TextBox8" ValidationGroup="vgSubmit" ErrorMessage="Please enter Mobile Number">Required</asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" ControlToValidate="TextBox8" ErrorMessage="Please enter valid Mobile Number" ValidationExpression="^[0-9]{10}$">Invalid Mobile Number</asp:RegularExpressionValidator>
                            </td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="Label12" runat="server" Text="Country: "></asp:Label></td>
                            <td>
                                <asp:TextBox ID="txtCountry" runat="server" readonly="readonly" onclick="showDropdown()" ToolTip="Click to select country"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" ControlToValidate="txtCountry" ValidationGroup="vgSubmit" ErrorMessage="Please select Country">Required</asp:RequiredFieldValidator>
                                <asp:Panel ID="PanelCountry" runat="server" CssClass="multiselect-checkbox" style="display:none;">
                                    <div class="input-multiselect">
                                        <asp:CheckBox ID="chkCountry1" runat="server" Text="Country 1" AutoPostBack="true" OnCheckedChanged="chkCountry_CheckedChanged" />
                                        <asp:CheckBox ID="chkCountry2" runat="server" Text="Country 2" AutoPostBack="true" OnCheckedChanged="chkCountry_CheckedChanged" />
                                        <asp:CheckBox ID="chkCountry3" runat="server" Text="Country 3" AutoPostBack="true" OnCheckedChanged="chkCountry_CheckedChanged" />
                                    </div>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="Label13" runat="server" Text="Gender: "></asp:Label></td>
                            <td>
                                <asp:RadioButton ID="rbtnM" runat="server" GroupName="gender" Text="Male" />
                                <asp:RadioButton ID="rbtnF" runat="server" GroupName="gender" Text="Female" />
                                <asp:RequiredFieldValidator ID="rfvGender" runat="server" ValidationGroup="vgSubmit" ControlToValidate="rbtnM" InitialValue="" ErrorMessage="Please select Gender" Display="Dynamic" ValidateEmptyText="true" OnServerValidate="ValidateGender"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="Label14" runat="server" Text="Hobbies: "></asp:Label></td>
                            <td>
                                <asp:CheckBox ID="chk1" runat="server" Text="Hobby 1" AutoPostBack="true" />
                                <asp:CheckBox ID="chk2" runat="server" Text="Hobby 2" AutoPostBack="true" />
                                <asp:CheckBox ID="chk3" runat="server" Text="Hobby 3" AutoPostBack="true" />
                                <asp:CustomValidator ID="CustomValidator1" runat="server" ControlToValidate="chk1" ClientValidationFunction="ValidateHobbies" ErrorMessage="Please select at least one hobby" ValidationGroup="vgSubmit"></asp:CustomValidator>
                            </td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="Label15" runat="server" Text="Profile Image: "></asp:Label></td>
                            <td>
                                <asp:FileUpload ID="fileUploadImage" runat="server" OnChange="return validateFile()" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator16" runat="server" ControlToValidate="fileUploadImage" ValidationGroup="vgSubmit" ErrorMessage="Please upload a profile image">Required</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:Button ID="btnSubmit" runat="server" Text="Submit" ValidationGroup="vgSubmit" OnClick="btnSubmit_Click" />
                                <asp:Button ID="btnReset" runat="server" Text="Reset" OnClick="btnReset_Click" />
                            </td>
                        </tr>
                    </table>
                            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" OnRowCommand="onRowCommand1" OnRowEditing="GridView1_RowEditing" OnRowDeleting="OnRowDeleting1" DataKeyNames="UserID" >
    <Columns>
        <asp:TemplateField HeaderText="First Name">
            <ItemTemplate>
                <asp:Label ID="lblFirstName" runat="server" Text='<%# Eval("FirstName") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Last Name">
            <ItemTemplate>
                <asp:Label ID="lblLastName" runat="server" Text='<%# Eval("LastName") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="User Name">
            <ItemTemplate>
                <asp:Label ID="lblUserName" runat="server" Text='<%# Eval("UserName") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Email">
            <ItemTemplate>
                <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("Email") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Mobile">
            <ItemTemplate>
                <asp:Label ID="lblMob" runat="server" Text='<%# Eval("Mobile") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Gender">
            <ItemTemplate>
                <asp:Label ID="lblGender" runat="server" Text='<%# Eval("Gender") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Age">
            <ItemTemplate>
                <asp:Label ID="lblAge" runat="server" Text='<%# Eval("Age") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Course">
            <ItemTemplate>
                <asp:Label ID="lblCourse" runat="server" Text='<%# Eval("Course") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Address">
            <ItemTemplate>
                <asp:Label ID="lblAdd" runat="server" Text='<%# Eval("Address") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
      <asp:TemplateField HeaderText="Profile Image">
        <ItemTemplate>
            <asp:Literal ID="litProfileImages" runat="server" Text='<%# BindImages(Container.DataItem) %>'></asp:Literal>
        </ItemTemplate>
        </asp:TemplateField>
                <asp:BoundField DataField="Skills" HeaderText="Skills" />
        <asp:TemplateField>
            <ItemTemplate>
                <asp:LinkButton ID="lnkEdit" runat="server" CommandName="Edit" CommandArgument='<%# Eval("UserID") %>'>Edit</asp:LinkButton>
                <asp:LinkButton ID="lnkDelete" runat="server" CommandName="Delete" CommandArgument='<%# Eval("UserID") %>'>Delete</asp:LinkButton>
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>
                </div>
            </div>
        </div>
    </form>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
