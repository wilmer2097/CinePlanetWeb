<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
        <style>
            body {
                background-color: #e6f4ea;
            }

            .sidebar {
                min-height: 100vh;
                background-color: #2e7d60;
                color: white;
            }

            .sidebar .nav-link {
                color: #cce9dd;
            }

            .sidebar .nav-link.active {
                background-color: #1b5e44;
                color: #ffffff;
            }

            .content {
                background-color: #f8fcf9;
                padding: 20px;
                min-height: 100vh;
            }

            .navbar-custom {
                background-color: #a5d6ba;
            }
        </style>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row no-gutters">
                <!-- Sidebar -->
                <div class="col-md-2 sidebar p-3">
                    <h4 class="text-white">Mi Dashboard</h4>
                    <ul class="nav flex-column mt-4">
                        <li class="nav-item">
                            <a class="nav-link" href="<%=request.getContextPath()%>/controladorAdmin?accion=dashboard">Inicio</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="<%=request.getContextPath()%>/controladorAdmin?accion=usuario">Usuario</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="<%=request.getContextPath()%>/controladorAdmin?accion=producto">Producto</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="<%=request.getContextPath()%>/controladorAdmin?accion=venta">Venta</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="logout.jsp">Cerrar Sesion</a>
                        </li>
                    </ul>
                </div>

                <!-- Contenido principal -->
                <div class="col-md-10 content">
                    <nav class="navbar navbar-expand-lg navbar-light navbar-custom mb-4">
                        <span class="navbar-brand mb-0 h1">Panel Principal</span>
                    </nav>

                    <div class="container-fluid">
                        <div class="col-md-10 content">
                            <h1 class="mb-4">Bienvenido al Dashboard</h1>

                            <!-- Estadísticas en tarjetas -->
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="card bg-primary text-white">
                                        <div class="card-body">
                                            <h5 class="card-title">Total de Usuarios</h5>
                                            <p class="card-text">120</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="card bg-success text-white">
                                        <div class="card-body">
                                            <h5 class="card-title">Ventas del Mes</h5>
                                            <p class="card-text">S/.2,500</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="card bg-warning text-white">
                                        <div class="card-body">
                                            <h5 class="card-title">Productos Vendidos</h5>
                                            <p class="card-text">500</p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Gráfico -->
                            <div class="card mb-4">
                                <div class="card-body">
                                    <h5 class="card-title">Ventas por Mes</h5>
                                    <canvas id="ventasChart" width="400" height="200"></canvas>
                                </div>
                            </div>
                            
                            </div>
                        </div>
                    </div>
                    <script>
                        var ctx = document.getElementById('ventasChart').getContext('2d');
                        var ventasChart = new Chart(ctx, {
                            type: 'line',
                            data: {
                                labels: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio'],
                                datasets: [{
                                        label: 'Ventas',
                                        data: [1200, 1500, 1100, 1800, 2000, 2200],
                                        fill: false,
                                        borderColor: 'rgba(75, 192, 192, 1)',
                                        tension: 0.1
                                    }]
                            },
                            options: {
                                scales: {
                                    y: {
                                        beginAtZero: true
                                    }
                                }
                            }
                        });
                    </script>

                    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
                    </body>
                    </html>
