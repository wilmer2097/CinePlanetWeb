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
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/resources/perfil.css" />
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
          </div>

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
                    
                    <!-- Aquí irían los otros tab-contents de Reservas y Estadísticas -->
                    
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
</body>
</html>
