<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="WebApplication1.WebForm1" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Pollolandia - Sabor y Calidad</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Google Fonts: Poppins -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #ffeb3b; /* FONDO AMARILLO */
            color: #333;
        }
        .navbar-pollolandia { 
            background-color: #8b0000; 
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        .navbar-pollolandia .nav-link { 
            color: #fff !important; 
            font-weight: 500; 
            transition: all 0.3s ease;
        }
        .navbar-pollolandia .nav-link:hover {
            color: #ffc107 !important;
        }
        .navbar-pollolandia .nav-link.active { 
            background-color: #ffc107 !important; 
            color: #000 !important; 
            font-weight: 600;
            border-radius: 5px;
        }
        .dropdown-menu .dropdown-item:active, 
        .dropdown-menu .dropdown-item.active {
            background-color: #8b0000;
            color: #fff !important;
        }
        .card-header-pollolandia { 
            background-color: #8b0000; 
            color: white; 
            font-weight: 600; 
            text-align: center; 
            letter-spacing: 0.5px;
        }
        .btn-rojo { 
            background-color: #8b0000; 
            color: white; 
            border: none; 
            font-weight: 500;
            transition: background-color 0.3s ease;
        }
        .btn-rojo:hover { 
            background-color: #a00000; 
            color: white; 
        }
        .carousel-item img {
            height: 400px;
            object-fit: cover;
            border-radius: 10px;
        }
        .card {
            border: none;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.05);
        }
        .max-w-500 {
            max-width: 500px;
        }
        @media print {
            body {
                background-color: white !important;
            }
            .navbar, .btn, hr {
                display: none !important;
            }
            .card {
                box-shadow: none !important;
                border: none !important;
            }
        }
    </style>
    <script>
        var usuarioAutenticado = false;

        function verificarSesionParaOrdenar(e) {
            if (!usuarioAutenticado) {
                if (e) e.preventDefault();
                var triggerEl = document.querySelector('a[href="#cuenta"]');
                var tab = new bootstrap.Tab(triggerEl);
                tab.show();
                document.getElementById("alertaSesionRequerida").classList.remove("d-none");
            }
        }

        function simularInicioSesion() {
            usuarioAutenticado = true;
            document.getElementById("alertaSesionRequerida").classList.add("d-none");
            alert("¡Sesión iniciada exitosamente! Ahora puedes realizar tus pedidos.");
            var triggerEl = document.querySelector('a[href="#orden"]');
            var tab = new bootstrap.Tab(triggerEl);
            tab.show();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        
        <!-- BARRA DE NAVEGACIÓN SUPERIOR -->
        <nav class="navbar navbar-expand-lg navbar-pollolandia sticky-top">
            <div class="container-fluid px-4">
                <a class="navbar-brand d-flex align-items-center text-warning fw-bold text-decoration-none" data-bs-toggle="pill" href="#inicio" style="cursor: pointer;">
                    <img src="logo-pollolandia.png" alt="Logotipo Pollolandia" style="height: 45px; width: auto;" class="me-2 rounded bg-white p-1" />
                    Pollolandia
                </a>
                <button class="navbar-toggler bg-warning" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto nav nav-pills gap-2 align-items-center" role="tablist">
                        <li class="nav-item"><a class="nav-link active" data-bs-toggle="pill" href="#inicio">Inicio</a></li>
                        <li class="nav-item"><a class="nav-link" data-bs-toggle="pill" href="#menu">Menú</a></li>
                        <li class="nav-item"><a class="nav-link" data-bs-toggle="pill" href="#extras">Refrescos</a></li>
                        <li class="nav-item"><a class="nav-link" data-bs-toggle="pill" href="#postres">Entradas</a></li>
                        <li class="nav-item"><a class="nav-link" data-bs-toggle="pill" href="#salsas">Salsas y Acompañantes</a></li>
                        <li class="nav-item"><a class="nav-link" data-bs-toggle="pill" href="#locales">Locales</a></li>
                        <li class="nav-item"><a class="nav-link" data-bs-toggle="pill" href="#orden" onclick="verificarSesionParaOrdenar(event)">Hacer Pedido</a></li>
                        
                        <!-- MENÚ DESPLEGABLE MI CUENTA / ADMINISTRACIÓN -->
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle d-flex align-items-center gap-2" id="navbarDropdownUser" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <span>👤</span> Mi Cuenta
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end shadow" aria-labelledby="navbarDropdownUser">
                                <li>
                                    <a class="dropdown-item d-flex align-items-center gap-2 py-2" data-bs-toggle="pill" href="#cuenta">
                                        <span>🔑</span> Iniciar Sesión
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item d-flex align-items-center gap-2 py-2" data-bs-toggle="pill" href="#perfil">
                                        <span>⚙️</span> Mi Perfil
                                    </a>
                                </li>
                                <li><hr class="dropdown-divider my-1"></li>
                                <li>
                                    <a class="dropdown-item d-flex align-items-center gap-2 py-2 text-danger fw-semibold" href="WebForm2.aspx">
                                        <span>🔐</span> Panel de Administración
                                    </a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container my-5">
            <div class="tab-content">

                <!-- SECCIÓN: INICIO -->
                <div id="inicio" class="tab-pane fade show active">
                    <div class="p-4 mb-5 bg-white rounded shadow-sm text-center border-bottom border-danger border-3">
                        <h1 class="display-5 text-danger fw-bold mb-3">Bienvenidos a Pollolandia</h1>
                        <p class="lead text-muted mb-4">El pollo más crujiente, jugoso y con el sabor tradicional que tanto te gusta.</p>
                        <button type="button" class="btn btn-rojo btn-lg px-5 py-2 shadow-sm" onclick="var triggerEl = document.querySelector('a[href=\'#menu\']'); var tab = bootstrap.Tab.getOrCreateInstance(triggerEl); tab.show();">Ver Menú</button>
                    </div>

                    <div id="carouselPollolandia" class="carousel slide shadow rounded overflow-hidden mb-5" data-bs-ride="carousel" data-bs-interval="3000">
                        <div class="carousel-indicators">
                            <button type="button" data-bs-target="#carouselPollolandia" data-bs-slide-to="0" class="active"></button>
                            <button type="button" data-bs-target="#carouselPollolandia" data-bs-slide-to="1"></button>
                            <button type="button" data-bs-target="#carouselPollolandia" data-bs-slide-to="2"></button>
                            <button type="button" data-bs-target="#carouselPollolandia" data-bs-slide-to="3"></button>
                        </div>
                        <div class="carousel-inner">
                            <div class="carousel-item active">
                                <img src="pollo chuco.jfif" class="d-block w-100" alt="Pollo Chuco">
                            </div>
                            <div class="carousel-item">
                                <img src="pollo con papa 1.jfif" class="d-block w-100" alt="Pollo con Papa">
                            </div>
                            <div class="carousel-item">
                                <img src="pllo asado entero.jfif" class="d-block w-100" alt="Pollo Asado Entero">
                            </div>
                            <div class="carousel-item">
                                <img src="pollo frito entero.jfif" class="d-block w-100" alt="Pollo Frito Entero">
                            </div>
                        </div>
                        <button class="carousel-control-prev" type="button" data-bs-target="#carouselPollolandia" data-bs-slide="prev">
                            <span class="carousel-control-prev-icon"></span>
                        </button>
                        <button class="carousel-control-next" type="button" data-bs-target="#carouselPollolandia" data-bs-slide="next">
                            <span class="carousel-control-next-icon"></span>
                        </button>
                    </div>
                </div>

                <!-- SECCIÓN: MENÚ PRINCIPAL -->
                <div id="menu" class="tab-pane fade">
                    <section class="mb-5">
                        <h2 class="text-center mb-4 fw-bold text-dark">Especialidades de Pollo</h2>
                        <div class="row g-4">
                            <!-- Pollo Chuco Tradicional -->
                            <div class="col-md-4">
                                <div class="card h-100 shadow-sm border text-center">
                                    <div class="card-header-pollolandia py-2">Pollo con Tajadas</div>
                                    <img src="pollo chuco.jfif" class="card-img-top p-2" alt="Pollo Chuco" style="height: 180px; object-fit: cover;" />
                                    <div class="card-body d-flex flex-column justify-content-between">
                                        <p class="card-text text-muted">Deliciosas tajadas de banano verde fritas con pollo y chimol de la casa.</p>
                                        <div>
                                            <h4 class="text-danger fw-bold mb-3">L. 135.00</h4>
                                            <div class="input-group mb-2">
                                                <span class="input-group-text bg-light fw-bold">Cant.</span>
                                                <asp:TextBox ID="txtCantMenu2" runat="server" TextMode="Number" CssClass="form-control text-center" Text="0" min="0" max="999"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Pollo Chuco Especial 1 -->
                            <div class="col-md-4">
                                <div class="card h-100 shadow-sm border text-center">
                                    <div class="card-header-pollolandia py-2">Pollo Chuco Especial</div>
                                    <img src="pllo chuco 1.jfif" class="card-img-top p-2" alt="Pollo Chuco 1" style="height: 180px; object-fit: cover;" />
                                    <div class="card-body d-flex flex-column justify-content-between">
                                        <p class="card-text text-muted">Pieza de pollo doradita acompañada con abundante ensalada y tajadas.</p>
                                        <div>
                                            <h4 class="text-danger fw-bold mb-3">L. 140.00</h4>
                                            <div class="input-group mb-2">
                                                <span class="input-group-text bg-light fw-bold">Cant.</span>
                                                <asp:TextBox ID="txtCantPolloChuco1" runat="server" TextMode="Number" CssClass="form-control text-center" Text="0" min="0" max="999"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Pollo Chuco Dúo -->
                            <div class="col-md-4">
                                <div class="card h-100 shadow-sm border text-center">
                                    <div class="card-header-pollolandia py-2">Pollo Chuco Dúo</div>
                                    <img src="pollo chuco 2.jfif" class="card-img-top p-2" alt="Pollo Chuco 2" style="height: 180px; object-fit: cover;" />
                                    <div class="card-body d-flex flex-column justify-content-between">
                                        <p class="card-text text-muted">Dos piezas de pollo frito crocante servidas con tajadas crujientes.</p>
                                        <div>
                                            <h4 class="text-danger fw-bold mb-3">L. 175.00</h4>
                                            <div class="input-group mb-2">
                                                <span class="input-group-text bg-light fw-bold">Cant.</span>
                                                <asp:TextBox ID="txtCantPolloChuco2" runat="server" TextMode="Number" CssClass="form-control text-center" Text="0" min="0" max="999"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Combo Familiar Chuco -->
                            <div class="col-md-4">
                                <div class="card h-100 shadow-sm border text-center">
                                    <div class="card-header-pollolandia py-2">Combo Familiar Chuco</div>
                                    <img src="pollo chuco 3.jfif" class="card-img-top p-2" alt="Combo Familiar" style="height: 180px; object-fit: cover;" />
                                    <div class="card-body d-flex flex-column justify-content-between">
                                        <p class="card-text text-muted">Banquete para compartir: múltiples piezas de pollo frito, tajadas y aderezos.</p>
                                        <div>
                                            <h4 class="text-danger fw-bold mb-3">L. 320.00</h4>
                                            <div class="input-group mb-2">
                                                <span class="input-group-text bg-light fw-bold">Cant.</span>
                                                <asp:TextBox ID="txtCantMenu11" runat="server" TextMode="Number" CssClass="form-control text-center" Text="0" min="0" max="999"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Combo Pollo con Papas 1 -->
                            <div class="col-md-4">
                                <div class="card h-100 shadow-sm border text-center">
                                    <div class="card-header-pollolandia py-2">Combo Pollo con Papas</div>
                                    <img src="pollo con papa 1.jfif" class="card-img-top p-2" alt="Pollo con Papas 1" style="height: 180px; object-fit: cover;" />
                                    <div class="card-body d-flex flex-column justify-content-between">
                                        <p class="card-text text-muted">Piezas de pollo frito crujiente acompañadas de papas fritas saladas.</p>
                                        <div>
                                            <h4 class="text-danger fw-bold mb-3">L. 120.00</h4>
                                            <div class="input-group mb-2">
                                                <span class="input-group-text bg-light fw-bold">Cant.</span>
                                                <asp:TextBox ID="txtCantMenu1" runat="server" TextMode="Number" CssClass="form-control text-center" Text="0" min="0" max="999"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Combo Pollo con Papas 2 -->
                            <div class="col-md-4">
                                <div class="card h-100 shadow-sm border text-center">
                                    <div class="card-header-pollolandia py-2">Combo Pollo con Papas Dúo</div>
                                    <img src="pollo con papas 2.jfif" class="card-img-top p-2" alt="Pollo con Papas 2" style="height: 180px; object-fit: cover;" />
                                    <div class="card-body d-flex flex-column justify-content-between">
                                        <p class="card-text text-muted">Combo doble con crujientes papas doradas y piezas seleccionadas.</p>
                                        <div>
                                            <h4 class="text-danger fw-bold mb-3">L. 165.00</h4>
                                            <div class="input-group mb-2">
                                                <span class="input-group-text bg-light fw-bold">Cant.</span>
                                                <asp:TextBox ID="txtCantPolloPapas2" runat="server" TextMode="Number" CssClass="form-control text-center" Text="0" min="0" max="999"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Pollo con Papas Especial 3 -->
                            <div class="col-md-4">
                                <div class="card h-100 shadow-sm border text-center">
                                    <div class="card-header-pollolandia py-2">Pollo con Papas Especial</div>
                                    <img src="pollo con papa 3.jfif" class="card-img-top p-2" alt="Pollo con Papa 3" style="height: 180px; object-fit: cover;" />
                                    <div class="card-body d-flex flex-column justify-content-between">
                                        <p class="card-text text-muted">Porción personal con papas sazonadas y salsas a elección.</p>
                                        <div>
                                            <h4 class="text-danger fw-bold mb-3">L. 130.00</h4>
                                            <div class="input-group mb-2">
                                                <span class="input-group-text bg-light fw-bold">Cant.</span>
                                                <asp:TextBox ID="txtCantPolloPapa3" runat="server" TextMode="Number" CssClass="form-control text-center" Text="0" min="0" max="999"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Pollo con Papas Extra 4 -->
                            <div class="col-md-4">
                                <div class="card h-100 shadow-sm border text-center">
                                    <div class="card-header-pollolandia py-2">Pollo con Papas Maxi</div>
                                    <img src="pollo com papa 4.jfif" class="card-img-top p-2" alt="Pollo con Papa 4" style="height: 180px; object-fit: cover;" />
                                    <div class="card-body d-flex flex-column justify-content-between">
                                        <p class="card-text text-muted">Generosa porción de papas amarillas fritas con pollo crujiente.</p>
                                        <div>
                                            <h4 class="text-danger fw-bold mb-3">L. 150.00</h4>
                                            <div class="input-group mb-2">
                                                <span class="input-group-text bg-light fw-bold">Cant.</span>
                                                <asp:TextBox ID="txtCantPolloPapa4" runat="server" TextMode="Number" CssClass="form-control text-center" Text="0" min="0" max="999"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Pollo con Papas Tradicional -->
                            <div class="col-md-4">
                                <div class="card h-100 shadow-sm border text-center">
                                    <div class="card-header-pollolandia py-2">Pollo con Papas Clasico</div>
                                    <img src="pollo con papa.jfif" class="card-img-top p-2" alt="Pollo con Papa Clásico" style="height: 180px; object-fit: cover;" />
                                    <div class="card-body d-flex flex-column justify-content-between">
                                        <p class="card-text text-muted">El sabor tradicional de siempre en combo individual.</p>
                                        <div>
                                            <h4 class="text-danger fw-bold mb-3">L. 115.00</h4>
                                            <div class="input-group mb-2">
                                                <span class="input-group-text bg-light fw-bold">Cant.</span>
                                                <asp:TextBox ID="txtCantPolloPapaClasico" runat="server" TextMode="Number" CssClass="form-control text-center" Text="0" min="0" max="999"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Pollo Asado Entero -->
                            <div class="col-md-4">
                                <div class="card h-100 shadow-sm border text-center">
                                    <div class="card-header-pollolandia py-2">Pollo Asado Entero</div>
                                    <img src="pllo asado entero.jfif" class="card-img-top p-2" alt="Pollo Asado Entero" style="height: 180px; object-fit: cover;" />
                                    <div class="card-body d-flex flex-column justify-content-between">
                                        <p class="card-text text-muted">Pollo entero asado a la parrilla con especias de la casa.</p>
                                        <div>
                                            <h4 class="text-danger fw-bold mb-3">L. 260.00</h4>
                                            <div class="input-group mb-2">
                                                <span class="input-group-text bg-light fw-bold">Cant.</span>
                                                <asp:TextBox ID="txtCantPolloAsadoEntero" runat="server" TextMode="Number" CssClass="form-control text-center" Text="0" min="0" max="999"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Pollo Asado en Pedazos -->
                            <div class="col-md-4">
                                <div class="card h-100 shadow-sm border text-center">
                                    <div class="card-header-pollolandia py-2">Pollo Asado en Pedazos</div>
                                    <img src="pollo asado en pedasos.jfif" class="card-img-top p-2" alt="Pollo Asado en Pedazos" style="height: 180px; object-fit: cover;" />
                                    <div class="card-body d-flex flex-column justify-content-between">
                                        <p class="card-text text-muted">Porciones de pollo asado cortado en piezas individuales listo para disfrutar.</p>
                                        <div>
                                            <h4 class="text-danger fw-bold mb-3">L. 145.00</h4>
                                            <div class="input-group mb-2">
                                                <span class="input-group-text bg-light fw-bold">Cant.</span>
                                                <asp:TextBox ID="txtCantPolloAsadoPedazos" runat="server" TextMode="Number" CssClass="form-control text-center" Text="0" min="0" max="999"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Pollo Frito Entero -->
                            <div class="col-md-4">
                                <div class="card h-100 shadow-sm border text-center">
                                    <div class="card-header-pollolandia py-2">Pollo Frito Entero</div>
                                    <img src="pollo frito entero.jfif" class="card-img-top p-2" alt="Pollo Frito Entero" style="height: 180px; object-fit: cover;" />
                                    <div class="card-body d-flex flex-column justify-content-between">
                                        <p class="card-text text-muted">Pollo entero empanizado y frito, perfecto para compartir en familia.</p>
                                        <div>
                                            <h4 class="text-danger fw-bold mb-3">L. 270.00</h4>
                                            <div class="input-group mb-2">
                                                <span class="input-group-text bg-light fw-bold">Cant.</span>
                                                <asp:TextBox ID="txtCantPolloFritoEntero" runat="server" TextMode="Number" CssClass="form-control text-center" Text="0" min="0" max="999"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Pollo Frito en Pedazos -->
                            <div class="col-md-4">
                                <div class="card h-100 shadow-sm border text-center">
                                    <div class="card-header-pollolandia py-2">Pollo Frito en Pedazos</div>
                                    <img src="pollo frito en pedazos.jfif" class="card-img-top p-2" alt="Pollo Frito en Pedazos" style="height: 180px; object-fit: cover;" />
                                    <div class="card-body d-flex flex-column justify-content-between">
                                        <p class="card-text text-muted">Piezas sueltas de pollo frito super crujiente.</p>
                                        <div>
                                            <h4 class="text-danger fw-bold mb-3">L. 135.00</h4>
                                            <div class="input-group mb-2">
                                                <span class="input-group-text bg-light fw-bold">Cant.</span>
                                                <asp:TextBox ID="txtCantPolloFritoPedazos" runat="server" TextMode="Number" CssClass="form-control text-center" Text="0" min="0" max="999"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>

                <!-- SECCIÓN: REFRESCOS -->
                <div id="extras" class="tab-pane fade">
                    <section class="mb-5">
                        <h2 class="text-center mb-4 fw-bold text-dark">Refrescos y Bebidas</h2>
                        <div class="row g-4">
                            <div class="col-md-4">
                                <div class="card h-100 shadow-sm border text-center">
                                    <div class="card-header-pollolandia py-2">Refresco Sprite</div>
                                    <img src="fresco .jpeg" class="card-img-top p-2" alt="Refresco Sprite" style="height: 180px; object-fit: contain;" />
                                    <div class="card-body d-flex flex-column justify-content-between">
                                        <div>
                                            <h4 class="text-danger fw-bold mb-3">L. 25.00</h4>
                                            <div class="input-group mb-2">
                                                <span class="input-group-text bg-light fw-bold">Cant.</span>
                                                <asp:TextBox ID="txtCantSprite" runat="server" TextMode="Number" CssClass="form-control text-center" Text="0" min="0" max="999"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="card h-100 shadow-sm border text-center">
                                    <div class="card-header-pollolandia py-2">Té Frío Lipton</div>
                                    <img src="fresco 1.jpeg" class="card-img-top p-2" alt="Té Lipton" style="height: 180px; object-fit: contain;" />
                                    <div class="card-body d-flex flex-column justify-content-between">
                                        <div>
                                            <h4 class="text-danger fw-bold mb-3">L. 30.00</h4>
                                            <div class="input-group mb-2">
                                                <span class="input-group-text bg-light fw-bold">Cant.</span>
                                                <asp:TextBox ID="txtCantLipton" runat="server" TextMode="Number" CssClass="form-control text-center" Text="0" min="0" max="999"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="card h-100 shadow-sm border text-center">
                                    <div class="card-header-pollolandia py-2">Refresco Coca Cola</div>
                                    <img src="fresco 2.jpeg" class="card-img-top p-2" alt="Refresco 2" style="height: 180px; object-fit: contain;" />
                                    <div class="card-body d-flex flex-column justify-content-between">
                                        <div>
                                            <h4 class="text-danger fw-bold mb-3">L. 25.00</h4>
                                            <div class="input-group mb-2">
                                                <span class="input-group-text bg-light fw-bold">Cant.</span>
                                                <asp:TextBox ID="txtCantFresco2" runat="server" TextMode="Number" CssClass="form-control text-center" Text="0" min="0" max="999"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="card h-100 shadow-sm border text-center">
                                    <div class="card-header-pollolandia py-2">Bebida Sabor Naranja</div>
                                    <img src="fresco 3.jpeg" class="card-img-top p-2" alt="Refresco 3" style="height: 180px; object-fit: contain;" />
                                    <div class="card-body d-flex flex-column justify-content-between">
                                        <div>
                                            <h4 class="text-danger fw-bold mb-3">L. 25.00</h4>
                                            <div class="input-group mb-2">
                                                <span class="input-group-text bg-light fw-bold">Cant.</span>
                                                <asp:TextBox ID="txtCantFresco3" runat="server" TextMode="Number" CssClass="form-control text-center" Text="0" min="0" max="999"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="card h-100 shadow-sm border text-center">
                                    <div class="card-header-pollolandia py-2">Jugo Embotellado</div>
                                    <img src="fresco 4.jpeg" class="card-img-top p-2" alt="Refresco 4" style="height: 180px; object-fit: contain;" />
                                    <div class="card-body d-flex flex-column justify-content-between">
                                        <div>
                                            <h4 class="text-danger fw-bold mb-3">L. 28.00</h4>
                                            <div class="input-group mb-2">
                                                <span class="input-group-text bg-light fw-bold">Cant.</span>
                                                <asp:TextBox ID="txtCantFresco4" runat="server" TextMode="Number" CssClass="form-control text-center" Text="0" min="0" max="999"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="card h-100 shadow-sm border text-center">
                                    <div class="card-header-pollolandia py-2">Agua Embotellada</div>
                                    <img src="fresco 5.jpeg" class="card-img-top p-2" alt="Refresco 5" style="height: 180px; object-fit: contain;" />
                                    <div class="card-body d-flex flex-column justify-content-between">
                                        <div>
                                            <h4 class="text-danger fw-bold mb-3">L. 20.00</h4>
                                            <div class="input-group mb-2">
                                                <span class="input-group-text bg-light fw-bold">Cant.</span>
                                                <asp:TextBox ID="txtCantFresco5" runat="server" TextMode="Number" CssClass="form-control text-center" Text="0" min="0" max="999"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>

                <!-- SECCIÓN: ENTRADAS -->
                <div id="postres" class="tab-pane fade">
                    <section class="mb-5">
                        <h2 class="text-center mb-4 fw-bold text-dark">Entradas</h2>
                        <div class="row g-4">
                            <!-- Postre General -->
                            <div class="col-md-3">
                                <div class="card h-100 shadow-sm border text-center">
                                    <div class="card-header-pollolandia py-2">Postre de la Casa</div>
                                    <img src="postre.jpeg" class="card-img-top p-2" style="height: 150px; object-fit: cover;" alt="Postre de la Casa" />
                                    <div class="card-body d-flex flex-column justify-content-between">
                                        <h5 class="text-danger fw-bold mb-2">L. 45.00</h5>
                                        <div class="input-group mb-2">
                                            <span class="input-group-text bg-light fw-bold">Cant.</span>
                                            <asp:TextBox ID="txtCantPostreBase" runat="server" TextMode="Number" CssClass="form-control text-center" Text="0" min="0" max="999"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- Papas Sonrientes -->
                            <div class="col-md-3">
                                <div class="card h-100 shadow-sm border text-center">
                                    <div class="card-header-pollolandia py-2">Papas Sonrientes</div>
                                    <img src="postre 1.jpeg" class="card-img-top p-2" style="height: 150px; object-fit: cover;" alt="Papas Sonrientes" />
                                    <div class="card-body d-flex flex-column justify-content-between">
                                        <h5 class="text-danger fw-bold mb-2">L. 35.00</h5>
                                        <div class="input-group mb-2">
                                            <span class="input-group-text bg-light fw-bold">Cant.</span>
                                            <asp:TextBox ID="txtCantPapasSonrientes" runat="server" TextMode="Number" CssClass="form-control text-center" Text="0" min="0" max="999"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- Postre 2 -->
                            <div class="col-md-3">
                                <div class="card h-100 shadow-sm border text-center">
                                    <div class="card-header-pollolandia py-2">Bolitas de pollo</div>
                                    <img src="postre 2.jpeg" class="card-img-top p-2" style="height: 150px; object-fit: cover;" alt="Postre 2" />
                                    <div class="card-body d-flex flex-column justify-content-between">
                                        <h5 class="text-danger fw-bold mb-2">L. 40.00</h5>
                                        <div class="input-group mb-2">
                                            <span class="input-group-text bg-light fw-bold">Cant.</span>
                                            <asp:TextBox ID="txtCantPostre2" runat="server" TextMode="Number" CssClass="form-control text-center" Text="0" min="0" max="999"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- Postre 3 -->
                            <div class="col-md-3">
                                <div class="card h-100 shadow-sm border text-center">
                                    <div class="card-header-pollolandia py-2">aros de sebolla </div>
                                    <img src="postre 3.jpeg" class="card-img-top p-2" style="height: 150px; object-fit: cover;" alt="Postre 3" />
                                    <div class="card-body d-flex flex-column justify-content-between">
                                        <h5 class="text-danger fw-bold mb-2">L. 50.00</h5>
                                        <div class="input-group mb-2">
                                            <span class="input-group-text bg-light fw-bold">Cant.</span>
                                            <asp:TextBox ID="txtCantPostre3" runat="server" TextMode="Number" CssClass="form-control text-center" Text="0" min="0" max="999"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- Postre 4 -->
                            <div class="col-md-3">
                                <div class="card h-100 shadow-sm border text-center">
                                    <div class="card-header-pollolandia py-2">tiras de pollo</div>
                                    <img src="postre 4.jpeg" class="card-img-top p-2" style="height: 150px; object-fit: cover;" alt="Postre 4" />
                                    <div class="card-body d-flex flex-column justify-content-between">
                                        <h5 class="text-danger fw-bold mb-2">L. 30.00</h5>
                                        <div class="input-group mb-2">
                                            <span class="input-group-text bg-light fw-bold">Cant.</span>
                                            <asp:TextBox ID="txtCantPostre4" runat="server" TextMode="Number" CssClass="form-control text-center" Text="0" min="0" max="999"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- Postre 5 -->
                            <div class="col-md-3">
                                <div class="card h-100 shadow-sm border text-center">
                                    <div class="card-header-pollolandia py-2">sandwich de pollo</div>
                                    <img src="postre 5.jpeg" class="card-img-top p-2" style="height: 150px; object-fit: cover;" alt="Postre 5" />
                                    <div class="card-body d-flex flex-column justify-content-between">
                                        <h5 class="text-danger fw-bold mb-2">L. 35.00</h5>
                                        <div class="input-group mb-2">
                                            <span class="input-group-text bg-light fw-bold">Cant.</span>
                                            <asp:TextBox ID="txtCantPostre5" runat="server" TextMode="Number" CssClass="form-control text-center" Text="0" min="0" max="999"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- Postre 6 -->
                            <div class="col-md-3">
                                <div class="card h-100 shadow-sm border text-center">
                                    <div class="card-header-pollolandia py-2">gorditos de pollo</div>
                                    <img src="postre 6.jpeg" class="card-img-top p-2" style="height: 150px; object-fit: cover;" alt="Postre 6" />
                                    <div class="card-body d-flex flex-column justify-content-between">
                                        <h5 class="text-danger fw-bold mb-2">L. 55.00</h5>
                                        <div class="input-group mb-2">
                                            <span class="input-group-text bg-light fw-bold">Cant.</span>
                                            <asp:TextBox ID="txtCantPostre6" runat="server" TextMode="Number" CssClass="form-control text-center" Text="0" min="0" max="999"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- Postre 7 -->
                            <div class="col-md-3">
                                <div class="card h-100 shadow-sm border text-center">
                                    <div class="card-header-pollolandia py-2">Empanadas de pollo</div>
                                    <img src="postre 7.jpeg" class="card-img-top p-2" style="height: 150px; object-fit: cover;" alt="Postre 7" />
                                    <div class="card-body d-flex flex-column justify-content-between">
                                        <h5 class="text-danger fw-bold mb-2">L. 25.00</h5>
                                        <div class="input-group mb-2">
                                            <span class="input-group-text bg-light fw-bold">Cant.</span>
                                            <asp:TextBox ID="txtCantPostre7" runat="server" TextMode="Number" CssClass="form-control text-center" Text="0" min="0" max="999"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>

                <!-- SECCIÓN: SALSAS Y ACOMPAÑANTES -->
                <div id="salsas" class="tab-pane fade">
                    <section class="mb-5">
                        <h2 class="text-center mb-4 fw-bold text-dark">Salsas y Acompañantes</h2>
                        <div class="row g-4">
                            <!-- Ensalada -->
                            <div class="col-md-6">
                                <div class="card h-100 shadow-sm border text-center">
                                    <div class="card-header-pollolandia py-2">Ensalada Fresca</div>
                                    <img src="ensalada.jfif" class="card-img-top p-2" style="height: 180px; object-fit: cover;" alt="Ensalada Fresca" />
                                    <div class="p-3">
                                        <h5 class="text-danger fw-bold mb-3">L. 30.00</h5>
                                        <div class="input-group mb-2">
                                            <span class="input-group-text bg-light fw-bold">Cant.</span>
                                            <asp:TextBox ID="txtCantEnsalada" runat="server" TextMode="Number" CssClass="form-control text-center" Text="0" min="0" max="999"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Puré de Papa -->
                            <div class="col-md-6">
                                <div class="card h-100 shadow-sm border text-center">
                                    <div class="card-header-pollolandia py-2">Puré de Papa Cremoso</div>
                                    <img src="pure.jfif" class="card-img-top p-2" style="height: 180px; object-fit: cover;" alt="Puré de Papa" />
                                    <div class="p-3">
                                        <h5 class="text-danger fw-bold mb-3">L. 35.00</h5>
                                        <div class="input-group mb-2">
                                            <span class="input-group-text bg-light fw-bold">Cant.</span>
                                            <asp:TextBox ID="txtCantPure" runat="server" TextMode="Number" CssClass="form-control text-center" Text="0" min="0" max="999"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Aderezo de la Casa -->
                            <div class="col-md-6">
                                <div class="card h-100 shadow-sm border text-center">
                                    <div class="card-header-pollolandia py-2">Aderezo Blanco de la Casa</div>
                                    <img src="aderezo.jfif" class="card-img-top p-2" style="height: 180px; object-fit: cover;" alt="Aderezo" />
                                    <div class="p-3">
                                        <h5 class="text-danger fw-bold mb-3">L. 15.00</h5>
                                        <div class="input-group mb-2">
                                            <span class="input-group-text bg-light fw-bold">Cant.</span>
                                            <asp:TextBox ID="txtCantAderezo" runat="server" TextMode="Number" CssClass="form-control text-center" Text="0" min="0" max="999"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Salsa Ketchup -->
                            <div class="col-md-6">
                                <div class="card h-100 shadow-sm border text-center">
                                    <div class="card-header-pollolandia py-2">Salsa Ketchup Especial</div>
                                    <img src="images ketchup.jfif" class="card-img-top p-2" style="height: 180px; object-fit: cover;" alt="Salsa Ketchup" />
                                    <div class="p-3">
                                        <h5 class="text-danger fw-bold mb-3">L. 10.00</h5>
                                        <div class="input-group mb-2">
                                            <span class="input-group-text bg-light fw-bold">Cant.</span>
                                            <asp:TextBox ID="txtCantKetchup" runat="server" TextMode="Number" CssClass="form-control text-center" Text="0" min="0" max="999"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>

                <!-- SECCIÓN: LOCALES -->
                <div id="locales" class="tab-pane fade">
                    <section class="mb-5">
                        <h2 class="text-center mb-4 fw-bold text-dark">Nuestros Locales</h2>
                        <div class="row g-4 text-center">
                            <div class="col-md-4">
                                <div class="card p-3 shadow-sm">
                                    <img src="images de el locla de tegus.jfif" class="card-img-top p-1 mb-2 rounded" style="height: 180px; object-fit: cover;" alt="Tegucigalpa" />
                                    <h5 class="text-danger fw-bold">Tegucigalpa</h5>
                                    <p class="text-muted small">Sucursal Principal</p>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="card p-3 shadow-sm">
                                    <img src="images de sampedro.jfif" class="card-img-top p-1 mb-2 rounded" style="height: 180px; object-fit: cover;" alt="San Pedro Sula" />
                                    <h5 class="text-danger fw-bold">San Pedro Sula</h5>
                                    <p class="text-muted small">Sucursal San Pedro</p>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="card p-3 shadow-sm">
                                    <img src="images de progreso.jfif" class="card-img-top p-1 mb-2 rounded" style="height: 180px; object-fit: cover;" alt="El Progreso" />
                                    <h5 class="text-danger fw-bold">El Progreso</h5>
                                    <p class="text-muted small">Sucursal Progreso</p>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>

                <!-- SECCIÓN: INICIAR SESIÓN -->
                <div id="cuenta" class="tab-pane fade">
                    <section class="card shadow-sm border-0 my-4 max-w-500 mx-auto">
                        <div class="card-header bg-danger text-white py-3 text-center">
                            <h3 class="mb-0 fw-bold fs-4">Acceso de Cliente</h3>
                        </div>
                        <div class="card-body p-4">
                            <div id="alertaSesionRequerida" class="alert alert-warning text-center d-none" role="alert">
                                <strong>¡Atención!</strong> Debes iniciar sesión para procesar un pedido.
                            </div>
                            <div class="mb-3">
                                <label class="form-label fw-semibold">Correo Electrónico:</label>
                                <asp:TextBox ID="txtLoginCorreo" runat="server" CssClass="form-control" placeholder="ejemplo@correo.com"></asp:TextBox>
                            </div>
                            <div class="mb-3">
                                <label class="form-label fw-semibold">Contraseña:</label>
                                <asp:TextBox ID="txtLoginPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                            </div>
                            <button type="button" class="btn btn-rojo w-100 py-2 fw-bold shadow-sm" onclick="simularInicioSesion()">Iniciar Sesión</button>
                        </div>
                    </section>
                </div>

                <!-- SECCIÓN: MI PERFIL -->
                <div id="perfil" class="tab-pane fade">
                    <section class="card shadow-sm border-0 my-4">
                        <div class="card-header bg-danger text-white py-3">
                            <h3 class="mb-0 text-center fw-bold fs-4">Gestión de Mi Perfil</h3>
                        </div>
                        <div class="card-body p-4 p-md-5">
                            <div class="row g-4 mb-3">
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold text-secondary mb-2">Nombre Completo:</label>
                                    <asp:TextBox ID="txtPerfilNombre" runat="server" CssClass="form-control form-control-lg" placeholder="Tu nombre completo"></asp:TextBox>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold text-secondary mb-2">Correo Electrónico:</label>
                                    <asp:TextBox ID="txtPerfilCorreo" runat="server" CssClass="form-control form-control-lg" TextMode="Email" placeholder="correo@ejemplo.com"></asp:TextBox>
                                </div>
                            </div>
                            <div class="text-center mt-4">
                                <asp:Button ID="btnGuardarPerfil" runat="server" Text="Guardar Cambios" CssClass="btn btn-rojo btn-lg px-5 py-2 fw-bold" OnClick="btnGuardarPerfil_Click" />
                            </div>
                        </div>
                    </section>
                </div>

                <!-- SECCIÓN: HACER PEDIDO -->
                <div id="orden" class="tab-pane fade">
                    <section class="card p-4 mb-5 shadow-sm border">
                        <h2 class="text-center mb-4 fw-bold text-dark">Datos para tu Pedido</h2>
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label class="form-label fw-semibold">Nombre del Cliente:</label>
                                <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" placeholder="Tu nombre completo"></asp:TextBox>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label fw-semibold">Número Telefónico:</label>
                                <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" placeholder="Ej. 9988-7766"></asp:TextBox>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label fw-semibold">Dirección de Entrega:</label>
                                <asp:TextBox ID="txtDireccion" runat="server" CssClass="form-control" placeholder="Colonia, calle, casa"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold">Tipo de Entrega:</label>
                                <asp:DropDownList ID="ddlTipoEntrega" runat="server" CssClass="form-select">
                                    <asp:ListItem Text="Envío a Domicilio (Costo: L. 35.00)" Value="Domicilio" />
                                    <asp:ListItem Text="Pasar a recoger al local / Llevar (Gratis)" Value="Llevar" />
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-6 d-flex align-items-end mb-3">
                                <asp:Button ID="btnGenerarFactura" runat="server" Text="Generar Factura" CssClass="btn btn-rojo w-100 py-2 shadow-sm" OnClick="btnGenerarFactura_Click" />
                            </div>
                        </div>
                    </section>
                </div>

            </div>

            <!-- SECCIÓN: FACTURA RESULTANTE -->
            <asp:Panel ID="pnlFactura" runat="server" Visible="false" class="card border-danger p-4 mb-5 shadow bg-white">
                <div class="text-center">
                    <h2 class="text-danger fw-bold">FACTURA DE COMPRA - POLLOLANDIA</h2>
                    <p class="text-muted">¡Gracias por tu preferencia!</p>
                </div>
                <hr />
                <div class="row">
                    <div class="col-md-6">
                        <p><strong>Nombre del Cliente:</strong> <asp:Label ID="lblFacturaNombre" runat="server" /></p>
                        <p><strong>Teléfono:</strong> <asp:Label ID="lblFacturaTelefono" runat="server" /></p>
                        <p><strong>Dirección:</strong> <asp:Label ID="lblFacturaDireccion" runat="server" /></p>
                    </div>
                    <div class="col-md-6 text-md-end">
                        <p><strong>Fecha de Emisión:</strong> <asp:Label ID="lblFacturaFecha" runat="server" /></p>
                        <p><strong>Tipo de Servicio:</strong> <asp:Label ID="lblFacturaServicio" runat="server" /></p>
                    </div>
                </div>

                <hr />
                <h4 class="mb-3 fw-semibold text-dark">Resumen de Consumo:</h4>
                <asp:Literal ID="litDetalleOrden" runat="server"></asp:Literal>

                <div class="row mt-4 justify-content-end">  
                    <div class="col-md-5">
                        <table class="table table-bordered">
                            <tr>
                                <td>Subtotal:</td>
                                <td class="text-end"><asp:Label ID="lblSubtotal" runat="server" /></td>
                            </tr>
                            <tr>
                                <td>Impuesto (ISV 15%):</td>
                                <td class="text-end"><asp:Label ID="lblImpuesto" runat="server" /></td>
                            </tr>
                            <tr>
                                <td>Costo de Entrega:</td>
                                <td class="text-end"><asp:Label ID="lblCostoEntrega" runat="server" /></td>
                            </tr>
                            <tr class="table-danger fw-bold">
                                <td>TOTAL A PAGAR:</td>
                                <td class="text-end"><asp:Label ID="lblTotal" runat="server" /></td>
                            </tr>
                        </table>
                    </div>
                </div>

                <hr class="my-4" />
                <div class="d-flex justify-content-between align-items-center flex-wrap gap-2">
                    <div class="d-flex gap-2">
                        <asp:Button ID="btnModificar" runat="server" Text="Modificar" CssClass="btn btn-warning px-4 fw-semibold text-dark shadow-sm" OnClick="btnModificar_Click" />
                        <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" CssClass="btn btn-outline-danger px-4 fw-semibold shadow-sm" OnClick="btnEliminar_Click" />
                        <button type="button" class="btn btn-secondary px-4 fw-semibold shadow-sm" onclick="window.print();">Imprimir</button>
                    </div>
                    <div>
                        <asp:Button ID="btnEnvioEntregado" runat="server" Text="Envío Entregado" CssClass="btn btn-success px-4 fw-semibold shadow-sm" OnClick="btnEnvioEntregado_Click" />
                    </div>
                </div>
            </asp:Panel>

        </div>

        <!-- Bootstrap JS Bundle -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </form>
</body>
</html>