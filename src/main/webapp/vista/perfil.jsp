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
        <!-- Bootstrap 5 CSS -->
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
            rel="stylesheet" crossorigin="anonymous"/>
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
        </style>
    </head>
    <body>
        <!-- 1) Calcular isAdmin y exponer 'usuario' en página -->
        <c:set var="usuario" value="${sessionScope.user}" />
        <c:set var="isAdmin"  value="false" />
        <c:forEach var="r" items="${usuario.roles}">
            <c:if test="${r.nombre == 'ADMIN'}">
                <c:set var="isAdmin" value="true" />
            </c:if>
        </c:forEach>

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
                            <c:if test="${isAdmin}">
                                <div class="tab">Gestión</div>
                            </c:if>
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

                        <!-- GESTIÓN (solo ADMIN) -->
                        <c:if test="${isAdmin}">
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
                                            <button class="btn-manage" data-bs-toggle="modal" data-bs-target="#modalPeliculas">Gestionar</button>
                                            <button class="btn-reports" data-bs-toggle="modal" data-bs-target="#modalAgregarPeliculas">Agregar Peliculas</button>
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
                                            <button class="btn-manage" data-bs-toggle="modal" data-bs-target="#modalReservas">Gestionar</button>
                                            <button class="btn-reports" data-bs-toggle="modal" data-bs-target="#modalReportes">Reportes</button>
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
                                            <button class="btn-manage" data-bs-toggle="modal" data-bs-target="#modalReservas">Gestionar</button>
                                            <button class="btn-reports" data-bs-toggle="modal" data-bs-target="#modalReportes">Reportes</button>
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
                                            <button class="btn-manage" data-bs-toggle="modal" data-bs-target="#modalReservas">Gestionar</button>
                                            <button class="btn-reports" data-bs-toggle="modal" data-bs-target="#modalReportes">Reportes</button>
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
                                            <button class="btn-manage" data-bs-toggle="modal" data-bs-target="#modalReservas">Gestionar</button>
                                            <button class="btn-reports" data-bs-toggle="modal" data-bs-target="#modalReportes">Reportes</button>
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
                                            <button class="btn-manage" data-bs-toggle="modal" data-bs-target="#modalReservas">Gestionar</button>
                                            <button class="btn-reports" data-bs-toggle="modal" data-bs-target="#modalReportes">Reportes</button>
                                        </div>    
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
            <!-- Modal Ejemplo para peliculas-->
            <!-- Modal: Ver Películas -->
            <p style="color:red">
  Películas cargadas: ${fn:length(peliculas)}
</p>
<!-- Modal: Ver Películas -->
<div class="modal fade" id="modalPeliculas" tabindex="-1">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header"><h5 class="modal-title">Películas Registradas</h5></div>
      <div class="modal-body">
        <table class="table table-bordered table-hover">
          <thead>
            <tr><th>Título</th><th>Duración</th><th>Clasificación</th><th>Acciones</th></tr>
          </thead>
          <tbody>
            <c:forEach var="p" items="${peliculas}">
              <tr>
                <td>${p.titulo}</td>
                <td>${p.duracionMin} min</td>
                <td>${p.clasificacion}</td>
                <td>
                  <!-- Botón Eliminar -->
                  <form method="post" action="${pageContext.request.contextPath}/perfil" style="display:inline">
                    <input type="hidden" name="accion" value="eliminar" />
                    <input type="hidden" name="id" value="${p.id}" />
                    <button class="btn btn-danger btn-sm">Eliminar</button>
                  </form>

                  <!-- Botón Editar -->
                  <button class="btn btn-warning btn-sm"
                          data-bs-toggle="modal"
                          data-bs-target="#modalEditarPeliculas${p.id}">
                    Editar
                  </button>
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>

              <!-- Modal de edición de película -->
<c:forEach var="p" items="${peliculas}">
  <div class="modal fade" id="modalEditarPeliculas${p.id}" tabindex="-1">
    <div class="modal-dialog">
      <div class="modal-content">
        <form action="${pageContext.request.contextPath}/perfil" method="post">
          <input type="hidden" name="accion" value="editar"/>
          <input type="hidden" name="id" value="${p.id}"/>

          <div class="modal-header">
            <h5 class="modal-title">Editar Película: ${p.titulo}</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
          </div>

          <div class="modal-body">
            <div class="mb-2"><label>Título</label><input name="titulo" class="form-control" value="${p.titulo}" required/></div>
            <div class="mb-2"><label>Duración (min)</label><input type="number" name="duracion" class="form-control" value="${p.duracionMin}" required/></div>
            <div class="mb-2"><label>Sinopsis</label><textarea name="sinopsis" class="form-control">${p.sinopsis}</textarea></div>
            <div class="mb-2"><label>Clasificación</label><input name="clasificacion" class="form-control" value="${p.clasificacion}"/></div>
            <div class="mb-2"><label>Fecha de Estreno</label><input type="date" name="estreno" class="form-control" value="${p.estreno}"/></div>
            <div class="mb-2"><label>Imagen URL</label><input name="img_url" class="form-control" value="${p.imgUrl}"/></div>
          </div>

          <div class="modal-footer">
            <button class="btn btn-secondary" type="button" data-bs-dismiss="modal">Cancelar</button>
            <button class="btn btn-success" type="submit">Guardar Cambios</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</c:forEach>

          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>

            
            <!-- Modal: Agregar Película -->
            <div class="modal fade" id="modalAgregarPeliculas" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form action="${pageContext.request.contextPath}/perfil" method="post">
                            <div class="modal-header"><h5 class="modal-title">Agregar Nueva Película</h5></div>
                            <div class="modal-body">
                                <input type="hidden" name="accion" value="agregar"/>
                                <div class="mb-2"><label>Título</label><input name="titulo" class="form-control" required/></div>
                                <div class="mb-2"><label>Duración (min)</label><input type="number" name="duracion" class="form-control" required/></div>
                                <div class="mb-2"><label>Sinopsis</label><textarea name="sinopsis" class="form-control"></textarea></div>
                                <div class="mb-2"><label>Clasificación</label><input name="clasificacion" class="form-control"/></div>
                                <div class="mb-2"><label>Fecha de Estreno</label><input type="date" name="estreno" class="form-control"/></div>
                                <div class="mb-2"><label>Imagen URL</label><input name="img_url" class="form-control"/></div>
                            </div>
                            <div class="modal-footer">
                                <button class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                <button class="btn btn-primary" type="submit">Guardar</button>
                            </div>
                        </form>
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
        <!-- Bootstrap Bundle JS -->
        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
    </body>
</html>