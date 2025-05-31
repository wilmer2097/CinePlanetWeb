-- ===========================================
--  BASE DE DATOS: cineplanet_web
-- ===========================================
CREATE DATABASE cineplanet_web CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE cineplanet_web;

-- ===========================================
--  TABLA: USUARIO
-- ===========================================
CREATE TABLE usuario (
  usuario_id   INT AUTO_INCREMENT PRIMARY KEY,
  nombre       VARCHAR(100) NOT NULL,
  email        VARCHAR(120) NOT NULL UNIQUE,
  password     CHAR(60)     NOT NULL,            -- bcrypt/argon2 hash
  telefono     VARCHAR(20),
  fecha_reg    DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- ===========================================
--  TABLA: COMPLEJO
-- ===========================================
CREATE TABLE complejo (
  complejo_id  INT AUTO_INCREMENT PRIMARY KEY,
  nombre       VARCHAR(120) NOT NULL,
  ciudad       VARCHAR(80)  NOT NULL,
  direccion    VARCHAR(200) NOT NULL
);

-- ===========================================
--  TABLA: SALA
-- ===========================================
CREATE TABLE sala (
  sala_id      INT AUTO_INCREMENT PRIMARY KEY,
  complejo_id  INT NOT NULL,
  nombre       VARCHAR(50) NOT NULL,
  tipo         ENUM('NORMAL','XTREME','VIP') DEFAULT 'NORMAL',
  aforo_total  INT NOT NULL,
  CONSTRAINT fk_sala_complejo
    FOREIGN KEY (complejo_id) REFERENCES complejo(complejo_id)
    ON DELETE CASCADE
);

-- ===========================================
--  TABLA: ASIENTO
-- ===========================================
CREATE TABLE asiento (
  asiento_id   INT AUTO_INCREMENT PRIMARY KEY,
  sala_id      INT NOT NULL,
  fila         CHAR(1) NOT NULL,
  numero       INT NOT NULL,
  CONSTRAINT uq_asiento UNIQUE (sala_id, fila, numero),
  CONSTRAINT fk_asiento_sala
    FOREIGN KEY (sala_id) REFERENCES sala(sala_id)
    ON DELETE CASCADE
);

-- ===========================================
--  TABLA: PELICULA
-- ===========================================
CREATE TABLE pelicula (
  pelicula_id  INT AUTO_INCREMENT PRIMARY KEY,
  titulo       VARCHAR(150) NOT NULL,
  duracion_min INT NOT NULL,
  sinopsis     TEXT,
  clasificacion VARCHAR(10),
  estreno      DATE,
  img_url      LONGTEXT
);

-- ===========================================
--  TABLA: FUNCION
-- ===========================================
CREATE TABLE funcion (
  funcion_id   INT AUTO_INCREMENT PRIMARY KEY,
  sala_id      INT NOT NULL,
  pelicula_id  INT NOT NULL,
  fecha_hora   DATETIME NOT NULL,
  idioma       VARCHAR(20) DEFAULT 'SUB',
  precio_base  DECIMAL(6,2) NOT NULL,
  CONSTRAINT fk_funcion_sala     FOREIGN KEY (sala_id)    REFERENCES sala(sala_id),
  CONSTRAINT fk_funcion_pelicula FOREIGN KEY (pelicula_id) REFERENCES pelicula(pelicula_id),
  INDEX idx_funcion_hora (fecha_hora)
);

-- ===========================================
--  TABLA: RESERVA
-- ===========================================
CREATE TABLE reserva (
  reserva_id   INT AUTO_INCREMENT PRIMARY KEY,
  usuario_id   INT NOT NULL,
  fecha_hora   DATETIME DEFAULT CURRENT_TIMESTAMP,
  estado       ENUM('CREADA','CONFIRMADA','CANCELADA') DEFAULT 'CREADA',
  total        DECIMAL(8,2) DEFAULT 0,
  CONSTRAINT fk_reserva_usuario FOREIGN KEY (usuario_id) REFERENCES usuario(usuario_id)
);

-- ===========================================
--  TABLA: TICKET
-- ===========================================
CREATE TABLE ticket (
  ticket_id    INT AUTO_INCREMENT PRIMARY KEY,
  reserva_id   INT NOT NULL,
  funcion_id   INT NOT NULL,
  asiento_id   INT NOT NULL,
  precio       DECIMAL(6,2) NOT NULL,
  CONSTRAINT fk_ticket_reserva  FOREIGN KEY (reserva_id) REFERENCES reserva(reserva_id) ON DELETE CASCADE,
  CONSTRAINT fk_ticket_funcion  FOREIGN KEY (funcion_id) REFERENCES funcion(funcion_id),
  CONSTRAINT fk_ticket_asiento  FOREIGN KEY (asiento_id) REFERENCES asiento(asiento_id),
  UNIQUE (funcion_id, asiento_id)  -- evita doble venta del mismo asiento
);

-- ===========================================
--  TABLA: PAGO
-- ===========================================
CREATE TABLE pago (
  pago_id      INT AUTO_INCREMENT PRIMARY KEY,
  reserva_id   INT NOT NULL UNIQUE,
  metodo       ENUM('TARJETA','YAPE','EFECTIVO') NOT NULL,
  estado       ENUM('PENDIENTE','APROBADO','FALLIDO') DEFAULT 'PENDIENTE',
  monto        DECIMAL(8,2) NOT NULL,
  fecha_pago   DATETIME,
  CONSTRAINT fk_pago_reserva FOREIGN KEY (reserva_id) REFERENCES reserva(reserva_id)
);

-- ===========================================
--  TABLA: SUGERENCIAS
-- ===========================================
CREATE TABLE sugerencias (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL,
  telefono VARCHAR(20),
  categoria VARCHAR(50) NOT NULL,
  sugerencia TEXT NOT NULL,
  fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ===========================================
--  TABLA: RECLAMACIONES
-- ===========================================
CREATE TABLE reclamaciones (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  dni VARCHAR(20) NOT NULL,
  telefono VARCHAR(20) NOT NULL,
  email VARCHAR(100) NOT NULL,
  direccion VARCHAR(150),
  cine VARCHAR(50),
  fecha_incidente DATE,
  tipo VARCHAR(20) NOT NULL,
  detalle TEXT NOT NULL,
  pedido TEXT,
  acepta_terminos BOOLEAN NOT NULL,
  fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ===========================================
--  ÍNDICE ÚNICO PARA FUNCIONES
-- ===========================================
ALTER TABLE funcion
  ADD UNIQUE uq_funcion_unica (sala_id, pelicula_id, fecha_hora);

-- ===========================================
--  INSERTS DE USUARIO
-- ===========================================
INSERT INTO usuario (usuario_id, nombre, email, password, telefono, fecha_reg)
VALUES (1, 'wilmer', 'prueba@gmail.com', '12345', '987654321', NOW());

-- ===========================================
--  INSERTS DE COMPLEJO
-- ===========================================
INSERT INTO complejo (nombre, ciudad, direccion) VALUES
  ('Cineplanet Miraflores', 'Lima', 'Av. La Mar 350'),
  ('Cineplanet San Isidro', 'Lima', 'Av. Javier Prado 1200');

-- ===========================================
--  INSERTS DE SALAS
-- ===========================================
INSERT INTO sala (complejo_id, nombre, tipo, aforo_total) VALUES
  (1, 'Sala 1', 'NORMAL', 120),
  (1, 'Sala 2', 'NORMAL', 80),
  (2, 'Sala A', 'XTREME', 100),
  (2, 'Sala B', 'VIP', 60);

-- ===========================================
--  INSERTS DE PELÍCULAS
-- ===========================================
INSERT INTO pelicula (titulo, duracion_min, sinopsis, clasificacion, estreno, img_url) VALUES
('Mission: Impossible – The Final Reckoning', 170, 
 'Ethan Hunt y su equipo se unen para detener a una IA llamada "the Entity" que pretende desatar un apocalipsis nuclear.',
 'PG-13', '2025-05-23',
 'https://upload.wikimedia.org/wikipedia/en/1/1f/Mission_Impossible_%E2%80%93_The_Final_Reckoning_Poster.jpg'),
('Thunderbolts*', 126,
 'Un grupo de antihéroes es capturado y obligado a colaborar en una peligrosa misión para detener una conspiración.',
 'PG-13', '2025-05-02',
 'https://upload.wikimedia.org/wikipedia/en/9/90/Thunderbolts%2A_poster.jpg'),
('Final Destination Bloodlines', 110,
 'Una estudiante universitaria hereda la premonición de su abuela sobre el colapso mortal de una torre en 1968 y debe proteger a su familia de la implacable persecución de la Muerte.',
 'R', '2025-05-16',
 'https://upload.wikimedia.org/wikipedia/en/a/ab/Final_Destination_Bloodlines_%282025%29_poster.jpg'),
('Hurry Up Tomorrow', 105,
 'Un músico que sufre insomnio y depresión se ve arrastrado a una odisea existencial por una misteriosa fan obsesionada.',
 'R', '2025-05-16',
 'https://upload.wikimedia.org/wikipedia/en/f/f0/Hurry_Up_Tomorrow_-_Official_Film_Poster.jpeg'),
('Juliet & Romeo', 122,
 'Reimagen pop-musical de Romeo y Julieta ambientada en la Verona medieval, donde los amantes desafían el destino a través de canciones originales.',
 'PG-13', '2025-05-09',
 'https://upload.wikimedia.org/wikipedia/en/4/47/Juliet_%26_Romeo_%282025%29_poster.jpg');

-- ===========================================
--  INSERTS DE FUNCIONES (26 MAYO 2025)
-- ¡Debes actualiazr las fechas a la actual!
-- ===========================================
INSERT INTO funcion (sala_id, pelicula_id, fecha_hora, idioma, precio_base) VALUES
  (1, 1, '2025-05-26 18:00:00', 'SUB', 30.00),
  (1, 3, '2025-05-26 20:30:00', 'ESP', 28.00),
  (2, 2, '2025-05-26 19:00:00', 'VOSE', 35.00),
  (2, 4, '2025-05-26 21:15:00', 'ESP', 32.00),
  (3, 5, '2025-05-26 17:45:00', 'SUB', 34.00),
  (4, 1, '2025-05-26 19:30:00', 'ESP', 31.00);

-- ===========================================
--  VISTA: CARTELERA_HOY
-- ===========================================
DROP VIEW IF EXISTS cartelera_hoy;

CREATE VIEW cartelera_hoy AS
SELECT 
  f.funcion_id,
  p.titulo,
  p.sinopsis,
  p.img_url         AS img_url,
  c.nombre          AS complejo,
  s.nombre          AS sala,
  f.fecha_hora,
  f.idioma,
  f.precio_base
FROM funcion f
JOIN pelicula p ON p.pelicula_id = f.pelicula_id
JOIN sala     s ON s.sala_id     = f.sala_id
JOIN complejo c ON c.complejo_id = s.complejo_id
WHERE DATE(f.fecha_hora) = CURDATE();

-- ===========================================
--  CONSULTAS DE PRUEBA
-- ===========================================
SELECT * FROM usuario;
SELECT * FROM pelicula;
SELECT * FROM sugerencias;
SELECT * FROM reclamaciones;
SELECT * FROM complejo;
SELECT * FROM sala;
SELECT * FROM funcion;
SELECT * FROM cartelera_hoy;



