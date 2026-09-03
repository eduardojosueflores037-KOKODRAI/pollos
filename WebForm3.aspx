<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm3.aspx.cs" Inherits="WebApplication1.WebForm3" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Gestión de la Empresa - Pollolandia</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="bg-danger bg-opacity-10">
    <form id="form1" runat="server">
        <div class="container my-5">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h1 class="text-danger fw-bold">Panel de Gestión - Pollolandia</h1>
                <asp:Button ID="btnCerrarSesion" runat="server" Text="Cerrar Sesión" CssClass="btn btn-outline-danger" OnClick="btnCerrarSesion_Click" />
            </div>

            <div class="card mb-4 border-danger shadow-sm">
                <div class="card-header bg-danger text-white">
                    <h4 class="mb-0">Conjunto / Combos Más Solicitados</h4>
                </div>
                <div class="card-body">
                    <ul class="list-group list-group-flush fs-5">
                        <li class="list-group-item"><strong>Entrada más pedida:</strong> <asp:Label ID="lblEntradaMasPedida" runat="server" Text="Cargando..." /></li>
                        <li class="list-group-item"><strong>Plato Principal más pedido:</strong> <asp:Label ID="lblPlatoMasPedido" runat="server" Text="Cargando..." /></li>
                        <li class="list-group-item"><strong>Refresco más pedido:</strong> <asp:Label ID="lblRefrescoMasPedido" runat="server" Text="Cargando..." /></li>
                    </ul>
                </div>
            </div>

            <div class="row mb-4">
                <div class="col-md-4">
                    <div class="card text-white bg-success mb-3 shadow-sm">
                        <div class="card-header">Ingresos de Hoy</div>
                        <div class="card-body">
                            <h3 class="card-title"><asp:Label ID="lblIngresosDia" runat="server" Text="L. 0.00" /></h3>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card text-white bg-danger mb-3 shadow-sm">
                        <div class="card-header">Ingresos del Mes</div>
                        <div class="card-body">
                            <h3 class="card-title"><asp:Label ID="lblIngresosMes" runat="server" Text="L. 0.00" /></h3>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card text-white bg-dark mb-3 shadow-sm">
                        <div class="card-header">Pérdidas Totales</div>
                        <div class="card-body">
                            <h3 class="card-title"><asp:Label ID="lblPerdidas" runat="server" Text="L. 0.00" /></h3>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card shadow-sm border-danger">
                <div class="card-header bg-danger text-white">
                    <h4 class="mb-0">Historial de Pedidos</h4>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <asp:GridView ID="gvPedidos" runat="server" CssClass="table table-striped table-hover align-middle" AutoGenerateColumns="true">
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>