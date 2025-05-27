<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>CineReserva - Mi Cuenta</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/resources/perfil.css" />
        <style>
            .management-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                gap: 20px;
                margin-top: 20px;
            }

            .management-card {
                background: #fff;
                border: 1px solid #e0e0e0;
                border-radius: 8px;
                padding: 20px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                transition: box-shadow 0.3s ease;
            }

            .management-card:hover {
                box-shadow: 0 4px 8px rgba(0,0,0,0.15);
            }

            .card-header {
                display: flex;
                justify-content: between;
                align-items: center;
                margin-bottom: 15px;
            }

            .card-title {
                font-size: 18px;
                font-weight: 600;
                color: #333;
                margin: 0;
            }

            .crud-badge {
                background: #4CAF50;
                color: white;
                padding: 4px 8px;
                border-radius: 4px;
                font-size: 12px;
                font-weight: 500;
            }

            .card-description {
                color: #666;
                margin-bottom: 20px;
                line-height: 1.5;
            }

            .card-actions {
                display: flex;
                gap: 10px;
            }

            .btn-manage {
                background: #2c3e50;
                color: white;
                padding: 8px 16px;
                border: none;
                border-radius: 4px;
                text-decoration: none;
                font-size: 14px;
                cursor: pointer;
                transition: background 0.3s ease;
            }

            .btn-manage:hover {
                background: #34495e;
            }

            .btn-new {
                background: #4CAF50;
                color: white;
                padding: 8px 16px;
                border: none;
                border-radius: 4px;
                text-decoration: none;
                font-size: 14px;
                cursor: pointer;
                transition: background 0.3s ease;
            }

            .btn-new:hover {
                background: #45a049;
            }

            .btn-special {
                background: #6c7b7f;
                color: white;
                padding: 8px 16px;
                border: none;
                border-radius: 4px;
                text-decoration: none;
                font-size: 14px;
                cursor: pointer;
                transition: background 0.3s ease;
            }

            .btn-special:hover {
                background: #5a6b70;
            }

            .btn-reports {
                background: #3498db;
                color: white;
                padding: 8px 16px;
                border: none;
                border-radius: 4px;
                text-decoration: none;
                font-size: 14px;
                cursor: pointer;
                transition: background 0.3s ease;
            }

            .btn-reports:hover {
                background: #2980b9;
            }
            .modal-superxl {
                max-width: 95% !important; /* o 90% si quieres un poco más pequeño */
            }

        </style>
    </head>
    <body>
        <header>
            <nav class="navbar">
                <div class="logo">
                    <a href="${pageContext.request.contextPath}/cartelera">CineReserva</a>
                </div>
                <div class="nav-links">
                    <a href="${pageContext.request.contextPath}/cartelera" class="nav-link">Cartelera</a>
                    <a href="${pageContext.request.contextPath}/proximos" class="nav-link">Próximos Estrenos</a>
                    <a href="${pageContext.request.contextPath}/cines" class="nav-link">Cines</a>
                    <a href="${pageContext.request.contextPath}/promociones" class="nav-link">Promociones</a>
                </div>
                <div class="user-actions">
                    <form action="${pageContext.request.contextPath}/buscar" method="get" class="search-box">
                        <input type="text" name="q" placeholder="Buscar películas...">
                    </form>
                    <a href="${pageContext.request.contextPath}/profile" class="btn btn-primary">Mi Cuenta</a>
                </div>
            </nav>
        </header>

        <main>
            <h1 class="page-title">Mi Cuenta</h1>

            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="alert alert-success">${success}</div>
            </c:if>

            <div class="profile-container">
                <div class="sidebar">
                    <div class="profile-avatar">
                        ${fn:substring(usuario.nombre,0,1)}
                    </div>
                    <h2 class="user-name"><c:out value="${usuario.nombre}"/></h2>
                    <p class="user-email"><c:out value="${usuario.email}"/></p>
                    <!-- tu menú lateral -->
                </div>

                <div class="content-area">
                    <div class="tab-container">
                        <div class="tabs">
                            <div class="tab active">Perfil</div>
                            <div class="tab">Reservas</div>
                            <div class="tab">Estadísticas</div>
                            <div class="tab">Gestión</div>
                        </div>

                        <!-- Tab Content: Perfil -->
                        <div class="tab-content active">
                            <h2 class="section-title">Información Personal</h2>
                            <form action="${pageContext.request.contextPath}/profile" method="post">
                                <input type="hidden" name="id" value="${usuario.id}" />

                                <div class="form-row">
                                    <div class="form-group">
                                        <label for="nombre">Nombre</label>
                                        <input type="text" id="nombre" name="nombre" class="form-control"
                                               value="<c:out value='${usuario.nombre}'/>" required />
                                    </div>
                                    <div class="form-group">
                                        <label for="email">Email</label>
                                        <input type="email" id="email" name="email" class="form-control"
                                               value="<c:out value='${usuario.email}'/>" required />
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="form-group">
                                        <label for="telefono">Teléfono</label>
                                        <input type="tel" id="telefono" name="telefono" class="form-control"
                                               value="<c:out value='${usuario.telefono}'/>" />
                                    </div>
                                    <div class="form-group">
                                        <label for="fecha_reg">Fecha de Registro</label>
                                        <input type="text" id="fecha_reg" class="form-control" disabled
                                               value="<fmt:formatDate value='${usuario.fechaReg}' pattern='dd/MM/yyyy'/>" />
                                    </div>
                                </div>

                                <div class="password-section">
                                    <h3 class="section-title">Cambiar Contraseña</h3>
                                    <div class="form-group">
                                        <label for="current_password">Contraseña Actual</label>
                                        <input type="password" id="current_password" name="current_password"
                                               class="form-control" />
                                    </div>
                                    <div class="form-row">
                                        <div class="form-group">
                                            <label for="new_password">Nueva Contraseña</label>
                                            <input type="password" id="new_password" name="new_password"
                                                   class="form-control" />
                                        </div>
                                        <div class="form-group">
                                            <label for="confirm_password">Confirmar Contraseña</label>
                                            <input type="password" id="confirm_password" name="confirm_password"
                                                   class="form-control" />
                                        </div>
                                    </div>
                                </div>

                                <button type="submit" class="btn-save">Guardar Cambios</button>
                            </form>
                        </div>

                        <!-- Tab Content: Reservas -->
                        <div class="tab-content">
                            <h2 class="section-title">Mis Reservas</h2>
                            <p>Aquí se mostrarán las reservas del usuario...</p>
                        </div>

                        <!-- Tab Content: Estadísticas -->
                        <div class="tab-content">
                            <h2 class="section-title">Estadísticas</h2>
                            <p>Aquí se mostrarán las estadísticas del usuario...</p>
                        </div>

                        <!-- Tab Content: Gestión -->
                        <div class="tab-content">
                            <h2 class="section-title">Gestión de Contenido</h2>

                            <div class="management-grid">
                                <!-- Películas -->
                                <div class="management-card">
                                    <div class="card-header">
                                        <h3 class="card-title">Películas</h3>
                                        <span class="crud-badge">CRUD</span>
                                    </div>
                                    <p class="card-description">
                                        Administrar catálogo de películas, géneros y clasificaciones
                                    </p>
                                    <div class="card-actions">
                                        <a href="${pageContext.request.contextPath}/admin/peliculas" class="btn-manage">Gestionar</a>
                                        <a href="${pageContext.request.contextPath}/admin/peliculas/nueva" class="btn-new">Nueva Película</a>
                                    </div>
                                </div>

                                <!-- Cines y Salas -->
                                <div class="management-card">
                                    <div class="card-header">
                                        <h3 class="card-title">Cines y Salas</h3>
                                        <span class="crud-badge">CRUD</span>
                                    </div>
                                    <p class="card-description">
                                        Administrar ubicaciones, salas y configuraciones de asientos
                                    </p>
                                    <div class="card-actions">
                                        <a href="${pageContext.request.contextPath}/admin/cines" class="btn-manage">Gestionar</a>
                                        <a href="${pageContext.request.contextPath}/admin/salas" class="btn-special">Salas</a>
                                    </div>
                                </div>

                                <!-- Horarios y Funciones -->
                                <div class="management-card">
                                    <div class="card-header">
                                        <h3 class="card-title">Horarios y Funciones</h3>
                                        <span class="crud-badge">CRUD</span>
                                    </div>
                                    <p class="card-description">
                                        Programar funciones, horarios y precios especiales
                                    </p>
                                    <div class="card-actions">
                                        <!-- Button trigger modal -->
                                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#ModalGestionar">
                                            Gestionar
                                        </button>
                                        <!-- Button trigger modal -->
                                        <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#ModalNewFuncion">
                                            Nueva Funcion
                                        </button>
                                    </div>
                                </div>

                                <!-- Modal Gestionar Funciones -->
                                <div class="modal fade" id="ModalGestionar" tabindex="-1" aria-labelledby="ModalGestionarLabel" aria-hidden="true">
                                    <div class="modal-dialog modal-superxl">
                                        <div class="modal-content">

                                            <div class="modal-header">
                                                <h5 class="modal-title" id="ModalGestionarLabel">Gestionar Funciones</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                                            </div>

                                            <div class="modal-body">
                                                <table class="table table-bordered table-striped table-hover">
                                                    <thead class="table-dark">
                                                        <tr>
                                                            <th>ID</th>
                                                            <th>Sala</th>
                                                            <th>Película</th>
                                                            <th>Fecha y Hora</th>
                                                            <th>Idioma</th>
                                                            <th>Precio Base</th>
                                                            <th>Acciones</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>
                                                            <td>1</td>
                                                            <td>3</td>
                                                            <td>7</td>
                                                            <td>2025-06-01 20:00</td>
                                                            <td>SUB</td>
                                                            <td>S/ 15.00</td>
                                                            <td>
                                                                <button class="btn btn-warning btn-sm">Editar</button>
                                                                <button class="btn btn-danger btn-sm">Eliminar</button>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>2</td>
                                                            <td>2</td>
                                                            <td>5</td>
                                                            <td>2025-06-01 22:30</td>
                                                            <td>DOB</td>
                                                            <td>S/ 18.00</td>
                                                            <td>
                                                                <button class="btn btn-warning btn-sm">Editar</button>
                                                                <button class="btn btn-danger btn-sm">Eliminar</button>
                                                            </td>
                                                        </tr>
                                                        <!-- Puedes duplicar más filas de ejemplo si deseas -->
                                                    </tbody>
                                                </table>
                                            </div>

                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                                            </div>

                                        </div>
                                    </div>
                                </div>

                                <!-- Modal Nueva funcion-->
                                <div class="modal fade" id="ModalNewFuncion" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h1 class="modal-title fs-5" id="exampleModalLabel">Modal title</h1>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <form id="formCrearFuncion">
                                                    <div class="mb-3">
                                                        <label for="sala_id" class="form-label">Sala ID</label>
                                                        <input type="number" class="form-control" id="sala_id" name="sala_id" required>
                                                    </div>

                                                    <div class="mb-3">
                                                        <label for="pelicula_id" class="form-label">Película ID</label>
                                                        <input type="number" class="form-control" id="pelicula_id" name="pelicula_id" required>
                                                    </div>

                                                    <div class="mb-3">
                                                        <label for="fecha_hora" class="form-label">Fecha y Hora</label>
                                                        <input type="datetime-local" class="form-control" id="fecha_hora" name="fecha_hora" required>
                                                    </div>

                                                    <div class="mb-3">
                                                        <label for="idioma" class="form-label">Idioma</label>
                                                        <select class="form-select" id="idioma" name="idioma">
                                                            <option value="SUB">SUB</option>
                                                            <option value="DOB">DOB</option>
                                                            <option value="ESP">ESP</option>
                                                        </select>
                                                    </div>

                                                    <div class="mb-3">
                                                        <label for="precio_base" class="form-label">Precio Base (S/)</label>
                                                        <input type="number" step="0.01" class="form-control" id="precio_base" name="precio_base" required>
                                                    </div>
                                                </form>

                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                <button type="button" class="btn btn-primary">Save changes</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Promociones -->
                                <div class="management-card">
                                    <div class="card-header">
                                        <h3 class="card-title">Promociones</h3>
                                        <span class="crud-badge">CRUD</span>
                                    </div>
                                    <p class="card-description">
                                        Crear y administrar descuentos, ofertas y promociones especiales
                                    </p>
                                    <div class="card-actions">
                                        <a href="${pageContext.request.contextPath}/admin/promociones" class="btn-manage">Gestionar</a>
                                        <a href="${pageContext.request.contextPath}/admin/promociones/nueva" class="btn-new">Nueva Promoción</a>
                                    </div>
                                </div>

                                <!-- Usuarios -->
                                <div class="management-card">
                                    <div class="card-header">
                                        <h3 class="card-title">Usuarios</h3>
                                        <span class="crud-badge">CRUD</span>
                                    </div>
                                    <p class="card-description">
                                        Administrar cuentas de usuarios y permisos del sistema
                                    </p>
                                    <div class="card-actions">
                                        <a href="${pageContext.request.contextPath}/admin/usuarios" class="btn-manage">Gestionar</a>
                                        <a href="${pageContext.request.contextPath}/admin/roles" class="btn-special">Roles</a>
                                    </div>
                                </div>

                                <!-- Reservas -->
                                <div class="management-card">
                                    <div class="card-header">
                                        <h3 class="card-title">Reservas</h3>
                                        <span class="crud-badge">CRUD</span>
                                    </div>
                                    <p class="card-description">
                                        Administrar reservas, cancelaciones y reembolsos
                                    </p>
                                    <div class="card-actions">
                                        <a href="${pageContext.request.contextPath}/admin/reservas" class="btn-manage">Gestionar</a>
                                        <a href="${pageContext.request.contextPath}/admin/reservas/reportes" class="btn-reports">Reportes</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <footer>
            <div class="footer-content">
                <!-- Pie de página igual que antes -->
            </div>
        </footer>

        <script>
            // Script para las pestañas
            const tabs = document.querySelectorAll('.tab');
            const tabContents = document.querySelectorAll('.tab-content');

            tabs.forEach((tab, index) => {
                tab.addEventListener('click', () => {
                    tabs.forEach(t => t.classList.remove('active'));
                    tabContents.forEach(c => c.classList.remove('active'));
                    tab.classList.add('active');
                    tabContents[index].classList.add('active');
                });
            });
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js" integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO" crossorigin="anonymous"></script>
    </body>
</html>