<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Registro – CinePlanet</title>
  <link rel="stylesheet"
        href="${pageContext.request.contextPath}/resources/styles_log.css" />
</head>
<body>
  <div class="container">
    <form action="${pageContext.request.contextPath}/register" method="post">
      <img src="https://www.greatplacetowork.com.pe/images/certification/companies/cineplanet/logo.png"
           alt="Logo Cineplanet" class="logo">
      <h1>Crear Cuenta</h1>

      <c:if test="${not empty error}">
        <div class="error-message">${error}</div>
      </c:if>

      <div class="input-group">
        <input type="text" name="nombre" placeholder="Nombre de usuario"
               value="${prevNombre}" required />
      </div>
      <div class="input-group">
        <input type="email" name="email" placeholder="Correo electrónico"
               value="${prevEmail}" required />
      </div>
      <div class="input-group">
        <input type="text" name="telefono" placeholder="Teléfono"
               value="${prevTelefono}" required />
      </div>
      <div class="input-group">
        <input type="password" name="password" placeholder="Contraseña" required />
      </div>
      <div class="input-group">
        <input type="password" name="confirmPassword"
               placeholder="Confirmar contraseña" required />
      </div>

      <div class="btn-group">
        <button type="submit" class="btn primary">Registrarse</button>
        <button type="button" class="btn secondary"
                onclick="window.location='${pageContext.request.contextPath}/login'">
          Iniciar Sesión
        </button>
      </div>
    </form>
  </div>
</body>
</html>
