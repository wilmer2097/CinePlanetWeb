<%-- 
    Document   : navbar
    Created on : 14 jul 2025, 22:04:24
    Author     : wilme
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <div class="container">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/cartelera">CinePlanet</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav me-auto">
        <li class="nav-item">
          <a class="nav-link ${pageContext.request.requestURI.endsWith("/cartelera")?'active':''}"
             href="${pageContext.request.contextPath}/cartelera">
            Cartelera
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link"
             href="${pageContext.request.contextPath}/peliculasAnio?q=">
            Películas de este año
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/proximos">
            Próximos Estrenos
          </a>
        </li>
        <!-- …otros items… -->
      </ul>
      <form class="d-flex" action="${pageContext.request.contextPath}/peliculasAnio" method="get">
        <input class="form-control me-2"
               type="search"
               name="q"
               placeholder="Buscar películas…"
               value="${fn:escapeXml(searchQuery)}" />
        <button class="btn btn-primary">Buscar</button>
      </form>
    </div>
  </div>
</nav>

