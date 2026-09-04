using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        private string cadenaConexion = ConfigurationManager.ConnectionStrings["PollolandiaDBCon"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
            }
        }

        protected void btnGuardarPerfil_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "alertPerfil", "alert('¡Perfil actualizado exitosamente!');", true);
        }

        protected void btnGenerarFactura_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtNombre.Text) || string.IsNullOrWhiteSpace(txtTelefono.Text) || string.IsNullOrWhiteSpace(txtDireccion.Text))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alertError", "alert('Por favor complete su nombre, teléfono y dirección de entrega.');", true);
                return;
            }

            decimal subtotal = 0;
            string detalleHtml = "<table class='table table-striped'><thead><tr><th>Producto</th><th>Cantidad</th><th>Precio Unitario</th><th>Total</th></tr></thead><tbody>";

            Dictionary<string, decimal> precios = new Dictionary<string, decimal>()
            {
                { "txtCantMenu2", 135.00m },
                { "txtCantPolloChuco1", 140.00m },
                { "txtCantPolloChuco2", 175.00m },
                { "txtCantMenu11", 320.00m },
                { "txtCantMenu1", 120.00m },
                { "txtCantPolloPapas2", 165.00m },
                { "txtCantPolloPapa3", 130.00m },
                { "txtCantPolloPapa4", 150.00m },
                { "txtCantPolloPapaClasico", 115.00m },
                { "txtCantPolloAsadoEntero", 260.00m },
                { "txtCantPolloAsadoPedazos", 145.00m },
                { "txtCantPolloFritoEntero", 270.00m },
                { "txtCantPolloFritoPedazos", 135.00m },
                { "txtCantSprite", 25.00m },
                { "txtCantLipton", 30.00m },
                { "txtCantFresco2", 25.00m },
                { "txtCantFresco3", 25.00m },
                { "txtCantFresco4", 28.00m },
                { "txtCantFresco5", 20.00m },
                { "txtCantPostreBase", 45.00m },
                { "txtCantPapasSonrientes", 35.00m },
                { "txtCantPostre2", 40.00m },
                { "txtCantPostre3", 50.00m },
                { "txtCantPostre4", 30.00m },
                { "txtCantPostre5", 35.00m },
                { "txtCantPostre6", 55.00m },
                { "txtCantPostre7", 25.00m },
                { "txtCantEnsalada", 30.00m },
                { "txtCantPure", 35.00m },
                { "txtCantAderezo", 15.00m },
                { "txtCantKetchup", 10.00m }
            };

            Dictionary<string, string> nombresProductos = new Dictionary<string, string>()
            {
                { "txtCantMenu2", "Pollo con Tajadas" },
                { "txtCantPolloChuco1", "Pollo Chuco Especial" },
                { "txtCantPolloChuco2", "Pollo Chuco Dúo" },
                { "txtCantMenu11", "Combo Familiar Chuco" },
                { "txtCantMenu1", "Combo Pollo con Papas" },
                { "txtCantPolloPapas2", "Combo Pollo con Papas Dúo" },
                { "txtCantPolloPapa3", "Pollo con Papas Especial" },
                { "txtCantPolloPapa4", "Pollo con Papas Maxi" },
                { "txtCantPolloPapaClasico", "Pollo con Papas Clásico" },
                { "txtCantPolloAsadoEntero", "Pollo Asado Entero" },
                { "txtCantPolloAsadoPedazos", "Pollo Asado en Pedazos" },
                { "txtCantPolloFritoEntero", "Pollo Frito Entero" },
                { "txtCantPolloFritoPedazos", "Pollo Frito en Pedazos" },
                { "txtCantSprite", "Refresco Sprite" },
                { "txtCantLipton", "Té Frío Lipton" },
                { "txtCantFresco2", "Refresco Coca Cola" },
                { "txtCantFresco3", "Bebida Sabor Naranja" },
                { "txtCantFresco4", "Jugo Embotellado" },
                { "txtCantFresco5", "Agua Embotellada" },
                { "txtCantPostreBase", "Postre de la Casa" },
                { "txtCantPapasSonrientes", "Papas Sonrientes" },
                { "txtCantPostre2", "Pie de Limón" },
                { "txtCantPostre3", "Tres Leches" },
                { "txtCantPostre4", "Gelatina con Crema" },
                { "txtCantPostre5", "Cupcake de Chocolate" },
                { "txtCantPostre6", "Brownie con Helado" },
                { "txtCantPostre7", "Donas Especiales" },
                { "txtCantEnsalada", "Ensalada Fresca" },
                { "txtCantPure", "Puré de Papa Cremoso" },
                { "txtCantAderezo", "Aderezo Blanco de la Casa" },
                { "txtCantKetchup", "Salsa Ketchup Especial" }
            };

            bool hayProductos = false;
            var listaDetalles = new List<Tuple<string, int, decimal, decimal>>();

            foreach (var kvp in precios)
            {
                string controlId = kvp.Key;
                decimal precioUnitario = kvp.Value;

                TextBox txtBox = (TextBox)FindControlRecursive(this, controlId);
                if (txtBox != null)
                {
                    int cantidad = 0;
                    if (int.TryParse(txtBox.Text, out cantidad) && cantidad > 0)
                    {
                        hayProductos = true;
                        decimal totalLinea = cantidad * precioUnitario;
                        subtotal += totalLinea;

                        string nombreProd = nombresProductos.ContainsKey(controlId) ? nombresProductos[controlId] : controlId;
                        detalleHtml += $"<tr><td>{nombreProd}</td><td>{cantidad}</td><td>L. {precioUnitario:N2}</td><td>L. {totalLinea:N2}</td></tr>";

                        listaDetalles.Add(new Tuple<string, int, decimal, decimal>(nombreProd, cantidad, precioUnitario, totalLinea));
                    }
                }
            }

            detalleHtml += "</tbody></table>";

            if (!hayProductos)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alertSinProductos", "alert('Por favor selecciona al menos un producto o cantidad mayor a 0 en el menú.');", true);
                return;
            }

            decimal impuesto = subtotal * 0.15m;
            decimal costoEntrega = (ddlTipoEntrega.SelectedValue == "Domicilio") ? 35.00m : 0.00m;
            decimal totalGeneral = subtotal + impuesto + costoEntrega;

            // GUARDAMOS TEMPORALMENTE LOS DETALLES EN SESIÓN PARA NO GUARDAR AÚN EN BASE DE DATOS
            Session["DetallesPedidoTemporal"] = listaDetalles;
            Session["SubtotalPedido"] = subtotal;
            Session["ImpuestoPedido"] = impuesto;
            Session["CostoEntregaPedido"] = costoEntrega;
            Session["TotalPedido"] = totalGeneral;

            // MOSTRAR DATOS EN PANTALLA
            lblFacturaNombre.Text = txtNombre.Text;
            lblFacturaTelefono.Text = txtTelefono.Text;
            lblFacturaDireccion.Text = txtDireccion.Text;
            lblFacturaFecha.Text = DateTime.Now.ToString("dd/MM/yyyy HH:mm");
            lblFacturaServicio.Text = ddlTipoEntrega.SelectedItem.Text;

            litDetalleOrden.Text = detalleHtml;

            lblSubtotal.Text = $"L. {subtotal:N2}";
            lblImpuesto.Text = $"L. {impuesto:N2}";
            lblCostoEntrega.Text = $"L. {costoEntrega:N2}";
            lblTotal.Text = $"L. {totalGeneral:N2}";

            pnlFactura.Visible = true;
            ScriptManager.RegisterStartupScript(this, GetType(), "scrollToFactura", "window.location.hash = '#pnlFactura';", true);
        }

        protected void btnModificar_Click(object sender, EventArgs e)
        {
            pnlFactura.Visible = false;
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            // AL ELIMINAR SIMPLEMENTE LIMPIAMOS LA SESIÓN Y LOS CAMPOS (NADA SE GUARDÓ EN LA BASE DE DATOS)
            Session.Remove("DetallesPedidoTemporal");
            Session.Remove("SubtotalPedido");
            Session.Remove("ImpuestoPedido");
            Session.Remove("CostoEntregaPedido");
            Session.Remove("TotalPedido");

            foreach (Control c in this.Controls)
            {
                LimpiarControlesRecursivo(c);
            }
            pnlFactura.Visible = false;
            ScriptManager.RegisterStartupScript(this, GetType(), "alertEliminado", "alert('El pedido ha sido cancelado y no fue guardado.');", true);
        }

        protected void btnEnvioEntregado_Click(object sender, EventArgs e)
        {
            // AQUÍ ES DONDE REALMENTE CONFIRMAMOS Y GUARDAMOS EL PEDIDO EN LA BASE DE DATOS
            if (Session["DetallesPedidoTemporal"] != null)
            {
                var listaDetalles = (List<Tuple<string, int, decimal, decimal>>)Session["DetallesPedidoTemporal"];
                decimal subtotal = (decimal)Session["SubtotalPedido"];
                decimal impuesto = (decimal)Session["ImpuestoPedido"];
                decimal costoEntrega = (decimal)Session["CostoEntregaPedido"];
                decimal totalGeneral = (decimal)Session["TotalPedido"];

                try
                {
                    using (SqlConnection conexion = new SqlConnection(cadenaConexion))
                    {
                        conexion.Open();

                        string queryPedido = @"INSERT INTO Pedidos (ClienteNombre, Telefono, Direccion, TipoEntrega, Subtotal, Impuesto, CostoEntrega, Total) 
                                               OUTPUT INSERTED.PedidoID 
                                               VALUES (@ClienteNombre, @Telefono, @Direccion, @TipoEntrega, @Subtotal, @Impuesto, @CostoEntrega, @Total)";

                        int nuevoPedidoID = 0;
                        using (SqlCommand cmdPedido = new SqlCommand(queryPedido, conexion))
                        {
                            cmdPedido.Parameters.AddWithValue("@ClienteNombre", txtNombre.Text);
                            cmdPedido.Parameters.AddWithValue("@Telefono", txtTelefono.Text);
                            cmdPedido.Parameters.AddWithValue("@Direccion", txtDireccion.Text);
                            cmdPedido.Parameters.AddWithValue("@TipoEntrega", ddlTipoEntrega.SelectedItem.Text);
                            cmdPedido.Parameters.AddWithValue("@Subtotal", subtotal);
                            cmdPedido.Parameters.AddWithValue("@Impuesto", impuesto);
                            cmdPedido.Parameters.AddWithValue("@CostoEntrega", costoEntrega);
                            cmdPedido.Parameters.AddWithValue("@Total", totalGeneral);

                            nuevoPedidoID = (int)cmdPedido.ExecuteScalar();
                        }

                        foreach (var detalle in listaDetalles)
                        {
                            string queryDetalle = @"INSERT INTO DetallePedidos (PedidoID, ProductoNombre, Cantidad, PrecioUnitario, TotalItem) 
                                                   VALUES (@PedidoID, @ProductoNombre, @Cantidad, @PrecioUnitario, @TotalItem)";

                            using (SqlCommand cmdDetalle = new SqlCommand(queryDetalle, conexion))
                            {
                                cmdDetalle.Parameters.AddWithValue("@PedidoID", nuevoPedidoID);
                                cmdDetalle.Parameters.AddWithValue("@ProductoNombre", detalle.Item1);
                                cmdDetalle.Parameters.AddWithValue("@Cantidad", detalle.Item2);
                                cmdDetalle.Parameters.AddWithValue("@PrecioUnitario", detalle.Item3);
                                cmdDetalle.Parameters.AddWithValue("@TotalItem", detalle.Item4);

                                cmdDetalle.ExecuteNonQuery();
                            }
                        }
                    }

                    // Limpiar variables de sesión tras completar la transacción
                    Session.Remove("DetallesPedidoTemporal");
                    ScriptManager.RegisterStartupScript(this, GetType(), "alertCompletado", "alert('¡Excelente! Tu pedido ha sido confirmado y registrado exitosamente.');", true);
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alertDBError", $"alert('Error al procesar el pedido: {ex.Message.Replace("'", "")}');", true);
                    return;
                }
            }

            foreach (Control c in this.Controls)
            {
                LimpiarControlesRecursivo(c);
            }
            pnlFactura.Visible = false;
        }

        private Control FindControlRecursive(Control rootControl, string controlId)
        {
            if (rootControl.ID == controlId) return rootControl;
            foreach (Control childControl in rootControl.Controls)
            {
                Control result = FindControlRecursive(childControl, controlId);
                if (result != null) return result;
            }
            return null;
        }

        private void LimpiarControlesRecursivo(Control ctrl)
        {
            if (ctrl is TextBox txt && txt.TextMode == TextBoxMode.Number)
            {
                txt.Text = "0";
            }
            foreach (Control child in ctrl.Controls)
            {
                LimpiarControlesRecursivo(child);
            }
        }
    }
}