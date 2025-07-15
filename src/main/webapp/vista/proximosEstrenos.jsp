<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>CinePlanet – Próximos Estrenos</title>
  <link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
    rel="stylesheet" crossorigin="anonymous"/>
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
            <a class="nav-link" 
               href="${pageContext.request.contextPath}/peliculasAnio">
              Películas de este año
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link active"
               href="${pageContext.request.contextPath}/proximosEstrenos">
              Próximos Estrenos
            </a>
          </li>
        </ul>
      </div>
    </div>
  </nav>

  <main class="container my-5 flex-grow-1">
    <h2 class="mb-4">Próximos Estrenos</h2>

    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-4">
      <c:choose>
        <c:when test="${empty peliculasProximas}">
          <div class="alert alert-warning">No hay próximos estrenos.</div>
        </c:when>
        <c:otherwise>
          <c:forEach var="movie" items="${peliculasProximas}" varStatus="st">
            <div class="col">
              <div class="card h-100 shadow-sm hover-shadow">
                <c:choose>
                  <c:when test="${not empty movie.posterPath}">
                    <img src="https://image.tmdb.org/t/p/w500${movie.posterPath}"
                         class="card-img-top" alt="${movie.title}" />
                  </c:when>
                  <c:otherwise>
                    <img src="https://via.placeholder.com/500x750?text=Sin+imagen"
                         class="card-img-top" alt="Sin imagen" />
                  </c:otherwise>
                </c:choose>
                <div class="card-body d-flex flex-column">
                  <h5 class="card-title">${movie.title}</h5>
                  <p class="text-muted small mb-2">${movie.releaseDate}</p>
                  <p class="card-text small">
                    <c:choose>
                      <c:when test="${fn:length(movie.overview) > 100}">
                        ${fn:substring(movie.overview, 0, 100)}…
                      </c:when>
                      <c:otherwise>${movie.overview}</c:otherwise>
                    </c:choose>
                  </p>
                  <button type="button"
                          class="btn btn-primary mt-auto"
                          data-bs-toggle="modal"
                          data-bs-target="#modal${st.index}">
                    Ver detalles
                  </button>
                </div>
              </div>
            </div>

            <!-- Modal por película -->
            <div class="modal fade" id="modal${st.index}" tabindex="-1"
                 aria-labelledby="tituloModal${st.index}" aria-hidden="true">
              <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content">
                  <div class="modal-header">
                    <h5 class="modal-title" id="tituloModal${st.index}">
                      ${movie.title}
                    </h5>
                    <button type="button" class="btn-close"
                            data-bs-dismiss="modal" aria-label="Cerrar"></button>
                  </div>
                  <div class="modal-body">
                    <div class="text-center mb-3">
                      <c:choose>
                        <c:when test="${not empty movie.posterPath}">
                          <img src="https://image.tmdb.org/t/p/w500${movie.posterPath}"
                               class="img-fluid rounded" alt="${movie.title}" />
                        </c:when>
                        <c:otherwise>
                          <img src="https://via.placeholder.com/500x750?text=Sin+imagen"
                               class="img-fluid rounded" alt="Sin imagen" />
                        </c:otherwise>
                      </c:choose>
                    </div>
                    <p><strong>Fecha de estreno:</strong> ${movie.releaseDate}</p>
                    <p><strong>Descripción completa:</strong></p>
                    <p>${movie.overview}</p>
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-secondary"
                            data-bs-dismiss="modal">Cerrar</button>
                  </div>
                </div>
              </div>
            </div>

          </c:forEach>
        </c:otherwise>
      </c:choose>
    </div>
  </main>

  <!-- FOOTER -->
  <footer class="bg-dark text-white py-4 mt-auto">
    <div class="container text-center">
      &copy; 2025 CinePlanet. Todos los derechos reservados.
    </div>
  </footer>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
          crossorigin="anonymous"></script>
</body>
</html>
