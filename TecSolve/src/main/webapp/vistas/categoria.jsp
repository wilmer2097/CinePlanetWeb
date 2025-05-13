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
                    </ul>
                </div>

                <!-- Contenido principal -->


                <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
                </body>
                </html>
