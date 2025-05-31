# 🎬 Base de Datos Cineplanet Web

Este proyecto organiza la base de datos de una plataforma web para un cine, similar a **Cineplanet**, donde los usuarios pueden registrarse, ver la cartelera, hacer reservas y dejar sugerencias o reclamos.

---

## 🧍‍♂️ Tabla: `usuario`

### ¿Qué guarda?
Información de las personas que usan la plataforma web.

📌 **Ejemplo real**: Juan se registra en la web de Cineplanet para comprar entradas.

### 🔑 Campos clave:
- `usuario_id`: Identificador único (como el DNI).
- `nombre`, `email`, `telefono`: Datos personales.
- `password`: Guardado en formato encriptado (hash).
- `fecha_reg`: Fecha de registro.

⚠️ **¿Qué pasa si no hay `UNIQUE` en `email`?**
> Se podría registrar la misma persona varias veces con el mismo correo. ❌

---

## 🏢 Tabla: `complejo`

### ¿Qué representa?
Cada cine ubicado en una ciudad.

📌 **Ejemplo real**: Cineplanet San Isidro.

### 🔑 Campos clave:
- `complejo_id`: ID único del cine.
- `ciudad`: Ciudad donde se ubica.
- `direccion`: Calle o avenida.

---

## 🎥 Tabla: `sala`

### ¿Qué representa?
Una sala específica dentro de un complejo (cine).

📌 **Ejemplo real**: “Sala 1” del Cineplanet Miraflores.

### 🔑 Campos clave:
- `tipo`: NORMAL, XTREME o VIP.
- `aforo_total`: Número de asientos.
- `complejo_id`: FK que relaciona la sala con su cine.

🔗 **Relaciones:**
- Tiene clave foránea a `complejo`.
- Si se borra un cine, se borran sus salas automáticamente (`ON DELETE CASCADE`).

---

## 💺 Tabla: `asiento`

### ¿Qué representa?
Cada asiento físico dentro de una sala.

📌 **Ejemplo**: Fila A, asiento 10.

### 🔑 Campos clave:
- `fila`, `numero`: Posición exacta del asiento.
- `uq_asiento`: Evita duplicados (no pueden existir dos A-10 en la misma sala).

---

## 🎞️ Tabla: `pelicula`

### ¿Qué representa?
Información de cada película que se proyecta.

📌 **Ejemplo**: *Final Destination Bloodlines*

### 🔑 Campos:
- `titulo`, `duracion_min`, `sinopsis`, `clasificacion`, `estreno`, `img_url`.

---

## 🕓 Tabla: `funcion`

### ¿Qué representa?
Una película en una sala a una hora específica.

📌 **Ejemplo**: *Final Destination Bloodlines* en Sala 1 a las 8:30 PM.

### 🔗 Relaciones:
- `sala_id`: En qué sala.
- `pelicula_id`: Qué película.
- `fecha_hora`, `idioma`, `precio_base`.

🚀 **Índice**: `idx_funcion_hora` → Acelera las búsquedas por hora.

🔒 **Restricción importante**:
> `uq_funcion_unica`: No se puede repetir una misma película en la misma sala, a la misma hora.

---

## 📦 Tabla: `reserva`

### ¿Qué representa?
Una orden de compra (como un carrito de compras).

📌 **Ejemplo**: Juan reserva 3 asientos para una función.

### 🔑 Campos clave:
- `usuario_id`: Cliente que hace la reserva.
- `estado`: Puede ser CREADA, CONFIRMADA o CANCELADA.
- `total`: Monto total a pagar.

---

## 🎟️ Tabla: `ticket`

### ¿Qué representa?
Cada entrada específica dentro de una reserva.

📌 **Ejemplo**: Un asiento (A-10) para la función de las 20:30.

### 🔗 Relaciones:
- `reserva_id`, `funcion_id`, `asiento_id`.

⚠️ **Restricción importante**:
> `UNIQUE(funcion_id, asiento_id)`: Evita vender el mismo asiento dos veces para una misma función.

---

## 💳 Tabla: `pago`

### ¿Qué representa?
El dinero que se paga por una reserva.

📌 **Ejemplo**: Juan paga por su reserva con tarjeta o Yape.

### 🔑 Campos clave:
- `metodo`: TARJETA, YAPE, EFECTIVO.
- `estado`: PENDIENTE, APROBADO, FALLIDO.
- `reserva_id`: Solo un pago por reserva (`UNIQUE`).

---

## 💬 Tabla: `sugerencias`

### ¿Qué representa?
Opiniones o ideas que dejan los usuarios.

📌 **Ejemplo**: “Pongan más funciones en 3D”.

### 🔑 Campos:
- `nombre`, `email`, `telefono`, `categoria`, `sugerencia`, `fecha_registro`.

---

## 😠 Tabla: `reclamaciones`

### ¿Qué representa?
Quejas formales de los clientes.

📌 **Ejemplo**: “La película empezó 30 minutos tarde”.

### 🔑 Campos:
- Incluye: `dni`, `direccion`, `tipo_reclamo`, `detalle`, y confirmación de términos.

---

## 👁️ Vista: `cartelera_hoy`

### ¿Qué es?
Una vista (como una tabla virtual).

### ¿Qué muestra?
Todas las funciones programadas para hoy (`CURDATE()`).

💡 **¿Por qué es útil?**
> Permite que el frontend consulte directamente la cartelera del día sin necesidad de hacer un `JOIN` complejo.

---


