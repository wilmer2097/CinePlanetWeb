<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>CinePlanet – Preguntas Frecuentes</title>
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
        <a href="${pageContext.request.contextPath}/ver-anexos" class="nav-link">Ver Anexos</a>
        <a href="${pageContext.request.contextPath}/preguntas-frecuentes" class="nav-link active">Preguntas Frecuentes</a>
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
      <h1 class="page-title">Preguntas Frecuentes</h1>
      <p class="page-description">Encuentra respuestas rápidas a las consultas más comunes</p>
    </div>

    <div class="faq-container">
      <div class="faq-category">
        <h2 class="faq-category-title">🎟️ Reservas y Entradas</h2>
        
        <div class="faq-item">
          <button class="faq-question" onclick="toggleFAQ(this)">
            <span>¿Cómo puedo reservar mis entradas online?</span>
            <span class="faq-icon">+</span>
          </button>
          <div class="faq-answer">
            <p>Para reservar tus entradas online sigue estos pasos:</p>
            <ol>
              <li>Selecciona la película de tu interés en nuestra cartelera</li>
              <li>Elige el cine, fecha y horario que prefieras</li>
              <li>Selecciona tus asientos en la sala</li>
              <li>Completa tus datos personales y método de pago</li>
              <li>Recibirás un código de confirmación por email y SMS</li>
            </ol>
            <p>¡Es así de fácil! También puedes usar nuestra app móvil para mayor comodidad.</p>
          </div>
        </div>

        <div class="faq-item">
          <button class="faq-question" onclick="toggleFAQ(this)">
            <span>¿Puedo cancelar o cambiar mi reserva?</span>
            <span class="faq-icon">+</span>
          </button>
          <div class="faq-answer">
            <p>Sí, puedes cancelar o modificar tu reserva hasta 2 horas antes de la función:</p>
            <ul>
              <li><strong>Cancelación:</strong> Recibirás el reembolso completo si cancelas con más de 2 horas de anticipación</li>
              <li><strong>Cambio de horario:</strong> Sin costo adicional si el precio es igual o menor</li>
              <li><strong>Cambio de película:</strong> Se aplicará la diferencia de precio si corresponde</li>
            </ul>
            <p>Para realizar cambios, ingresa a "Mi Cuenta" o contacta a nuestro servicio al cliente.</p>
          </div>
        </div>

        <div class="faq-item">
          <button class="faq-question" onclick="toggleFAQ(this)">
            <span>¿Qué métodos de pago aceptan?</span>
            <span class="faq-icon">+</span>
          </button>
          <div class="faq-answer">
            <p>Aceptamos múltiples métodos de pago para tu comodidad:</p>
            <ul>
              <li>Tarjetas de crédito: Visa, Mastercard, American Express</li>
              <li>Tarjetas de débito</li>
              <li>Billeteras digitales: PayPal, Plin, Yape</li>
              <li>Transferencias bancarias</li>
              <li>Pago en efectivo en nuestros cines</li>
            </ul>
            <p>Todos los pagos online están protegidos con tecnología de encriptación SSL.</p>
          </div>
        </div>
      </div>

      <div class="faq-category">
        <h2 class="faq-category-title">🍿 En el Cine</h2>
        
        <div class="faq-item">
          <button class="faq-question" onclick="toggleFAQ(this)">
            <span>¿Puedo ingresar alimentos y bebidas del exterior?</span>
            <span class="faq-icon">+</span>
          </button>
          <div class="faq-answer">
            <p>Por políticas de seguridad e higiene, no está permitido ingresar alimentos y bebidas del exterior a nuestras salas. Sin embargo, ofrecemos:</p>
            <ul>
              <li>Amplia variedad de snacks y bebidas en nuestro candy bar</li>
              <li>Combos especiales con descuentos</li>
              <li>Opciones saludables y veganas</li>
              <li>Precios competitivos y promociones especiales</li>
            </ul>
            <p>Esta política nos ayuda a mantener la limpieza de las salas y apoyar la operación del cine.</p>
          </div>
        </div>

        <div class="faq-item">
          <button class="faq-question" onclick="toggleFAQ(this)">
            <span>¿Con cuánta anticipación debo llegar al cine?</span>
            <span class="faq-icon">+</span>
          </button>
          <div class="faq-answer">
            <p>Te recomendamos llegar con 30 minutos de anticipación para:</p>
            <ul>
              <li>Retirar tus entradas en taquilla (si no tienes el código QR)</li>
              <li>Comprar snacks y bebidas</li>
              <li>Ubicar tu sala sin prisas</li>
              <li>Disfrutar de los avances y publicidad</li>
            </ul>
            <p><strong>Importante:</strong> Las puertas de la sala se cierran 10 minutos después del inicio de la función.</p>
          </div>
        </div>

        <div class="faq-item">
          <button class="faq-question" onclick="toggleFAQ(this)">
            <span>¿Qué pasa si llego tarde a la función?</span>
            <span class="faq-icon">+</span>
          </button>
          <div class="faq-answer">
            <p>Si llegas después del horario de inicio:</p>
            <ul>
              <li>Hasta 10 minutos: Podrás ingresar normalmente</li>
              <li>Entre 10-20 minutos: Ingreso sujeto a disponibilidad y sin interrumpir</li>
              <li>Más de 20 minutos: No se permite el ingreso por respeto a otros espectadores</li>
            </ul>
            <p>En caso de no poder ingresar, puedes cambiar tu entrada para otra función el mismo día (sujeto a disponibilidad).</p>
          </div>
        </div>
      </div>

      <div class="faq-category">
        <h2 class="faq-category-title">🎬 Películas y Formatos</h2>
        
        <div class="faq-item">
          <button class="faq-question" onclick="toggleFAQ(this)">
            <span>¿Cuál es la diferencia entre 2D, 3D, IMAX y 4DX?</span>
            <span class="faq-icon">+</span>
          </button>
          <div class="faq-answer">
            <p>Cada formato ofrece una experiencia única:</p>
            <ul>
              <li><strong>2D:</strong> Formato tradicional con excelente calidad de imagen y sonido</li>
              <li><strong>3D:</strong> Tecnología tridimensional que te sumerge en la acción (incluye lentes especiales)</li>
              <li><strong>IMAX:</strong> Pantalla gigante con sonido envolvente para máxima inmersión</li>
              <li><strong>4DX:</strong> Experiencia multisensorial con movimiento de butacas, efectos de viento, agua y aromas</li>
            </ul>
            <p>Los precios varían según el formato, siendo 2D el más económico y 4DX el premium.</p>
          </div>
        </div>

        <div class="faq-item">
          <button class="faq-question" onclick="toggleFAQ(this)">
            <span>¿Las películas tienen subtítulos o están dobladas?</span>
            <span class="faq-icon">+</span>
          </button>
          <div class="faq-answer">
            <p>Ofrecemos diferentes opciones de idioma:</p>
            <ul>
              <li><strong>Subtituladas (V.O.):</strong> Audio original con subtítulos en español</li>
              <li><strong>Dobladas:</strong> Audio completamente en español</li>
              <li><strong>Idioma original:</strong> Sin subtítulos (películas en español)</li>
            </ul>
            <p>En la cartelera puedes filtrar por idioma para encontrar tu preferencia. Las películas para niños suelen estar dobladas.</p>
          </div>
        </div>
      </div>

      <div class="faq-category">
        <h2 class="faq-category-title">👥 Membresías y Promociones</h2>
        
        <div class="faq-item">
          <button class="faq-question" onclick="toggleFAQ(this)">
            <span>¿Cómo funciona el programa de membresía?</span>
            <span class="faq-icon">+</span>
          </button>
          <div class="faq-answer">
            <p>Nuestro programa Planet Premium te ofrece:</p>
            <ul>
              <li>Acumulación de puntos por cada compra</li>
              <li>Descuentos exclusivos en entradas y candy bar</li>
              <li>Preventa anticipada para estrenos</li>
              <li>Invitaciones a preestrenos especiales</li>
              <li>Cumpleaños con entrada gratuita</li>
            </ul>
            <p>La membresía es gratuita y puedes registrarte online o en cualquier cine.</p>
          </div>
        </div>

        <div class="faq-item">
          <button class="faq-question" onclick="toggleFAQ(this)">
            <span>¿Hay descuentos para estudiantes o adultos mayores?</span>
            <span class="faq-icon">+</span>
          </button>
          <div class="faq-answer">
            <p>Sí, ofrecemos descuentos especiales:</p>
            <ul>
              <li><strong>Estudiantes:</strong> 25% de descuento con carnet universitario vigente</li>
              <li><strong>Adultos mayores (65+):</strong> 30% de descuento con documento de identidad</li>
              <li><strong>Miércoles de estudiante:</strong> 50% de descuento para universitarios</li>
              <li><strong>Jueves del adulto mayor:</strong> 40% de descuento</li>
            </ul>
            <p>Los descuentos no son acumulables y se aplican solo en taquilla presentando el documento correspondiente.</p>
          </div>
        </div>
      </div>

      <div class="faq-category">
        <h2 class="faq-category-title">📞 Soporte y Contacto</h2>
        
        <div class="faq-item">
          <button class="faq-question" onclick="toggleFAQ(this)">
            <span>¿Cómo puedo contactar al servicio al cliente?</span>
            <span class="faq-icon">+</span>
          </button>
          <div class="faq-answer">
            <p>Estamos aquí para ayudarte a través de múltiples canales:</p>
            <ul>
              <li><strong>Teléfono:</strong> (01) 418-8888 (Lunes a domingo, 8am-11pm)</li>
              <li><strong>Chat online:</strong> Disponible en nuestra web 24/7</li>
              <li><strong>Email:</strong> soporte@cineplanet.com.pe</li>
              <li><strong>Redes sociales:</strong> Facebook, Twitter, Instagram</li>
              <li><strong>WhatsApp:</strong> 999-888-777</li>
            </ul>
            <p>También puedes visitarnos directamente en cualquiera de nuestros cines.</p>
          </div>
        </div>

        <div class="faq-item">
          <button class="faq-question" onclick="toggleFAQ(this)">
            <span>¿La app móvil es gratuita?</span>
            <span class="faq-icon">+</span>
          </button>
          <div class="faq-answer">
            <p>¡Sí! Nuestra app es completamente gratuita y está disponible para:</p>
            <ul>
              <li>iOS (iPhone/iPad) en el App Store</li>
              <li>Android en Google Play Store</li>
            </ul>
            <p>Con la app puedes:</p>
            <ul>
              <li>Ver cartelera actualizada</li>
              <li>Reservar y pagar entradas</li>
              <li>Guardar tus entradas digitalmente</li>
              <li>Recibir notificaciones de estrenos</li>
              <li>Acceder a promociones exclusivas</li>
            </ul>
          </div>
        </div>
      </div>
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
    
    <div class="copyright">CinePlanet
      <p>&copy; 2025 CinePlanet. Todos los derechos reservados.</p>
    </div>
  </footer>

  <script>
    function toggleFAQ(element) {
      const faqItem = element.parentElement;
      const answer = faqItem.querySelector('.faq-answer');
      const icon = element.querySelector('.faq-icon');
      
      faqItem.classList.toggle('active');
      
      if (faqItem.classList.contains('active')) {
        answer.style.maxHeight = answer.scrollHeight + 'px';
        icon.textContent = '−';
      } else {
        answer.style.maxHeight = '0';
        icon.textContent = '+';
      }
    }
  </script>
</body>
</html>