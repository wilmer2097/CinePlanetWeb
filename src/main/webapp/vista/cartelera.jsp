<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>CinePlanet – Cartelera</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
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
            <section class="hero">
                <div id="carouselExampleAutoplaying" class="carousel slide" data-bs-ride="carousel">
                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <img src="..." class="d-block w-100" alt="...">
                        </div>
                        <div class="carousel-item">
                            <img src="..." class="d-block w-100" alt="...">
                        </div>
                        <div class="carousel-item">
                            <img src="..." class="d-block w-100" alt="...">
                        </div>
                    </div>
                    <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleAutoplaying" data-bs-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Previous</span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleAutoplaying" data-bs-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Next</span>
                    </button>
                </div>
                <div class="hero-content">
                    <h1 class="hero-title">Dune: Parte 2</h1>
                    <p class="hero-desc">Paul Atreides se alía con Chani y los fremen en busca de venganza y decide luchar por impedir un futuro terrible que solo él puede prever.</p>
                    <button class="btn btn-primary">Ver Horarios</button>
                </div>
            </section>

            <section class="filters">
                <div class="filter-header">
                    <h2 class="filter-title">Filtros</h2>
                    <button class="btn btn-primary">Aplicar</button>
                </div>
                <div class="filter-options">
                    <select class="filter-select">
                        <option>Ciudad</option>
                        <option>Madrid</option>
                        <option>Barcelona</option>
                        <option>Valencia</option>
                        <option>Sevilla</option>
                    </select>
                    <select class="filter-select">
                        <option>Cine</option>
                        <option>Cinesa</option>
                        <option>Yelmo</option>
                        <option>Kinepolis</option>
                        <option>Odeon</option>
                    </select>
                    <select class="filter-select">
                        <option>Día</option>
                        <option>Hoy</option>
                        <option>Mañana</option>
                        <option>Viernes 25</option>
                        <option>Sábado 26</option>
                    </select>
                    <select class="filter-select">
                        <option>Género</option>
                        <option>Acción</option>
                        <option>Comedia</option>
                        <option>Drama</option>
                        <option>Terror</option>
                    </select>
                    <select class="filter-select">
                        <option>Idioma</option>
                        <option>Español</option>
                        <option>V.O. Subtitulada</option>
                        <option>Doblada</option>
                    </select>
                    <select class="filter-select">
                        <option>Formato</option>
                        <option>2D</option>
                        <option>3D</option>
                        <option>IMAX</option>
                        <option>4DX</option>
                    </select>
                    <select class="filter-select">
                        <option>Censura</option>
                        <option>Todos los públicos</option>
                        <option>+7</option>
                        <option>+12</option>
                        <option>+16</option>
                        <option>+18</option>
                    </select>
                </div>
            </section>

            <h2 class="section-title">En Cartelera Hoy</h2>
            <section class="carousel">
                <div class="carousel-container">
                    <div class="movie-card">
                        <img src="https://images.cdn.prd.api.discomax.com/2024/07/12/104954ab-55cf-3d15-931b-c53b15473b15.jpeg?w=2000&f=webp" alt="Película" class="movie-poster">
                        <div class="movie-info">
                            <h3 class="movie-title">Dune: Parte 2</h3>
                            <div class="movie-meta">
                                <span>Sci-Fi</span>
                                <div class="movie-rating">
                                    <span class="star">★</span>
                                    <span>4.8</span>
                                </div>
                            </div>
                            <div class="formats">
                                <span class="format-tag">2D</span>
                                <span class="format-tag">3D</span>
                                <span class="format-tag">IMAX</span>
                            </div>
                            <button class="btn-book">Reservar</button>
                        </div>
                    </div>

                    <div class="movie-card">
                        <img src="https://cdn.apis.cineplanet.com.pe/CDN/media/entity/get/FilmPosterGraphic/HO00002290?referenceScheme=HeadOffice&allowPlaceHolder=true" alt="Película" class="movie-poster">

                        <div class="movie-info">
                            <h3 class="movie-title">Una Película de Minecraft</h3>
                            <div class="movie-meta">
                                <span>Animación</span>
                                <div class="movie-rating">
                                    <span class="star">★</span>
                                    <span>4.5</span>
                                </div>
                            </div>
                            <div class="formats">
                                <span class="format-tag">2D</span>
                                <span class="format-tag">3D</span>
                            </div>
                            <button class="btn-book">Reservar</button>
                        </div>
                    </div>

                    <div class="movie-card">
                        <img src="https://cdn.apis.cineplanet.com.pe/CDN/media/entity/get/FilmPosterGraphic/HO00002325?referenceScheme=HeadOffice&allowPlaceHolder=true" alt="Película" class="movie-poster">
                        <div class="movie-info">
                            <h3 class="movie-title">El Amateur: Operación Venganza</h3>
                            <div class="movie-meta">
                                <span>Thriller</span>
                                <div class="movie-rating">
                                    <span class="star">★</span>
                                    <span>4.3</span>
                                </div>
                            </div>
                            <div class="formats">
                                <span class="format-tag">2D</span>
                                <span class="format-tag">4DX</span>
                            </div>
                            <button class="btn-book">Reservar</button>
                        </div>
                    </div>

                    <div class="movie-card">
                        <img src="https://cdn.apis.cineplanet.com.pe/CDN/media/entity/get/FilmPosterGraphic/HO00002314?referenceScheme=HeadOffice&allowPlaceHolder=true" alt="Película" class="movie-poster">
                        <div class="movie-info">
                            <h3 class="movie-title">Betterman: La Historia de Robbie Williams</h3>
                            <div class="movie-meta">
                                <span>Biografía</span>
                                <div class="movie-rating">
                                    <span class="star">★</span>
                                    <span>4.9</span>
                                </div>
                            </div>
                            <div class="formats">
                                <span class="format-tag">2D</span>
                                <span class="format-tag">3D</span>
                            </div>
                            <button class="btn-book">Reservar</button>
                        </div>
                    </div>

                    <div class="movie-card">
                        <img src="https://cdn.apis.cineplanet.com.pe/CDN/media/entity/get/FilmPosterGraphic/HO00002354?referenceScheme=HeadOffice&allowPlaceHolder=true" alt="Película" class="movie-poster">
                        <div class="movie-info">
                            <h3 class="movie-title">Soltera, Casada, Viuda, Divorciada 2</h3>
                            <div class="movie-meta">
                                <span>Acción</span>
                                <div class="movie-rating">
                                    <span class="star">★</span>
                                    <span>4.2</span>
                                </div>
                            </div>
                            <div class="formats">
                                <span class="format-tag">2D</span>
                                <span class="format-tag">IMAX</span>
                            </div>
                            <button class="btn-book">Reservar</button>
                        </div>
                    </div>
                </div>
                <div class="carousel-nav carousel-prev">❮</div>
                <div class="carousel-nav carousel-next">❯</div>
            </section>

            <h2 class="section-title">Próximos Estrenos</h2>
            <section class="carousel">
                <div class="carousel-container">
                    <div class="movie-card">
                        <img src="https://cdn.apis.cineplanet.com.pe/CDN/media/entity/get/FilmPosterGraphic/HO00002389?referenceScheme=HeadOffice&allowPlaceHolder=true" alt="Película" class="movie-poster">
                        <div class="movie-info">
                            <h3 class="movie-title">El Contador 2</h3>
                            <div class="movie-meta">
                                <span>Estreno: 24 Abril</span>
                            </div>
                            <div class="formats">
                                <span class="format-tag">2D</span>
                                <span class="format-tag">3D</span>
                                <span class="format-tag">IMAX</span>
                            </div>
                            <button class="btn-book">Pre-reserva</button>
                        </div>
                    </div>

                    <div class="movie-card">
                        <img src="https://cdn.apis.cineplanet.com.pe/CDN/media/entity/get/FilmPosterGraphic/HO00002395?referenceScheme=HeadOffice&allowPlaceHolder=true" alt="Película" class="movie-poster">
                        <div class="movie-info">
                            <h3 class="movie-title">El día que la tierra explotó: Looney Tunes</h3>
                            <div class="movie-meta">
                                <span>Estreno: 24 Abril</span>
                            </div>
                            <div class="formats">
                                <span class="format-tag">2D</span>
                                <span class="format-tag">3D</span>
                            </div>
                            <button class="btn-book">Pre-reserva</button>
                        </div>
                    </div>

                    <div class="movie-card">
                        <img src="https://cdn.apis.cineplanet.com.pe/CDN/media/entity/get/FilmPosterGraphic/HO00002418?referenceScheme=HeadOffice&allowPlaceHolder=true" alt="Película" class="movie-poster">
                        <div class="movie-info">
                            <h3 class="movie-title">Megatormenta</h3>
                            <div class="movie-meta">
                                <span>Estreno: 24 Abril</span>
                            </div>
                            <div class="formats">
                                <span class="format-tag">3D</span>
                                <span class="format-tag">IMAX</span>
                            </div>
                            <button class="btn-book">Pre-reserva</button>
                        </div>
                    </div>

                    <div class="movie-card">
                        <img src="https://cdn.apis.cineplanet.com.pe/CDN/media/entity/get/FilmPosterGraphic/HO00002410?referenceScheme=HeadOffice&allowPlaceHolder=true" alt="Película" class="movie-poster">
                        <div class="movie-info">
                            <h3 class="movie-title">Pink Floyd At Pompeii</h3>
                            <div class="movie-meta">
                                <span>Estreno: 24 Abril</span>
                            </div>
                            <div class="formats">
                                <span class="format-tag">2D</span>
                                <span class="format-tag">4DX</span>
                            </div>
                            <button class="btn-book">Pre-reserva</button>
                        </div>
                    </div>

                    <div class="movie-card">
                        <img src="https://cdn.apis.cineplanet.com.pe/CDN/media/entity/get/FilmPosterGraphic/HO00002252?referenceScheme=HeadOffice&allowPlaceHolder=true" alt="Película" class="movie-poster">
                        <div class="movie-info">
                            <h3 class="movie-title">Thunderbolts</h3>
                            <div class="movie-meta">
                                <span>Estreno: 5 Mayo</span>
                            </div>
                            <div class="formats">
                                <span class="format-tag">2D</span>
                                <span class="format-tag">XTREME</span>
                            </div>
                            <button class="btn-book">Pre-reserva</button>
                        </div>
                    </div>
                </div>
                <div class="carousel-nav carousel-prev">❮</div>
                <div class="carousel-nav carousel-next">❯</div>
            </section>

            <h2 class="section-title">Recomendados para ti</h2>
            <section class="carousel">
                <div class="carousel-container">
                    <div class="movie-card">
                        <img src="https://cdn.apis.cineplanet.com.pe/CDN/media/entity/get/FilmPosterGraphic/HO00002384?referenceScheme=HeadOffice&allowPlaceHolder=true" alt="Película" class="movie-poster">
                        <div class="movie-info">
                            <h3 class="movie-title">Terremoto Magnitud 9.0</h3>
                            <div class="movie-meta">
                                <span>Acción</span>
                                <div class="movie-rating">
                                    <span class="star">★</span>
                                    <span>4.4</span>
                                </div>
                            </div>
                            <div class="formats">
                                <span class="format-tag">2D</span>
                            </div>
                            <button class="btn-book">Reservar</button>
                        </div>
                    </div>

                    <div class="movie-card">
                        <img src="https://cdn.apis.cineplanet.com.pe/CDN/media/entity/get/FilmPosterGraphic/HO00002324?referenceScheme=HeadOffice&allowPlaceHolder=true" alt="Película" class="movie-poster">
                        <div class="movie-info">
                            <h3 class="movie-title">Blanca Nieves</h3>
                            <div class="movie-meta">
                                <span>Familiar</span>
                                <div class="movie-rating">
                                    <span class="star">★</span>
                                    <span>4.1</span>
                                </div>
                            </div>
                            <div class="formats">
                                <span class="format-tag">2D</span>
                            </div>
                            <button class="btn-book">Reservar</button>
                        </div>
                    </div>

                    <div class="movie-card">
                        <img src="https://cdn.apis.cineplanet.com.pe/CDN/media/entity/get/FilmPosterGraphic/HO00002388?referenceScheme=HeadOffice&allowPlaceHolder=true" alt="Película" class="movie-poster">
                        <div class="movie-info">
                            <h3 class="movie-title">Rescate Implacable</h3>
                            <div class="movie-meta">
                                <span>Acción</span>
                                <div class="movie-rating">
                                    <span class="star">★</span>
                                    <span>4.7</span>
                                </div>
                            </div>
                            <div class="formats">
                                <span class="format-tag">2D</span>
                                <span class="format-tag">3D</span>
                            </div>
                            <button class="btn-book">Reservar</button>
                        </div>
                    </div>

                    <div class="movie-card">
                        <img src="https://cdn.apis.cineplanet.com.pe/CDN/media/entity/get/FilmPosterGraphic/HO00002376?referenceScheme=HeadOffice&allowPlaceHolder=true" alt="Película" class="movie-poster">
                        <div class="movie-info">
                            <h3 class="movie-title">Hijos del Exorcismo</h3>
                            <div class="movie-meta">
                                <span>Terror</span>
                                <div class="movie-rating">
                                    <span class="star">★</span>
                                    <span>4.0</span>
                                </div>
                            </div>
                            <div class="formats">
                                <span class="format-tag">2D</span>
                            </div>
                            <button class="btn-book">Reservar</button>
                        </div>
                    </div>

                    <div class="movie-card">
                        <img src="https://cdn.apis.cineplanet.com.pe/CDN/media/entity/get/FilmPosterGraphic/HO00002309?referenceScheme=HeadOffice&allowPlaceHolder=true" alt="Película" class="movie-poster">
                        <div class="movie-info">
                            <h3 class="movie-title">Sonic 3 La Pelicula</h3>
                            <div class="movie-meta">
                                <span>Familiar</span>
                                <div class="movie-rating">
                                    <span class="star">★</span>
                                    <span>4.6</span>
                                </div>
                            </div>
                            <div class="formats">
                                <span class="format-tag">2D</span>
                            </div>
                            <button class="btn-book">Reservar</button>
                        </div>
                    </div>
                </div>
                <div class="carousel-nav carousel-prev">❮</div>
                <div class="carousel-nav carousel-next">❯</div>
            </section>
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

            <div class="copyright">CinePlanet
                <p>&copy; 2025 CinePlanet. Todos los derechos reservados.</p>
            </div>
        </footer>

        <script>
            // Script para hacer funcionales los carruseles
            document.querySelectorAll('.carousel-next').forEach(button => {
                button.addEventListener('click', () => {
                    const container = button.parentElement.querySelector('.carousel-container');
                    container.scrollLeft += 300;
                });
            });

            document.querySelectorAll('.carousel-prev').forEach(button => {
                button.addEventListener('click', () => {
                    const container = button.parentElement.querySelector('.carousel-container');
                    container.scrollLeft -= 300;
                });
            });
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js" integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO" crossorigin="anonymous"></script>
    </body>
</html>