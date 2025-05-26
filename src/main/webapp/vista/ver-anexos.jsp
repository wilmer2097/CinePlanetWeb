<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>CinePlanet – Ver Anexos</title>
  <link rel="stylesheet"
        href="${pageContext.request.contextPath}/resources/cartelera.css" />
</head>
<body>
  <header>
    <nav class="navbar">
      <div class="logo">
        <a href="${pageContext.request.contextPath}/cartelera">CinePlanet</a>
      </div>
      <div class="nav-links">
        <a href="${pageContext.request.contextPath}/cartelera" class="nav-link">Cartelera</a>
        <a href="${pageContext.request.contextPath}/proximos" class="nav-link">Próximos Estrenos</a>
        <a href="${pageContext.request.contextPath}/cines" class="nav-link">Cines</a>
        <a href="${pageContext.request.contextPath}/vista/promociones.html" class="nav-link">Promociones</a>
        <a href="${pageContext.request.contextPath}/ver-anexos" class="nav-link active">Ver Anexos</a>
        <a href="${pageContext.request.contextPath}/preguntas-frecuentes" class="nav-link">Preguntas Frecuentes</a>
      </div>
      <div class="user-actions">
        <form action="${pageContext.request.contextPath}/buscar" method="get" class="search-box">
          <input type="text" name="q" placeholder="Buscar películas…" />
        </form>
        <a href="${pageContext.request.contextPath}/profile" class="btn btn-primary">Mi Cuenta</a>
      </div>
    </nav>
  </header>

  <main>
    <div class="page-header">
      <h1 class="page-title">Ver Anexos</h1>
      <p class="page-description">Comparte tus sugerencias o presenta una reclamación formal</p>
    </div>

    <!-- Mensajes de éxito o error -->
    <c:if test="${param.mensaje == 'ok'}">
      <div class="alert alert-success">
        ¡Tu reclamación se ha enviado correctamente!
      </div>
    </c:if>
    <c:if test="${param.mensaje == 'error'}">
      <div class="alert alert-error">
        Ocurrió un error al enviar tu reclamación. Por favor, inténtalo de nuevo.
      </div>
    </c:if>

    <div class="forms-container">
      <!-- Formulario de Sugerencias -->
      <section class="form-section">
        <div class="form-header">
          <h2 class="form-title">📝 Formulario de Sugerencias</h2>
          <p class="form-subtitle">Ayúdanos a mejorar tu experiencia en CinePlanet</p>
        </div>
        <form class="suggestion-form"
              action="${pageContext.request.contextPath}/procesar-sugerencia"
              method="post">
          <div class="form-group">
            <label for="nombre-sugerencia" class="form-label">Nombre completo</label>
            <input type="text" id="nombre-sugerencia" name="nombre" class="form-input" required>
          </div>
          <div class="form-group">
            <label for="email-sugerencia" class="form-label">Correo electrónico</label>
            <input type="email" id="email-sugerencia" name="email" class="form-input" required>
          </div>
          <div class="form-group">
            <label for="telefono-sugerencia" class="form-label">Teléfono (opcional)</label>
            <input type="tel" id="telefono-sugerencia" name="telefono" class="form-input">
          </div>
          <div class="form-group">
            <label for="categoria-sugerencia" class="form-label">Categoría</label>
            <select id="categoria-sugerencia" name="categoria" class="form-select" required>
              <option value="">Selecciona una categoría</option>
              <option value="servicio-cliente">Servicio al Cliente</option>
              <option value="instalaciones">Instalaciones</option>
              <option value="cartelera">Cartelera y Películas</option>
              <option value="precios">Precios y Promociones</option>
              <option value="tecnologia">Tecnología y App</option>
              <option value="otros">Otros</option>
            </select>
          </div>
          <div class="form-group">
            <label for="sugerencia" class="form-label">Tu sugerencia</label>
            <textarea id="sugerencia" name="sugerencia" class="form-textarea" rows="5"
                      placeholder="Comparte tu idea para mejorar nuestro servicio..." required></textarea>
          </div>
          <button type="submit" class="btn btn-primary btn-form">Enviar Sugerencia</button>
        </form>
      </section>

      <!-- Formulario de Reclamaciones -->
      <section class="form-section">
        <div class="form-header">
          <h2 class="form-title">📋 Libro de Reclamaciones</h2>
          <p class="form-subtitle">Presenta tu reclamación formal siguiendo los procedimientos establecidos</p>
        </div>
        <form class="complaint-form"
              action="${pageContext.request.contextPath}/procesar-reclamacion"
              method="post">
          <div class="form-group">
            <label for="nombre-reclamacion" class="form-label">Nombre completo *</label>
            <input type="text" id="nombre-reclamacion" name="nombre"
                   class="form-input" required>
          </div>
          <div class="form-row">
            <div class="form-group">
              <label for="dni-reclamacion" class="form-label">DNI/Documento *</label>
              <input type="text" id="dni-reclamacion" name="dni"
                     class="form-input" required>
            </div>
            <div class="form-group">
              <label for="telefono-reclamacion" class="form-label">Teléfono *</label>
              <input type="tel" id="telefono-reclamacion" name="telefono"
                     class="form-input" required>
            </div>
          </div>
          <div class="form-group">
            <label for="email-reclamacion" class="form-label">Correo electrónico *</label>
            <input type="email" id="email-reclamacion" name="email"
                   class="form-input" required>
          </div>
          <div class="form-group">
            <label for="direccion-reclamacion" class="form-label">Dirección</label>
            <input type="text" id="direccion-reclamacion" name="direccion"
                   class="form-input">
          </div>
          <div class="form-row">
            <div class="form-group">
              <label for="cine-reclamacion" class="form-label">Cine donde ocurrió el incidente</label>
              <select id="cine-reclamacion" name="cine" class="form-select">
                <option value="">Selecciona el cine</option>
                <option value="cineplanet-centro">CinePlanet Centro</option>
                <option value="cineplanet-norte">CinePlanet Norte</option>
                <option value="cineplanet-sur">CinePlanet Sur</option>
                <option value="cineplanet-este">CinePlanet Este</option>
                <option value="cineplanet-oeste">CinePlanet Oeste</option>
              </select>
            </div>
            <div class="form-group">
              <label for="fecha-incidente" class="form-label">Fecha del incidente</label>
              <input type="date" id="fecha-incidente" name="fecha"
                     class="form-input">
            </div>
          </div>
          <div class="form-group">
            <label for="tipo-reclamacion" class="form-label">Tipo de reclamación *</label>
            <select id="tipo-reclamacion" name="tipo" class="form-select" required>
              <option value="">Selecciona el tipo</option>
              <option value="reclamo">Reclamo</option>
              <option value="queja">Queja</option>
              <option value="sugerencia">Sugerencia</option>
            </select>
          </div>
          <div class="form-group">
            <label for="detalle-reclamacion" class="form-label">Detalle de la reclamación *</label>
            <textarea id="detalle-reclamacion" name="detalle" class="form-textarea" rows="6"
                      placeholder="Describe detalladamente el motivo de tu reclamación..."
                      required></textarea>
          </div>
          <div class="form-group">
            <label for="pedido-reclamacion" class="form-label">Pedido del consumidor</label>
            <textarea id="pedido-reclamacion" name="pedido" class="form-textarea" rows="3"
                      placeholder="Indica qué solicitas como solución a tu reclamo..."></textarea>
          </div>
          <div class="form-group checkbox-group">
            <label class="checkbox-label">
              <input type="checkbox" name="acepta-terminos" required>
              <span class="checkmark"></span>
              Acepto que la información proporcionada es veraz y autorizo el tratamiento de mis datos…
            </label>
          </div>
          <button type="submit" class="btn btn-primary btn-form">Enviar Reclamación</button>
        </form>
      </section>
    </div>
  </main>

  <footer>
    <div class="footer-content">
      <div class="footer-section">
        <h3 class="footer-title">CinePlanet</h3>
        <p>Tu app para reservar entradas de cine de forma fácil y rápida.</p>
      </div>
      <div class="footer-section">
        <h3 class="footer-title">Enlaces</h3>
        <ul class="footer-links">
          <li class="footer-link"><a href="#">Sobre nosotros</a></li>
          <li class="footer-link"><a href="#">Términos y condiciones</a></li>
          <li class="footer-link"><a href="#">Política de privacidad</a></li>
          <li class="footer-link"><a href="#">FAQ</a></li>
        </ul>
      </div>
      <div class="footer-section">
        <h3 class="footer-title">Contacto</h3>
        <ul class="footer-links">
          <li class="footer-link"><a href="#">Email</a></li>
          <li class="footer-link"><a href="#">Teléfono</a></li>
          <li class="footer-link"><a href="#">Soporte</a></li>
        </ul>
      </div>
    </div>
    <div class="copyright">
      CinePlanet <p>&copy; 2025 CinePlanet. Todos los derechos reservados.</p>
    </div>
  </footer>
</body>
</html>
