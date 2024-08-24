<%@ Page Language="C#" AutoEventWireup="true" UnobtrusiveValidationMode="none" CodeBehind="RegistrationPage.aspx.cs" Inherits="RegistrationForm.RegistrationPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Registration Form</title>
    <style>
        .dropdown-container {
            display: flex;
            align-items: center;
            width: 300px; 
        }

        .dropdown-button {
            cursor: pointer;
            border: 1px solid #ccc;
            padding: 10px;
            background-color: #f9f9f9;
            border-radius: 5px;
            text-align: left;
            margin-left: 10px; 
            flex: 1; 
        }

        .dropdown {
            position: relative;
            display: inline-block;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            background-color: white;
            border: 1px solid #ccc;
            border-radius: 5px;
            z-index: 1;
            width: 100%;
            max-height: 150px;
            overflow-y: auto;
            padding: 10px;
        }

        .dropdown-content input {
            margin-right: 10px;
        }

        .show {
            display: block;
        }
    </style>
    <script type="text/javascript">

        function allowOnlyLetters(event) {
            var charCode = event.which ? event.which : event.keyCode;
            if ([8, 9, 27, 13].indexOf(charCode) !== -1 ||
                (charCode === 65 && (event.ctrlKey === true || event.metaKey === true)) ||
                (charCode === 67 && (event.ctrlKey === true || event.metaKey === true)) ||
                (charCode === 88 && (event.ctrlKey === true || event.metaKey === true)) ||
                (charCode === 86 && (event.ctrlKey === true || event.metaKey === true)) ||
                (charCode >= 35 && charCode <= 39)) {
                return true;
            }
            return charCode >= 65 && charCode <= 90 || charCode >= 97 && charCode <= 122;
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
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            if (input.length >= 10 && charCode !== 8 && charCode !== 46) {
                return false;
            }
            return true;
        }
        function isNumberKeyy(evt) {
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            var input = evt.target.value;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            if (input.length >= 2 && charCode !== 8 && charCode !== 46) {
                return false;
            }
            return true;
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

        function toggleDropdown() {
            var content = document.getElementById('DropdownContent');
            content.classList.toggle('show');
        }

        //function closeDropdown(event) {
        //    if (!event.target.matches('.dropdown-button')) {
        //        var dropdowns = document.getElementsByClassName('dropdown-content');
        //        for (var i = 0; i < dropdowns.length; i++) {
        //            var openDropdown = dropdowns[i];
        //            if (openDropdown.classList.contains('show')) {
        //                openDropdown.classList.remove('show');
        //            }
        //        }
        //    }
        //}

        window.onclick = closeDropdown;
    </script>
</head>
<body>
    <form id="form1" runat="server" >
        <div>
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True" ShowSummary="False" />
            <asp:Label Id="UserID" runat="server" Visible="false" Text="Label"></asp:Label>
            <div style="text-align: right;">
            <asp:Label ID="lblWelcome" runat="server" Text=""></asp:Label>
            <br />
            <asp:Button ID="btnLogout" runat="server" Text="Logout" OnClick="btnLogout_Click" />
            <asp:Button ID="btnLogIn" runat="server" Text="Log In" OnClick="btnLogIn_Click" />
        </div>
            <table>
                <tr>
                    <td><asp:Label ID="lbl1" runat="server" Text="First Name: "></asp:Label></td>
                    <td>
                        <asp:TextBox ID="txtFirstName" runat="server" ToolTip="Please Provide your first name" onkeypress="return allowOnlyLetters(event)"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please enter First Name" ValidationGroup="vgSubmit" ControlToValidate="txtFirstName">Required</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td><asp:Label ID="lbl2" runat="server" Text="Last Name: "></asp:Label></td>
                    <td>
                        <asp:TextBox ID="txtLastName" runat="server" ToolTip="Please Provide your Last name" onkeypress="return allowOnlyLetters(event)"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please enter Last Name" ValidationGroup="vgSubmit" ControlToValidate="txtLastName">Required</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td><asp:Label ID="lbl3" runat="server" Text="User Name: "></asp:Label></td>
                    <td>
                        <asp:TextBox ID="txtUname" runat="server" ToolTip="Please Provide your User name"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Please enter User Name" ValidationGroup="vgSubmit" ControlToValidate="txtUname">Required</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td><asp:Label ID="lbl4" runat="server" Text="Password: "></asp:Label></td>
                    <td>
                        <asp:TextBox ID="txtPass" runat="server" TextMode="Password" ToolTip="Please Provide Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtPass" ValidationGroup="vgSubmit" ErrorMessage="Please enter Password">Required</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" 
                            ControlToValidate="txtPass" 
                            ValidationGroup="vgSubmit"
                            ErrorMessage="Password must be at least 8 characters long and contain at least 1 uppercase letter, 1 lowercase letter, and 1 special character."
                            ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$">
                        </asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr>
                    <td><asp:Label ID="lbl5" runat="server" Text="Confirm Password: "></asp:Label></td>
                    <td>
                        <asp:TextBox ID="txtCpass" runat="server" TextMode="Password" ToolTip="Please Provide Password"></asp:TextBox>
                        <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txtPass" ControlToValidate="txtCpass" ValidationGroup="vgSubmit" ErrorMessage="Password & Confirm Password Must be Same">Must be same as Password</asp:CompareValidator>
                    </td>
                </tr>
                <tr>
                    <td><asp:Label ID="lbl6" runat="server" Text="E-mail: "></asp:Label></td>
                    <td>
                        <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtEmail" ValidationGroup="vgSubmit" ErrorMessage="Please enter E-mail">Required</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtEmail" ErrorMessage="Invalid e-mail id" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">Invalid e-mail id</asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr>
                    <td><asp:Label ID="lbl7" runat="server" Text="Mobile No.: "></asp:Label></td>
                    <td>
                        <asp:TextBox ID="txtMob" runat="server" ToolTip="Please enter Mobile no." onkeypress="return isNumberKey(event)"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtMob" ValidationGroup="vgSubmit" ErrorMessage="Please enter Mobile No.">Required</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtMob" ErrorMessage="Invalid mobile number" ValidationExpression="[0-9]{10}">Invalid mobile number</asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr>
                    <td><asp:Label ID="lbl8" runat="server" Text="Gender: "></asp:Label></td>
                    <td>
                        <asp:RadioButton ID="rbtnM" runat="server" Text="Male" GroupName="GenderMF" />
                        <asp:RadioButton ID="rbtnF" runat="server" Text="Female" GroupName="GenderMF" />
                        <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Please select Gender" ClientValidationFunction="ValidateGender" ValidationGroup="vgSubmit" ValidateEmptyText="true"></asp:CustomValidator>
                    </td>
                </tr>
                <tr>
                    <td><asp:Label ID="lbl9" runat="server" Text="Age: "></asp:Label></td>
                    <td>
                        <asp:TextBox ID="txtAge" runat="server" onkeypress="return isNumberKeyy(event)"></asp:TextBox>
                        <asp:RangeValidator ID="RangeValidator1" runat="server" ErrorMessage="Age must be greater than 18 and less than 40" MinimumValue="18" ValidationGroup="vgSubmit" MaximumValue="40" ControlToValidate="txtAge"></asp:RangeValidator>
                    </td>
                </tr>
                <tr>
                    <td><asp:Label ID="lbl10" runat="server" Text="Course: "></asp:Label></td>
                    <td>
                        <asp:DropDownList ID="DropDownList1" runat="server">
                            <asp:ListItem>Select One</asp:ListItem>
                            <asp:ListItem>IT</asp:ListItem>
                            <asp:ListItem>CS</asp:ListItem>
                            <asp:ListItem>Other</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ValidationGroup="vgSubmit" ControlToValidate="DropDownList1" InitialValue="Select One" ErrorMessage="Please select a course">Required</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td><asp:Label ID="lbl11" runat="server" Text="Hobbies: "></asp:Label></td>
                    <td>
                        <asp:CheckBox ID="chk1" runat="server" Text="Cricket" />
                        <asp:CheckBox ID="chk2" runat="server" Text="Volleyball" />
                        <asp:CheckBox ID="chk3" runat="server" Text="Other" />
                        <asp:CustomValidator ID="CustomValidator2" runat="server" ValidationGroup="vgSubmit" ErrorMessage="Please select at least one hobby" ClientValidationFunction="ValidateHobbies" ValidateEmptyText="true"></asp:CustomValidator>
                    </td>
                </tr>
                <tr>
                    <td><asp:Label ID="lbl13" runat="server" Text="Address: "></asp:Label></td>
                    <td>
                        <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" Rows="3" Columns="20" ToolTip="Please Provide your address"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ValidationGroup="vgSubmit" ControlToValidate="txtAddress" ErrorMessage="Please enter Address">Required</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td><asp:Label ID="lbl14" runat="server" Text="Image: "></asp:Label></td>
                    <td>
                        <asp:FileUpload ID="fileUploadImage" runat="server" AllowMultiple="true" oninput=validateFile() />
                    </td>
                </tr>
                <tr>
                    <td><asp:Label ID="lblSkills" runat="server" Text="Skills: "></asp:Label></td>
                    <td>
                        <div class="dropdown-container">
                            <div class="dropdown">
                                <div class="dropdown-button" id="dropdownButton" onclick="toggleDropdown()">
                                    Select Skills
                                </div>
                                <div id="DropdownContent" class="dropdown-content">
                                    <asp:CheckBoxList ID="CheckBoxList1" runat="server">
                                        <asp:ListItem Text="Java" Value="Java"></asp:ListItem>
                                        <asp:ListItem Text="ASP.NET" Value="ASP.NET"></asp:ListItem>
                                        <asp:ListItem Text="C#" Value="C#"></asp:ListItem>
                                        <asp:ListItem Text="HTML" Value="HTML"></asp:ListItem>
                                        <asp:ListItem Text="CSS" Value="CSS"></asp:ListItem>
                                    </asp:CheckBoxList>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>

                <tr>
                    <td>
                        <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" ValidationGroup="vgSubmit" Text="Submit" />
                        <asp:Button ID="btnUpdate" runat="server" Text="Update" OnClick="btnUpdate_Click1"/>
                        <asp:Button ID="btnClear" runat="server" Text="Clear" OnClick="btnClear_Click" />
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <asp:Label ID="lblResult" runat="server" Text="" Visible="False"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" OnRowCommand="onRowCommand1" OnRowEditing="GridView1_RowEditing" OnRowDeleting="OnRowDeleting1" DataKeyNames="UserID" >
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
    </form>
</body>
</html>