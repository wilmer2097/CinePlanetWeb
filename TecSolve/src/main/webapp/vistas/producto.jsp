<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="dao.productoDao"%>
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
                            <a class="nav-link" href="./vistas/logout.jsp">Cerrar Sesion</a>
                        </li>
                    </ul>
                </div>

                <!-- Contenido principal -->
                <div class="container mt-5">
                    <h2 class="mb-4">Lista de Productos</h2>
                    <h2>${producto != null ? "Editar Producto" : "Agregar Producto"}</h2>
                    <form action="controladorAdmin" method="post">
                        <input type="hidden" name="accion" value="${producto != null ? 'actualizar' : 'agregar'}" />
                        <input type="hidden" name="idProducto" value="${producto.idProducto}">

                        <div class="row">
                            <!-- Columna izquierda -->
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="nombreProducto" class="form-label">Nombre</label>
                                    <input type="text" name="nombreProducto" class="form-control" value="${producto.nombreProducto}" required>
                                </div>

                                <div class="mb-3">
                                    <label for="descripcion" class="form-label">Descripción</label>
                                    <textarea name="descripcion" class="form-control" rows="3" required>${producto.descripcion}</textarea>
                                </div>

                                <div class="mb-3">
                                    <label for="precio" class="form-label">Precio</label>
                                    <input type="number" step="0.01" name="precio" class="form-control" value="${producto.precio}" required>
                                </div>
                            </div>

                            <!-- Columna derecha -->
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="stock" class="form-label">Stock</label>
                                    <input type="number" name="stock" class="form-control" value="${producto.stock}" required>
                                </div>

                                <div class="mb-3">
                                    <label for="categoriaId" class="form-label">Categoría</label>
                                    <select id="categoria" name="idCategoria">
                                        <c:forEach var="itemCategoria" items="${listaCategoria}">
                                            <option value="${itemCategoria.idCategoria}">
                                                ${itemCategoria.nombreCategoria} <!-- Asumo que se muestra el nombre, ajusta según tu modelo -->
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="text-end">
                            <button type="submit" class="btn btn-primary">${producto != null ? "Actualizar" : "Guardar"}</button>
                        </div>
                    </form>
                    <br>
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered">
                            <thead class="thead-dark">
                                <tr>
                                    <th>Id</th>
                                    <th>Categoria</th>
                                    <th>Producto</th>
                                    <th>Descripcion</th>
                                    <th>Precio</th>
                                    <th>Stock</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="producto" items="${listaProd}">
                                    <tr>
                                        <td>${producto.idProducto}</td>
                                        <td>${producto.categoria}</td>
                                        <td>${producto.nombreProducto}</td>
                                        <td>${producto.descripcion}</td>
                                        <td>${producto.precio}</td>
                                        <td>${producto.stock}</td>
                                        <td class="accion">
                                            <a href="<%=request.getContextPath()%>/controladorAdmin?accion=editarProducto&id=${producto.idProducto}" class="btn btn-primary">Editar</a>
                                            <a href="controladorAdmin?accion=borrarProducto&id=${producto.idProducto}" 
                                               class="btn btn-danger btn-sm"
                                               onclick="return confirm('¿Estás seguro de eliminar este producto?');">
                                                Eliminar
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
                    </body>
                    </html>
