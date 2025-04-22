-- 0. Base de datos
CREATE DATABASE cineplanet_web CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE cineplanet_web;

-- 1. Usuarios
CREATE TABLE usuario (
  usuario_id   INT AUTO_INCREMENT PRIMARY KEY,
  nombre       VARCHAR(100) NOT NULL,
  email        VARCHAR(120) NOT NULL UNIQUE,
  password     CHAR(60)     NOT NULL,            -- bcrypt/argon2 hash
  telefono     VARCHAR(20),
  fecha_reg    DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 2. Complejos y salas
CREATE TABLE complejo (
  complejo_id  INT AUTO_INCREMENT PRIMARY KEY,
  nombre       VARCHAR(120) NOT NULL,
  ciudad       VARCHAR(80)  NOT NULL,
  direccion    VARCHAR(200) NOT NULL
);

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

-- 3. Asientos (numeración fija por sala)
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

-- 4. Películas
CREATE TABLE pelicula (
  pelicula_id  INT AUTO_INCREMENT PRIMARY KEY,
  titulo       VARCHAR(150) NOT NULL,
  duracion_min INT NOT NULL,
  sinopsis     TEXT,
  clasificacion VARCHAR(10),
  estreno      DATE
);

-- 5. Funciones (cartelera)
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

-- 6. Reservas (una orden de compra)
CREATE TABLE reserva (
  reserva_id   INT AUTO_INCREMENT PRIMARY KEY,
  usuario_id   INT NOT NULL,
  fecha_hora   DATETIME DEFAULT CURRENT_TIMESTAMP,
  estado       ENUM('CREADA','CONFIRMADA','CANCELADA') DEFAULT 'CREADA',
  total        DECIMAL(8,2) DEFAULT 0,
  CONSTRAINT fk_reserva_usuario FOREIGN KEY (usuario_id) REFERENCES usuario(usuario_id)
);

-- 7. Tickets (asiento reservado)
CREATE TABLE ticket (
  ticket_id    INT AUTO_INCREMENT PRIMARY KEY,
  reserva_id   INT NOT NULL,
  funcion_id   INT NOT NULL,
  asiento_id   INT NOT NULL,
  precio       DECIMAL(6,2) NOT NULL,
  CONSTRAINT fk_ticket_reserva  FOREIGN KEY (reserva_id) REFERENCES reserva(reserva_id) ON DELETE CASCADE,
  CONSTRAINT fk_ticket_funcion  FOREIGN KEY (funcion_id) REFERENCES funcion(funcion_id),
  CONSTRAINT fk_ticket_asiento  FOREIGN KEY (asiento_id) REFERENCES asiento(asiento_id),
  UNIQUE (funcion_id, asiento_id)            -- evita doble venta del mismo asiento
);

-- 8. Pagos
CREATE TABLE pago (
  pago_id      INT AUTO_INCREMENT PRIMARY KEY,
  reserva_id   INT NOT NULL UNIQUE,
  metodo       ENUM('TARJETA','YAPE','EFECTIVO') NOT NULL,
  estado       ENUM('PENDIENTE','APROBADO','FALLIDO') DEFAULT 'PENDIENTE',
  monto        DECIMAL(8,2) NOT NULL,
  fecha_pago   DATETIME,
  CONSTRAINT fk_pago_reserva FOREIGN KEY (reserva_id) REFERENCES reserva(reserva_id)
);

-- 9. Vistas útiles
CREATE VIEW cartelera_hoy AS
SELECT f.funcion_id, p.titulo, c.nombre   AS complejo, s.nombre AS sala,
       f.fecha_hora, f.idioma, f.precio_base
FROM   funcion f
JOIN   pelicula p ON p.pelicula_id = f.pelicula_id
JOIN   sala     s ON s.sala_id     = f.sala_id
JOIN   complejo c ON c.complejo_id = s.complejo_id
WHERE  DATE(f.fecha_hora) = CURDATE();

select * from usuario;
INSERT INTO `cineplanet_web`.`usuario` (`usuario_id`, `nombre`, `email`, `password`, `telefono`, `fecha_reg`) VALUES ('1', 'wilmer', 'prueba@gmail.com', '12345', '987654321', now());


