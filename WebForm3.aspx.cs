using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace WebApplication1
{
    public partial class WebForm3 : Page
    {
        private readonly string cadenaConexion = ConfigurationManager.ConnectionStrings["PollolandiaDBCon"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Validar sesión activa del administrador
            if (Session["AdminAutenticado"] == null || !(bool)Session["AdminAutenticado"])
            {
                Response.Redirect("WebForm1.aspx");
                return;
            }

            if (!IsPostBack)
            {
                CargarPanelAdmin();
            }
        }

        private void CargarPanelAdmin()
        {
            using (SqlConnection con = new SqlConnection(cadenaConexion))
            {
                con.Open();

                // 1. Cargar el historial detallado de pedidos incluyendo todos los productos (entradas, platos, refrescos, salsas y acompañantes)
                string queryHistorial = @"
                    SELECT 
                        p.PedidoID, 
                        p.ClienteNombre, 
                        p.Telefono, 
                        p.Direccion, 
                        p.TipoEntrega, 
                        d.ProductoNombre AS Producto,
                        d.Cantidad,
                        d.PrecioUnitario,
                        p.Total, 
                        p.FechaRegistro 
                    FROM Pedidos p
                    LEFT JOIN DetallePedidos d ON p.PedidoID = d.PedidoID
                    ORDER BY p.FechaRegistro DESC";

                using (SqlCommand cmdHistorial = new SqlCommand(queryHistorial, con))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmdHistorial))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        gvPedidos.DataSource = dt;
                        gvPedidos.DataBind();
                    }
                }

                // 2. Calcular Ingresos de Hoy en tiempo real
                using (SqlCommand cmdHoy = new SqlCommand("SELECT ISNULL(SUM(Total), 0) FROM Pedidos WHERE CAST(FechaRegistro AS DATE) = CAST(GETDATE() AS DATE)", con))
                {
                    decimal ingresosHoy = Convert.ToDecimal(cmdHoy.ExecuteScalar());
                    lblIngresosDia.Text = $"L. {ingresosHoy:N2}";
                }

                // 3. Calcular Ingresos del Mes en tiempo real
                using (SqlCommand cmdMes = new SqlCommand("SELECT ISNULL(SUM(Total), 0) FROM Pedidos WHERE MONTH(FechaRegistro) = MONTH(GETDATE()) AND YEAR(FechaRegistro) = YEAR(GETDATE())", con))
                {
                    decimal ingresosMes = Convert.ToDecimal(cmdMes.ExecuteScalar());
                    lblIngresosMes.Text = $"L. {ingresosMes:N2}";
                }

                // 4. Plato Principal más pedido
                try
                {
                    string queryPlatos = @"SELECT TOP 1 ProductoNombre 
                                           FROM DetallePedidos 
                                           WHERE ProductoNombre IN ('Pollo con Tajadas', 'Pollo Frito con Papas', 'Hamburguesa Especial', 'Pechuga a la Plancha', 'Alitas Barbacoa', 'Burrito de Pollo', 'Tacos Dorados', 'Crispy Burger') 
                                           GROUP BY ProductoNombre 
                                           ORDER BY SUM(Cantidad) DESC";

                    using (SqlCommand cmdPlato = new SqlCommand(queryPlatos, con))
                    {
                        object resultadoPlato = cmdPlato.ExecuteScalar();
                        lblPlatoMasPedido.Text = resultadoPlato != null ? resultadoPlato.ToString() : "Sin registros";
                    }
                }
                catch
                {
                    lblPlatoMasPedido.Text = "No disponible";
                }

                // 5. Entrada más pedida
                try
                {
                    string queryEntradas = @"SELECT TOP 1 ProductoNombre 
                                             FROM DetallePedidos 
                                             WHERE ProductoNombre IN ('Postre de la Casa', 'Papas Sonrientes', 'Bolitas de pollo', 'aros de cebolla', 'tiras de pollo', 'sandwich de pollo', 'gorditos de pollo', 'Empanadas de pollo') 
                                             GROUP BY ProductoNombre 
                                             ORDER BY SUM(Cantidad) DESC";

                    using (SqlCommand cmdEntrada = new SqlCommand(queryEntradas, con))
                    {
                        object resultadoEntrada = cmdEntrada.ExecuteScalar();
                        lblEntradaMasPedida.Text = resultadoEntrada != null ? resultadoEntrada.ToString() : "Ninguna registrada";
                    }
                }
                catch
                {
                    lblEntradaMasPedida.Text = "No disponible";
                }

                // 6. Refresco más pedido
                try
                {
                    string queryRefrescos = @"SELECT TOP 1 ProductoNombre 
                                              FROM DetallePedidos 
                                              WHERE ProductoNombre LIKE '%refresco%' OR ProductoNombre LIKE '%soda%' OR ProductoNombre LIKE '%coca%' OR ProductoNombre LIKE '%pepsi%' OR ProductoNombre LIKE '%fresco%' OR ProductoNombre LIKE '%jugo%' OR ProductoNombre LIKE '%horchata%' OR ProductoNombre LIKE '%jamaica%'
                                              GROUP BY ProductoNombre 
                                              ORDER BY SUM(Cantidad) DESC";

                    using (SqlCommand cmdRefresco = new SqlCommand(queryRefrescos, con))
                    {
                        object resultadoRefresco = cmdRefresco.ExecuteScalar();
                        lblRefrescoMasPedido.Text = resultadoRefresco != null ? resultadoRefresco.ToString() : "Ninguno registrado";
                    }
                }
                catch
                {
                    lblRefrescoMasPedido.Text = "No disponible";
                }
            }
        }

        protected void btnCerrarSesion_Click(object sender, EventArgs e)
        {
            Session.Remove("AdminAutenticado");
            Response.Redirect("WebForm1.aspx");
        }
    }
}