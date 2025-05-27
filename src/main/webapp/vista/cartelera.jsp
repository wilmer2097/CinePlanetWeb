<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>CinePlanet – Cartelera</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous"/>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/cartelera.css" />
</head>
<body class="d-flex flex-column min-vh-100">

  <!-- NAVBAR -->
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
      <a class="navbar-brand" href="${pageContext.request.contextPath}/cartelera">CinePlanet</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav me-auto">
          <li class="nav-item">
            <a class="nav-link ${pageContext.request.requestURI.endsWith("/cartelera")?'active':''}" href="${pageContext.request.contextPath}/cartelera">Cartelera</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/proximos">Próximos Estrenos</a>
          </li>
          <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/cines">Cines</a></li>
          <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/vista/promociones.html">Promociones</a></li>
          <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/ver-anexos">Ver Anexos</a></li>
          <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/preguntas-frecuentes">FAQ</a></li>
        </ul>
        <form class="d-flex" action="${pageContext.request.contextPath}/buscar" method="get">
          <input class="form-control me-2" type="search" name="q" placeholder="Buscar películas…">
          <button class="btn btn-outline-light">Buscar</button>
        </form>
        <a class="btn btn-primary ms-3" href="${pageContext.request.contextPath}/profile">Mi Cuenta</a>
      </div>
    </div>
  </nav>

  <main class="container my-5 flex-grow-1">

    <!-- HERO -->
    <c:if test="${not empty funcionesHoy}">
      <c:set var="hero" value="${funcionesHoy[0]}" />
      <section class="hero-section mb-5 position-relative text-white rounded"
               style="background-image:url('${hero.imgUrl}');">
        <div class="overlay position-absolute w-100 h-100 rounded"></div>
        <div class="hero-content position-relative text-center py-5">
          <h1 class="display-4 fw-bold">${hero.titulo}</h1>
          <p class="lead mx-auto w-75">
            <c:set var="text" value="${not empty hero.sinopsis ? hero.sinopsis : 'Sinopsis no disponible.'}" />
            <c:choose>
              <c:when test="${fn:length(text) > 150}">
                ${fn:substring(text, 0, 150)}&hellip;
              </c:when>
              <c:otherwise>${text}</c:otherwise>
            </c:choose>
          </p>
          <a href="${pageContext.request.contextPath}/reservar?funcionId=${hero.funcionId}" class="btn btn-lg btn-primary">Ver Horarios</a>
        </div>
      </section>
    </c:if>

    <!-- FILTROS -->
    <form class="row row-cols-1 row-cols-md-6 g-3 mb-5" method="get" action="${pageContext.request.contextPath}/cartelera">
      <c:forEach var="key" items="${filtros.keySet()}">
        <div class="col">
          <select class="form-select" name="${key}">
            <option value="">${fn:toUpperCase(key)}</option>
            <c:forEach var="opt" items="${filtros[key]}">
              <option value="${opt}" ${param[key]==opt?'selected':''}>${opt}</option>
            </c:forEach>
          </select>
        </div>
      </c:forEach>
      <div class="col d-grid">
        <button class="btn btn-primary">Aplicar</button>
      </div>
    </form>

    <!-- CARTELERA HOY -->
    <h2 class="mb-4">En Cartelera Hoy</h2>

    <!-- CARROUSEL -->
    <div id="carouselHoyTop" class="carousel slide mb-5" data-bs-ride="carousel">
      <div class="carousel-inner">
        <c:forEach var="f" items="${funcionesHoy}" varStatus="st">
          <div class="carousel-item ${st.first?'active':''}">
            <div class="position-relative" style="max-height:400px; overflow:hidden;">
              <img src="${f.imgUrl}" class="d-block w-100" alt="${f.titulo}" style="object-fit:cover; height:400px;">
              <div class="carousel-caption d-none d-md-block bg-dark bg-opacity-50 rounded px-3 py-2">
                <h5 class="mb-1">${f.titulo}</h5>
                <p class="small mb-2">
                  <fmt:formatDate value="${f.fechaHora}" pattern="dd MMM yyyy, HH:mm"/>
                </p>
                <a href="${pageContext.request.contextPath}/reservar?funcionId=${f.funcionId}" class="btn btn-sm btn-primary">Reservar</a>
              </div>
            </div>
          </div>
        </c:forEach>
      </div>
      <button class="carousel-control-prev" type="button" data-bs-target="#carouselHoyTop" data-bs-slide="prev">
        <span class="carousel-control-prev-icon"></span>
      </button>
      <button class="carousel-control-next" type="button" data-bs-target="#carouselHoyTop" data-bs-slide="next">
        <span class="carousel-control-next-icon"></span>
      </button>
    </div>

    <!-- Tarjetas cartelera -->
    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-4 mb-5">
      <c:forEach var="f" items="${funcionesHoy}">
        <div class="col">
          <div class="card h-100 shadow-sm hover-shadow">
            <img src="${f.imgUrl}" class="card-img-top" alt="${f.titulo}">
            <div class="card-body d-flex flex-column">
              <h5 class="card-title">${f.titulo}</h5>
              <p class="text-muted small mb-3">
                <fmt:formatDate value="${f.fechaHora}" pattern="dd MMM yyyy, HH:mm"/>
              </p>
              <a href="${pageContext.request.contextPath}/reservar?funcionId=${f.funcionId}" class="btn btn-primary mt-auto">Reservar</a>
            </div>
          </div>
        </div>
      </c:forEach>
    </div>

    <!-- PRÓXIMOS ESTRENOS -->
    <h2 class="mb-4">Próximos Estrenos</h2>
    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-4 mb-5">
      <c:forEach var="p" items="${proximosEstrenos}">
        <div class="col">
          <div class="card h-100 shadow-sm hover-shadow">
            <img src="${p.imgUrl}" class="card-img-top" alt="${p.titulo}">
            <div class="card-body d-flex flex-column">
              <h5 class="card-title">${p.titulo}</h5>
              <p class="text-muted small mb-2">${p.estreno}</p>
              <p class="card-text small">
                <c:choose>
                  <c:when test="${fn:length(p.sinopsis) > 100}">
                    ${fn:substring(p.sinopsis, 0, 100)}&hellip;
                  </c:when>
                  <c:otherwise>${p.sinopsis}</c:otherwise>
                </c:choose>
              </p>
              <a href="#" class="btn btn-outline-primary mt-auto disabled">Pre-reserva</a>
            </div>
          </div>
        </div>
      </c:forEach>
    </div>

    <!-- RECOMENDADOS -->
    <h2 class="mb-4">Recomendados para ti</h2>
    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-4">
      <c:forEach var="r" items="${recomendados}">
        <div class="col">
          <div class="card h-100 shadow-sm hover-shadow">
            <img src="${r.imgUrl}" class="card-img-top" alt="${r.titulo}">
            <div class="card-body d-flex flex-column">
              <h5 class="card-title">${r.titulo}</h5>
              <a href="${pageContext.request.contextPath}/reservar?funcionId=${r.funcionId}" class="btn btn-primary mt-auto">Reservar</a>
            </div>
          </div>
        </div>
      </c:forEach>
    </div>

  </main>

  <!-- FOOTER -->
  <footer class="bg-dark text-white py-4 mt-auto">
    <div class="container text-center">
      &copy; 2025 CinePlanet. Todos los derechos reservados.
    </div>
  </footer>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>
