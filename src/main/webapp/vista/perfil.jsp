<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>CineReserva - Mi Cuenta</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
          integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/perfil.css" />

    <style>
        .management-card .card-header .card-title-icon {
            display: flex;
            align-items: center;
            gap: 0.85rem;
        }
        .management-card .card-title-icon .fas {
            font-size: 1.6rem;
            color: var(--primary-color);
            width: 30px;
            text-align: center;
        }
        .management-card .card-title {
            font-size: 1.3rem;
            margin-bottom: 0;
        }
    </style>
</head>
<body>
    <c:set var="usuario" value="${sessionScope.user}" />
    <c:set var="isAdmin" value="false" />
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
                <a href="${pageContext.request.contextPath}/perfil" class="btn btn-primary me-2">Mi Cuenta</a>
                <form action="${pageContext.request.contextPath}/logout" method="post" style="display:inline;">
                    <button type="submit" class="btn btn-danger">Cerrar sesión</button>
                </form>
            </div>
        </nav>
    </header>

    <main class="container my-4">
        <h1 class="page-title">Mi Cuenta</h1>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>

        <div class="profile-container d-flex">
            <div class="sidebar pe-4">
                <div class="profile-avatar">${fn:substring(usuario.nombre,0,1)}</div>
                <h2 class="user-name"><c:out value="${usuario.nombre}"/></h2>
                <p class="user-email"><c:out value="${usuario.email}"/></p>
            </div>

            <div class="content-area flex-fill">
                <div class="tab-container">
                    <div class="tabs d-flex mb-3">
                        <div class="tab active">Perfil</div>
                        <div class="tab">Reservas</div>
                        <div class="tab">Estadísticas</div>
                        <c:if test="${isAdmin}">
                            <div class="tab">Gestión</div>
                        </c:if>
                    </div>

                    <!-- Perfil -->
                    <div class="tab-content active">
                        <h2 class="section-title">Información Personal</h2>
                        <form action="${pageContext.request.contextPath}/profile" method="post">
                            <input type="hidden" name="id" value="${usuario.id}" />
                            <div class="form-row d-flex">
                                <div class="form-group flex-fill me-3">
                                    <label for="nombre">Nombre</label>
                                    <input type="text" id="nombre" name="nombre" class="form-control" value="<c:out value='${usuario.nombre}'/>" required />
                                </div>
                                <div class="form-group flex-fill">
                                    <label for="email">Email</label>
                                    <input type="email" id="email" name="email" class="form-control" value="<c:out value='${usuario.email}'/>" required />
                                </div>
                            </div>
                            <div class="form-row d-flex">
                                <div class="form-group flex-fill me-3">
                                    <label for="telefono">Teléfono</label>
                                    <input type="tel" id="telefono" name="telefono" class="form-control" value="<c:out value='${usuario.telefono}'/>" />
                                </div>
                                <div class="form-group flex-fill">
                                    <label for="fecha_reg">Fecha de Registro</label>
                                    <input type="text" id="fecha_reg" class="form-control" disabled value="<fmt:formatDate value='${usuario.fechaReg}' pattern='dd/MM/yyyy'/>" />
                                </div>
                            </div>
                            <div class="password-section">
                                <h3 class="section-title">Cambiar Contraseña</h3>
                                <div class="form-group mb-3">
                                    <label for="current_password">Contraseña Actual</label>
                                    <input type="password" id="current_password" name="current_password" class="form-control" />
                                </div>
                                <div class="form-row d-flex">
                                    <div class="form-group flex-fill me-3">
                                        <label for="new_password">Nueva Contraseña</label>
                                        <input type="password" id="new_password" name="new_password" class="form-control" />
                                    </div>
                                    <div class="form-group flex-fill">
                                        <label for="confirm_password">Confirmar Contraseña</label>
                                        <input type="password" id="confirm_password" name="confirm_password" class="form-control" />
                                    </div>
                                </div>
                            </div>
                            <button type="submit" class="btn btn-primary">Guardar Cambios</button>
                        </form>
                    </div>

                    <!-- Mis Reservas -->
                    <div class="tab-content">
                        <h2 class="section-title">Mis Reservas</h2>
                        <p>Aquí se mostrarán las reservas del usuario...</p>
                    </div>

                    <!-- Estadísticas -->
                    <div class="tab-content">
                        <h2 class="section-title">Estadísticas</h2>
                        <p>Aquí se mostrarán las estadísticas del usuario...</p>
                    </div>

                    <!-- Gestión de Contenido (Admin) -->
                    <c:if test="${isAdmin}">
                        <div class="tab-content">
                            <h2 class="section-title">Gestión de Contenido</h2>
                            <div class="management-grid row row-cols-1 row-cols-md-2 row-cols-lg-3 g-3">
                                
                                <!-- Películas -->
                                <div class="management-card card">
                                    <div class="card-header d-flex justify-content-between align-items-center">
                                        <div class="card-title-icon d-flex align-items-center">
                                            <i class="fas fa-film"></i>
                                            <h3 class="card-title mb-0">Películas</h3>
                                        </div>
                                        <span class="badge bg-secondary">CRUD</span>
                                    </div>
                                    <div class="card-body">
                                        <p>Administrar catálogo de películas, géneros y clasificaciones.</p>
                                        <div class="card-actions">
                                            <button class="btn btn-secondary btn-sm" data-bs-toggle="modal" data-bs-target="#modalPeliculas">Gestionar</button>
                                            <button class="btn btn-success btn-sm" data-bs-toggle="modal" data-bs-target="#modalAgregarPeliculas">
                                                <i class="fas fa-plus"></i> Nueva Película
                                            </button>
                                        </div>
                                    </div>
                                </div>

                                <!-- Cines y Salas -->
                                <div class="management-card card">
                                    <div class="card-header d-flex justify-content-between align-items-center">
                                        <div class="card-title-icon d-flex align-items-center">
                                            <i class="fas fa-couch"></i>
                                            <h3 class="card-title mb-0">Cines y Salas</h3>
                                        </div>
                                        <span class="badge bg-secondary">CRUD</span>
                                    </div>
                                    <div class="card-body">
                                        <p>Administrar ubicaciones, salas y configuraciones de asientos.</p>
                                        <div class="card-actions">
                                            <button class="btn btn-secondary btn-sm" data-bs-toggle="modal" data-bs-target="#modalCinesSalas">Gestionar</button>
                                        </div>
                                    </div>
                                </div>

                                <!-- Horarios y Funciones -->
                                <div class="management-card card">
                                    <div class="card-header d-flex justify-content-between align-items-center">
                                        <div class="card-title-icon d-flex align-items-center">
                                            <i class="fas fa-clock"></i>
                                            <h3 class="card-title mb-0">Horarios y Funciones</h3>
                                        </div>
                                        <span class="badge bg-secondary">CRUD</span>
                                    </div>
                                    <div class="card-body">
                                        <p>Programar funciones, horarios y precios especiales.</p>
                                        <div class="card-actions">
                                            <button class="btn btn-secondary btn-sm" data-bs-toggle="modal" data-bs-target="#modalReservas">Gestionar</button>
                                            <button class="btn btn-info btn-sm" data-bs-toggle="modal" data-bs-target="#modalReportes">Reportes</button>
                                        </div>
                                    </div>
                                </div>

                                <!-- Promociones -->
                                <div class="management-card card">
                                    <div class="card-header d-flex justify-content-between align-items-center">
                                        <div class="card-title-icon d-flex align-items-center">
                                            <i class="fas fa-tags"></i>
                                            <h3 class="card-title mb-0">Promociones</h3>
                                        </div>
                                        <span class="badge bg-secondary">CRUD</span>
                                    </div>
                                    <div class="card-body">
                                        <p>Crear y administrar descuentos, ofertas y promociones especiales.</p>
                                        <div class="card-actions">
                                            <button class="btn btn-secondary btn-sm" data-bs-toggle="modal" data-bs-target="#modalPromociones">Gestionar</button>
                                        </div>
                                    </div>
                                </div>

                                <!-- Usuarios -->
                                <div class="management-card card">
                                    <div class="card-header d-flex justify-content-between align-items-center">
                                        <div class="card-title-icon d-flex align-items-center">
                                            <i class="fas fa-users"></i>
                                            <h3 class="card-title mb-0">Usuarios</h3>
                                        </div>
                                        <span class="badge bg-secondary">CRUD</span>
                                    </div>
                                    <div class="card-body">
                                        <p>Administrar cuentas de usuarios y permisos del sistema.</p>
                                        <div class="card-actions">
                                            <button class="btn btn-secondary btn-sm" data-bs-toggle="modal" data-bs-target="#modalUsuariosAdmin">Gestionar</button>
                                        </div>
                                    </div>
                                </div>

                                <!-- Reservas -->
                                <div class="management-card card">
                                    <div class="card-header d-flex justify-content-between align-items-center">
                                        <div class="card-title-icon d-flex align-items-center">
                                            <i class="fas fa-ticket-alt"></i>
                                            <h3 class="card-title mb-0">Reservas</h3>
                                        </div>
                                        <span class="badge bg-secondary">CRUD</span>
                                    </div>
                                    <div class="card-body">
                                        <p>Administrar reservas, cancelaciones y reembolsos.</p>
                                        <div class="card-actions">
                                            <button class="btn btn-secondary btn-sm" data-bs-toggle="modal" data-bs-target="#modalAdminReservas">Gestionar</button>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </c:if>

                </div>
            </div>
        </div>
    </main>

    <!-- Modales existentes para Funciones y Películas -->
    <div class="modal fade" id="modalReservas" tabindex="-1" aria-labelledby="ModalGestionarLabel" aria-hidden="true">
            <div class="modal-dialog modal-xl">
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
                            </tbody>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>
    <div class="modal fade" id="modalReportes" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalLabel">Crear Nueva Función</h1>
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
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                        <button type="button" class="btn btn-primary">Guardar</button>
                    </div>
                </div>
            </div>
        </div>
    <div class="modal fade" id="modalPeliculas" tabindex="-1">
            <div class="modal-dialog modal-xl">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Películas Registradas</h5>
                         <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                    </div>
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
                                            <form method="post" action="${pageContext.request.contextPath}/perfil" style="display:inline">
                                                <input type="hidden" name="accion" value="eliminar" />
                                                <input type="hidden" name="id" value="${p.id}" />
                                                <button class="btn btn-danger btn-sm">Eliminar</button>
                                            </form>
                                            <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#modalEditarPeliculas${p.id}">
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
    <c:forEach var="p" items="${peliculas}">
            <div class="modal fade" id="modalEditarPeliculas${p.id}" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form action="${pageContext.request.contextPath}/perfil" method="post" accept-charset="UTF-8">
                            <input type="hidden" name="accion" value="editar"/>
                            <input type="hidden" name="id" value="${p.id}"/>
                            <div class="modal-header">
                                <h5 class="modal-title">Editar Película: ${p.titulo}</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body">
                                <div class="mb-2"><label class="form-label">Título</label><input name="titulo" class="form-control" value="${p.titulo}" required/></div>
                                <div class="mb-2"><label class="form-label">Duración (min)</label><input type="number" name="duracion" class="form-control" value="${p.duracionMin}" required/></div>
                                <div class="mb-2"><label class="form-label">Sinopsis</label><textarea name="sinopsis" class="form-control">${p.sinopsis}</textarea></div>
                                <div class="mb-2"><label class="form-label">Clasificación</label><input name="clasificacion" class="form-control" value="${p.clasificacion}"/></div>
                                <div class="mb-2"><label class="form-label">Fecha de Estreno</label><input type="date" name="estreno" class="form-control" value="${p.estreno}"/></div>
                                <div class="mb-2"><label class="form-label">Imagen URL</label><input name="img_url" class="form-control" value="${p.imgUrl}"/></div>
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
            <div class="modal fade" id="modalAgregarPeliculas" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="${pageContext.request.contextPath}/perfil" method="post" accept-charset="UTF-8">
                         <div class="modal-header">
                             <h5 class="modal-title">Agregar Nueva Película</h5>
                             <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                         </div>
                        <div class="modal-body">
                            <input type="hidden" name="accion" value="agregar"/>
                            <div class="mb-2"><label class="form-label">Título</label><input name="titulo" class="form-control" required/></div>
                            <div class="mb-2"><label class="form-label">Duración (min)</label><input type="number" name="duracion" class="form-control" required/></div>
                            <div class="mb-2"><label class="form-label">Sinopsis</label><textarea name="sinopsis" class="form-control"></textarea></div>
                            <div class="mb-2"><label class="form-label">Clasificación</label><input name="clasificacion" class="form-control"/></div>
                            <div class="mb-2"><label class="form-label">Fecha de Estreno</label><input type="date" name="estreno" class="form-control"/></div>
                            <div class="mb-2"><label class="form-label">Imagen URL</label><input name="img_url" class="form-control"/></div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                            <button class="btn btn-primary" type="submit">Guardar</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

    <!-- ==================== NUEVOS MODALES ==================== -->

    <!-- Modal Cines y Salas -->
    <div class="modal fade" id="modalCinesSalas" tabindex="-1" aria-labelledby="modalCinesSalasLabel" aria-hidden="true">
      <div class="modal-dialog modal-xl">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Cines y Salas Registrados</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
          </div>
          <div class="modal-body">
            <ul class="nav nav-tabs" id="cinesSalasTab" role="tablist">
              <li class="nav-item" role="presentation">
                <button class="nav-link active" id="cines-tab" data-bs-toggle="tab" data-bs-target="#cinesTab" type="button" role="tab">Cines</button>
              </li>
              <li class="nav-item" role="presentation">
                <button class="nav-link" id="salas-tab" data-bs-toggle="tab" data-bs-target="#salasTab" type="button" role="tab">Salas</button>
              </li>
            </ul>
            <div class="tab-content pt-3">
              <!-- CINES -->
              <div class="tab-pane fade show active" id="cinesTab" role="tabpanel">
                <button class="btn btn-success btn-sm mb-3" data-bs-toggle="modal" data-bs-target="#modalAgregarCine">
                  <i class="fas fa-plus"></i> Nuevo Cine
                </button>
                <table class="table table-bordered table-hover">
                  <thead class="table-dark">
                    <tr>
                      <th>ID</th><th>Nombre</th><th>Dirección</th><th>Ciudad</th><th>Teléfono</th><th>Acciones</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="cine" items="${cines}">
                      <tr>
                        <td>${cine.id}</td>
                        <td>${cine.nombre}</td>
                        <td>${cine.direccion}</td>
                        <td>${cine.ciudad}</td>
                        <td>${cine.telefono}</td>
                        <td>
                          <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#modalEditarCine${cine.id}">Editar</button>
                          <form action="${pageContext.request.contextPath}/cines" method="post" style="display:inline">
                            <input type="hidden" name="accion" value="eliminar"/>
                            <input type="hidden" name="id" value="${cine.id}"/>
                            <button class="btn btn-danger btn-sm">Eliminar</button>
                          </form>
                        </td>
                      </tr>
                    </c:forEach>
                  </tbody>
                </table>
              </div>
              <!-- SALAS -->
              <div class="tab-pane fade" id="salasTab" role="tabpanel">
                <button class="btn btn-success btn-sm mb-3" data-bs-toggle="modal" data-bs-target="#modalAgregarSala">
                  <i class="fas fa-plus"></i> Nueva Sala
                </button>
                <table class="table table-bordered table-hover">
                  <thead class="table-dark">
                    <tr>
                      <th>ID</th><th>Cine</th><th>Nombre</th><th>Capacidad</th><th>Acciones</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="sala" items="${salas}">
                      <tr>
                        <td>${sala.id}</td>
                        <td>${sala.cine.nombre}</td>
                        <td>${sala.nombre}</td>
                        <td>${sala.capacidad}</td>
                        <td>
                          <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#modalEditarSala${sala.id}">Editar</button>
                          <form action="${pageContext.request.contextPath}/salas" method="post" style="display:inline">
                            <input type="hidden" name="accion" value="eliminar"/>
                            <input type="hidden" name="id" value="${sala.id}"/>
                            <button class="btn btn-danger btn-sm">Eliminar</button>
                          </form>
                        </td>
                      </tr>
                    </c:forEach>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
          </div>
        </div>
      </div>
    </div>

    <!-- Agregar Cine -->
    <div class="modal fade" id="modalAgregarCine" tabindex="-1" aria-labelledby="modalAgregarCineLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <form action="${pageContext.request.contextPath}/cines" method="post">
            <input type="hidden" name="accion" value="agregar"/>
            <div class="modal-header">
              <h5 class="modal-title">Agregar Nuevo Cine</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
            </div>
            <div class="modal-body">
              <div class="mb-3">
                <label for="cine_nombre" class="form-label">Nombre</label>
                <input type="text" class="form-control" id="cine_nombre" name="nombre" required/>
              </div>
              <div class="mb-3">
                <label for="cine_direccion" class="form-label">Dirección</label>
                <input type="text" class="form-control" id="cine_direccion" name="direccion"/>
              </div>
              <div class="mb-3">
                <label for="cine_ciudad" class="form-label">Ciudad</label>
                <input type="text" class="form-control" id="cine_ciudad" name="ciudad"/>
              </div>
              <div class="mb-3">
                <label for="cine_telefono" class="form-label">Teléfono</label>
                <input type="tel" class="form-control" id="cine_telefono" name="telefono"/>
              </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
              <button type="submit" class="btn btn-primary">Guardar Cine</button>
            </div>
          </form>
        </div>
      </div>
    </div>

    <!-- Editar Cine -->
    <c:forEach var="cine" items="${cines}">
      <div class="modal fade" id="modalEditarCine${cine.id}" tabindex="-1" aria-labelledby="modalEditarCineLabel${cine.id}" aria-hidden="true">
        <div class="modal-dialog">
          <div class="modal-content">
            <form action="${pageContext.request.contextPath}/cines" method="post">
              <input type="hidden" name="accion" value="editar"/>
              <input type="hidden" name="id" value="${cine.id}"/>
              <div class="modal-header">
                <h5 class="modal-title">Editar Cine: ${cine.nombre}</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
              </div>
              <div class="modal-body">
                <div class="mb-3">
                  <label class="form-label">Nombre</label>
                  <input type="text" class="form-control" name="nombre" value="${cine.nombre}" required/>
                </div>
                <div class="mb-3">
                  <label class="form-label">Dirección</label>
                  <input type="text" class="form-control" name="direccion" value="${cine.direccion}"/>
                </div>
                <div class="mb-3">
                  <label class="form-label">Ciudad</label>
                  <input type="text" class="form-control" name="ciudad" value="${cine.ciudad}"/>
                </div>
                <div class="mb-3">
                  <label class="form-label">Teléfono</label>
                  <input type="tel" class="form-control" name="telefono" value="${cine.telefono}"/>
                </div>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button type="submit" class="btn btn-success">Guardar Cambios</button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </c:forEach>

    <!-- Agregar Sala -->
    <div class="modal fade" id="modalAgregarSala" tabindex="-1" aria-labelledby="modalAgregarSalaLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <form action="${pageContext.request.contextPath}/salas" method="post">
            <input type="hidden" name="accion" value="agregar"/>
            <div class="modal-header">
              <h5 class="modal-title">Agregar Nueva Sala</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
            </div>
            <div class="modal-body">
              <div class="mb-3">
                <label for="sala_cine_id" class="form-label">Cine</label>
                <select class="form-select" id="sala_cine_id" name="cine_id" required>
                  <c:forEach var="cine" items="${cines}">
                    <option value="${cine.id}">${cine.nombre}</option>
                  </c:forEach>
                </select>
              </div>
              <div class="mb-3">
                <label for="sala_nombre" class="form-label">Nombre</label>
                <input type="text" class="form-control" id="sala_nombre" name="nombre" required/>
              </div>
              <div class="mb-3">
                <label for="sala_capacidad" class="form-label">Capacidad</label>
                <input type="number" class="form-control" id="sala_capacidad" name="capacidad" required/>
              </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
              <button type="submit" class="btn btn-primary">Guardar Sala</button>
            </div>
          </form>
        </div>
      </div>
    </div>

    <!-- Editar Sala -->
    <c:forEach var="sala" items="${salas}">
      <div class="modal fade" id="modalEditarSala${sala.id}" tabindex="-1" aria-labelledby="modalEditarSalaLabel${sala.id}" aria-hidden="true">
        <div class="modal-dialog">
          <div class="modal-content">
            <form action="${pageContext.request.contextPath}/salas" method="post">
              <input type="hidden" name="accion" value="editar"/>
              <input type="hidden" name="id" value="${sala.id}"/>
              <div class="modal-header">
                <h5 class="modal-title">Editar Sala: ${sala.nombre}</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
              </div>
              <div class="modal-body">
                <div class="mb-3">
                  <label class="form-label">Cine</label>
                  <select class="form-select" name="cine_id" required>
                    <c:forEach var="cine" items="${cines}">
                      <option value="${cine.id}" <c:if test="${cine.id == sala.cine.id}">selected</c:if>>${cine.nombre}</option>
                    </c:forEach>
                  </select>
                </div>
                <div class="mb-3">
                  <label class="form-label">Nombre</label>
                  <input type="text" class="form-control" name="nombre" value="${sala.nombre}" required/>
                </div>
                <div class="mb-3">
                  <label class="form-label">Capacidad</label>
                  <input type="number" class="form-control" name="capacidad" value="${sala.capacidad}" required/>
                </div>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button type="submit" class="btn btn-success">Guardar Cambios</button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </c:forEach>

    <!-- Modal Promociones -->
    <div class="modal fade" id="modalPromociones" tabindex="-1" aria-labelledby="modalPromocionesLabel" aria-hidden="true">
      <div class="modal-dialog modal-xl">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Promociones Registradas</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
          </div>
          <div class="modal-body">
            <button class="btn btn-success btn-sm mb-3" data-bs-toggle="modal" data-bs-target="#modalAgregarPromocion">
              <i class="fas fa-plus"></i> Nueva Promoción
            </button>
            <table class="table table-bordered table-hover">
              <thead class="table-dark">
                <tr>
                  <th>ID</th><th>Título</th><th>Descripción</th><th>Descuento (%)</th><th>Inicio</th><th>Fin</th><th>Activo</th><th>Acciones</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="promo" items="${promociones}">
                  <tr>
                    <td>${promo.id}</td>
                    <td>${promo.titulo}</td>
                    <td>${promo.descripcion}</td>
                    <td>${promo.descuentoPct}</td>
                    <td><fmt:formatDate value="${promo.fechaInicio}" pattern="dd/MM/yyyy"/></td>
                    <td><fmt:formatDate value="${promo.fechaFin}" pattern="dd/MM/yyyy"/></td>
                    <td>${promo.activo}</td>
                    <td>
                      <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#modalEditarPromocion${promo.id}">Editar</button>
                      <form action="${pageContext.request.contextPath}/promociones" method="post" style="display:inline">
                        <input type="hidden" name="accion" value="eliminar"/>
                        <input type="hidden" name="id" value="${promo.id}"/>
                        <button class="btn btn-danger btn-sm">Eliminar</button>
                      </form>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
          </div>
        </div>
      </div>
    </div>

    <!-- Agregar Promoción -->
    <div class="modal fade" id="modalAgregarPromocion" tabindex="-1" aria-labelledby="modalAgregarPromocionLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <form action="${pageContext.request.contextPath}/promociones" method="post">
            <input type="hidden" name="accion" value="agregar"/>
            <div class="modal-header">
              <h5 class="modal-title">Agregar Nueva Promoción</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
            </div>
            <div class="modal-body">
              <div class="mb-3">
                <label class="form-label">Título</label>
                <input type="text" class="form-control" name="titulo" required/>
              </div>
              <div class="mb-3">
                <label class="form-label">Descripción</label>
                <textarea class="form-control" name="descripcion"></textarea>
              </div>
              <div class="mb-3">
                <label class="form-label">Descuento (%)</label>
                <input type="number" step="0.01" class="form-control" name="descuentoPct" required/>
              </div>
              <div class="mb-3">
                <label class="form-label">Fecha Inicio</label>
                <input type="date" class="form-control" name="fechaInicio" required/>
              </div>
              <div class="mb-3">
                <label class="form-label">Fecha Fin</label>
                <input type="date" class="form-control" name="fechaFin" required/>
              </div>
              <div class="form-check">
                <input class="form-check-input" type="checkbox" id="promo_activo" name="activo" checked/>
                <label class="form-check-label" for="promo_activo">Activo</label>
              </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
              <button type="submit" class="btn btn-primary">Guardar Promoción</button>
            </div>
          </form>
        </div>
      </div>
    </div>

    <!-- Editar Promoción -->
    <c:forEach var="promo" items="${promociones}">
      <div class="modal fade" id="modalEditarPromocion${promo.id}" tabindex="-1" aria-labelledby="modalEditarPromocionLabel${promo.id}" aria-hidden="true">
        <div class="modal-dialog">
          <div class="modal-content">
            <form action="${pageContext.request.contextPath}/promociones" method="post">
              <input type="hidden" name="accion" value="editar"/>
              <input type="hidden" name="id" value="${promo.id}"/>
              <div class="modal-header">
                <h5 class="modal-title">Editar Promoción: ${promo.titulo}</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
              </div>
              <div class="modal-body">
                <div class="mb-3">
                  <label class="form-label">Título</label>
                  <input type="text" class="form-control" name="titulo" value="${promo.titulo}" required/>
                </div>
                <div class="mb-3">
                  <label class="form-label">Descripción</label>
                  <textarea class="form-control" name="descripcion">${promo.descripcion}</textarea>
                </div>
                <div class="mb-3">
                  <label class="form-label">Descuento (%)</label>
                  <input type="number" step="0.01" class="form-control" name="descuentoPct" value="${promo.descuentoPct}" required/>
                </div>
                <div class="mb-3">
                  <label class="form-label">Fecha Inicio</label>
                  <input type="date" class="form-control" name="fechaInicio" value="${promo.fechaInicio}" required/>
                </div>
                <div class="mb-3">
                  <label class="form-label">Fecha Fin</label>
                  <input type="date" class="form-control" name="fechaFin" value="${promo.fechaFin}" required/>
                </div>
                <div class="form-check">
                  <input class="form-check-input" type="checkbox" id="promo_activo_${promo.id}" name="activo" <c:if test="${promo.activo}">checked</c:if>/>
                  <label class="form-check-label" for="promo_activo_${promo.id}">Activo</label>
                </div>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button type="submit" class="btn btn-success">Guardar Cambios</button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </c:forEach>

    <!-- Modal Usuarios -->
    <div class="modal fade" id="modalUsuariosAdmin" tabindex="-1" aria-labelledby="modalUsuariosAdminLabel" aria-hidden="true">
      <div class="modal-dialog modal-xl">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Usuarios Registrados</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
          </div>
          <div class="modal-body">
            <button class="btn btn-success btn-sm mb-3" data-bs-toggle="modal" data-bs-target="#modalAgregarUsuario">
              <i class="fas fa-plus"></i> Nuevo Usuario
            </button>
            <table class="table table-bordered table-hover">
              <thead class="table-dark">
                <tr>
                  <th>ID</th><th>Nombre</th><th>Email</th><th>Teléfono</th><th>Rol</th><th>Activo</th><th>Acciones</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="usr" items="${usuarios}">
                  <tr>
                    <td>${usr.id}</td>
                    <td>${usr.nombre}</td>
                    <td>${usr.email}</td>
                    <td>${usr.telefono}</td>
                    <td>${usr.rol}</td>
                    <td>${usr.activo}</td>
                    <td>
                      <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#modalEditarUsuario${usr.id}">Editar</button>
                      <form action="${pageContext.request.contextPath}/usuarios" method="post" style="display:inline">
                        <input type="hidden" name="accion" value="eliminar"/>
                        <input type="hidden" name="id" value="${usr.id}"/>
                        <button class="btn btn-danger btn-sm">Eliminar</button>
                      </form>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
          </div>
        </div>
      </div>
    </div>

    <!-- Agregar Usuario -->
    <div class="modal fade" id="modalAgregarUsuario" tabindex="-1" aria-labelledby="modalAgregarUsuarioLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <form action="${pageContext.request.contextPath}/usuarios" method="post">
            <input type="hidden" name="accion" value="agregar"/>
            <div class="modal-header">
              <h5 class="modal-title">Agregar Nuevo Usuario</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
            </div>
            <div class="modal-body">
              <div class="mb-3">
                <label class="form-label">Nombre</label>
                <input type="text" class="form-control" name="nombre" required/>
              </div>
              <div class="mb-3">
                <label class="form-label">Email</label>
                <input type="email" class="form-control" name="email" required/>
              </div>
              <div class="mb-3">
                <label class="form-label">Teléfono</label>
                <input type="tel" class="form-control" name="telefono"/>
              </div>
              <div class="mb-3">
                <label class="form-label">Contraseña</label>
                <input type="password" class="form-control" name="password" required/>
              </div>
              <div class="mb-3">
                <label class="form-label">Rol</label>
                <select class="form-select" name="rol">
                  <option value="USER">USER</option>
                  <option value="ADMIN">ADMIN</option>
                </select>
              </div>
              <div class="form-check">
                <input class="form-check-input" type="checkbox" id="usr_activo" name="activo" checked/>
                <label class="form-check-label" for="usr_activo">Activo</label>
              </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
              <button type="submit" class="btn btn-primary">Guardar Usuario</button>
            </div>
          </form>
        </div>
      </div>
    </div>

    <!-- Editar Usuario -->
    <c:forEach var="usr" items="${usuarios}">
      <div class="modal fade" id="modalEditarUsuario${usr.id}" tabindex="-1" aria-labelledby="modalEditarUsuarioLabel${usr.id}" aria-hidden="true">
        <div class="modal-dialog">
          <div class="modal-content">
            <form action="${pageContext.request.contextPath}/usuarios" method="post">
              <input type="hidden" name="accion" value="editar"/>
              <input type="hidden" name="id" value="${usr.id}"/>
              <div class="modal-header">
                <h5 class="modal-title">Editar Usuario: ${usr.nombre}</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
              </div>
              <div class="modal-body">
                <div class="mb-3">
                  <label class="form-label">Nombre</label>
                  <input type="text" class="form-control" name="nombre" value="${usr.nombre}" required/>
                </div>
                <div class="mb-3">
                  <label class="form-label">Email</label>
                  <input type="email" class="form-control" name="email" value="${usr.email}" required/>
                </div>
                <div class="mb-3">
                  <label class="form-label">Teléfono</label>
                  <input type="tel" class="form-control" name="telefono" value="${usr.telefono}"/>
                </div>
                <div class="mb-3">
                  <label class="form-label">Rol</label>
                  <select class="form-select" name="rol">
                    <option value="USER" <c:if test="${usr.rol=='USER'}">selected</c:if>>USER</option>
                    <option value="ADMIN" <c:if test="${usr.rol=='ADMIN'}">selected</c:if>>ADMIN</option>
                  </select>
                </div>
                <div class="form-check mb-3">
                  <input class="form-check-input" type="checkbox" id="usr_activo_${usr.id}" name="activo" <c:if test="${usr.activo}">checked</c:if>/>
                  <label class="form-check-label" for="usr_activo_${usr.id}">Activo</label>
                </div>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button type="submit" class="btn btn-success">Guardar Cambios</button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </c:forEach>

    <!-- Modal Administrar Reservas -->
    <div class="modal fade" id="modalAdminReservas" tabindex="-1" aria-labelledby="modalAdminReservasLabel" aria-hidden="true">
      <div class="modal-dialog modal-xl">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Reservas Registradas</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
          </div>
          <div class="modal-body">
            <table class="table table-bordered table-hover">
              <thead class="table-dark">
                <tr>
                  <th>ID</th><th>Usuario</th><th>Función</th><th>Asiento</th><th>Cantidad</th><th>Total</th><th>Estado</th><th>Fecha Reserva</th><th>Acciones</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="res" items="${reservas}">
                  <tr>
                    <td>${res.id}</td>
                    <td>${res.usuario.nombre}</td>
                    <td>${res.funcionId}</td>
                    <td>${res.asiento != null ? res.asiento : '-'}</td>
                    <td>${res.cantidad}</td>
                    <td>${res.total}</td>
                    <td>${res.estado}</td>
                    <td><fmt:formatDate value="${res.fechaReserva}" pattern="dd/MM/yyyy HH:mm"/></td>
                    <td>
                      <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#modalEditarReserva${res.id}">Editar</button>
                      <form action="${pageContext.request.contextPath}/reservas" method="post" style="display:inline">
                        <input type="hidden" name="accion" value="eliminar"/>
                        <input type="hidden" name="id" value="${res.id}"/>
                        <button class="btn btn-danger btn-sm">Eliminar</button>
                      </form>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
          </div>
        </div>
      </div>
    </div>

    <!-- Editar Reserva -->
    <c:forEach var="res" items="${reservas}">
      <div class="modal fade" id="modalEditarReserva${res.id}" tabindex="-1" aria-labelledby="modalEditarReservaLabel${res.id}" aria-hidden="true">
        <div class="modal-dialog">
          <div class="modal-content">
            <form action="${pageContext.request.contextPath}/reservas" method="post">
              <input type="hidden" name="accion" value="editar"/>
              <input type="hidden" name="id" value="${res.id}"/>
              <div class="modal-header">
                <h5 class="modal-title">Editar Reserva #${res.id}</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
              </div>
              <div class="modal-body">
                <div class="mb-3">
                  <label class="form-label">Estado</label>
                  <select class="form-select" name="estado">
                    <option value="CONFIRMADA" <c:if test="${res.estado=='CONFIRMADA'}">selected</c:if>>Confirmada</option>
                    <option value="CANCELADA"  <c:if test="${res.estado=='CANCELADA'}">selected</c:if>>Cancelada</option>
                    <option value="REEMBOLSADA"<c:if test="${res.estado=='REEMBOLSADA'}">selected</c:if>>Reembolsada</option>
                  </select>
                </div>
                <div class="mb-3">
                  <label class="form-label">Asiento</label>
                  <input type="text" class="form-control" name="asiento" value="${res.asiento}"/>
                </div>
                <div class="mb-3">
                  <label class="form-label">Cantidad</label>
                  <input type="number" class="form-control" name="cantidad" value="${res.cantidad}"/>
                </div>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button type="submit" class="btn btn-success">Guardar Cambios</button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </c:forEach>

    <footer class="mt-5">
      <div class="footer-content text-center py-3">© CineReserva</div>
    </footer>

    <script>
      // Script para pestañas
      const tabs = document.querySelectorAll('.tab');
      const tabContents = document.querySelectorAll('.tab-content');
      tabs.forEach((tab, i) => {
        tab.addEventListener('click', () => {
          tabs.forEach(t=>t.classList.remove('active'));
          tabContents.forEach(c=>c.classList.remove('active'));
          tab.classList.add('active');
          tabContents[i].classList.add('active');
        });
      });
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>
