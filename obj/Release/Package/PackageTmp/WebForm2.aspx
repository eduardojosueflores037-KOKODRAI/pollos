<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm2.aspx.cs" Inherits="WebApplication1.WebForm2" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Acceso Administrador</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="bg-danger bg-opacity-10 d-flex align-items-center vh-100">
    <form id="form1" runat="server" class="w-100 container">
        <div class="row justify-content-center">
            <div class="col-md-4">
                <div class="card shadow border-top border-danger border-4">
                    <div class="card-body">
                        <h3 class="card-title text-center mb-4 text-danger fw-bold">Iniciar Sesión Admin</h3>
                        <div class="mb-3">
                            <label class="form-label">Usuario</label>
                            <asp:TextBox ID="txtUsuario" runat="server" CssClass="form-control" Required="true" />
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Contraseña</label>
                            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" Required="true" />
                        </div>
                        <asp:Button ID="btnLogin" runat="server" Text="Ingresar" CssClass="btn btn-danger w-100" OnClick="btnLogin_Click" />
                        <asp:Label ID="lblMensaje" runat="server" CssClass="text-danger mt-2 d-block text-center" />
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>