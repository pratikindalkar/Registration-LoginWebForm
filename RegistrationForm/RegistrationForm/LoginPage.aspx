<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginPage.aspx.cs" Inherits="RegistrationForm.LoginPage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login Page</title>
</head>
<body>
    <form id="form1" runat="server" >
        <table style="margin:auto">
            <tr>
                <td><asp:Label ID="lbl1" runat="server" Text="Email/Mobile No.: "></asp:Label></td>
                <td><asp:TextBox ID="txtUMob" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td><asp:Label ID="lbl2" runat="server" Text="Password: "></asp:Label></td>
                <td><asp:TextBox ID="txtLPass" runat="server" TextMode="Password"></asp:TextBox></td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center;">
                    <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" />
                    <asp:Button ID="btnRegister" runat="server" Text="Register" OnClick="btnRegister_Click" />
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center;">
                    <asp:Label ID="lblError" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center;" >
                    <asp:Label ID="lblWelcome" runat="server" Text="" Visible="False"></asp:Label>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
