🧍‍♂️ usuario
¿Qué guarda esta tabla? Información de las personas que usan la plataforma web.

Ejemplo real: Juan se registra en la web de Cineplanet para comprar entradas.

Campos clave:

usuario_id: Identificador único del cliente (como el DNI).

nombre, email, telefono: Datos personales.

password: Encriptado (hash).

fecha_reg: Cuándo se registró.

¿Qué pasaría si no hubiera UNIQUE en email?
Se podría registrar la misma persona varias veces con el mismo correo. ❌

🏢 complejo
¿Qué representa? Cada cine en una ciudad.

Ejemplo real: Cineplanet San Isidro.

Campos clave:

complejo_id: Identificador del cine.

ciudad: Dónde está.

direccion: Calle o avenida.

🎥 sala
¿Qué representa? Una sala específica dentro de un complejo.

Ejemplo real: "Sala 1" del Cineplanet Miraflores.

Campos clave:

tipo: Puede ser NORMAL, XTREME, o VIP.

aforo_total: Número de asientos.

complejo_id: Relaciona esta sala con su cine.

🔗 Relaciones:

Tiene una clave foránea a complejo. Si se borra un cine, se borran sus salas. (ON DELETE CASCADE)

💺 asiento
¿Qué representa? Cada asiento físico dentro de una sala.

Ejemplo: Fila A, asiento 10.

Campos clave:

fila y numero: Posición exacta del asiento.

uq_asiento: Evita duplicar un asiento (no pueden existir dos Asiento A-10 en la misma sala).

🎞️ pelicula
¿Qué representa? Información sobre una película.

Ejemplo: Final Destination Bloodlines

Campos:

titulo, duracion_min, sinopsis, clasificacion, estreno, img_url.

🕓 funcion
¿Qué representa? Una película en una sala a una hora específica.

Ejemplo: Final Destination Bloodlines en Sala 1 a las 8:30 PM.

Relaciones:

sala_id: En qué sala se da la función.

pelicula_id: Qué película se muestra.

fecha_hora, idioma, precio_base.

Índice: idx_funcion_hora: Acelera búsquedas por hora (útil para mostrar cartelera).

Restricción importante:
🔒 uq_funcion_unica: No se puede repetir una película en la misma sala, a la misma hora.

📦 reserva
¿Qué representa? Una orden de compra (como tu carrito de compras).

Ejemplo: Juan reserva 3 asientos para una función.

Campos clave:

usuario_id: De quién es la reserva.

estado: Si está confirmada, cancelada, o creada.

total: Monto total.

🎟️ ticket
¿Qué representa? Cada entrada específica dentro de una reserva.

Ejemplo: Un asiento (A-10) para la función de las 20:30 de Final Destination.

Relaciones:

reserva_id, funcion_id, asiento_id.

UNIQUE(funcion_id, asiento_id): Evita vender el mismo asiento 2 veces para una misma función. ⚠️

💳 pago
¿Qué representa? El dinero que se pagó por una reserva.

Ejemplo: Juan paga por su reserva con tarjeta Yape.

Campos clave:

metodo: TARJETA, YAPE, EFECTIVO.

estado: PENDIENTE, APROBADO, FALLIDO.

reserva_id: Relación directa con una reserva (solo una vez, por eso es UNIQUE).

💬 sugerencias
¿Qué representa? Opiniones o ideas que dejan los clientes.

Ejemplo: “Pongan más funciones en 3D”.

Campos: nombre, email, telefono, categoria, sugerencia, fecha_registro.

😠 reclamaciones
¿Qué representa? Quejas formales sobre un problema.

Ejemplo: “La película empezó 30 minutos tarde”.

Campos: Incluyen DNI, dirección, tipo de reclamo, detalle, y si acepta términos.

👁️ cartelera_hoy (VIEW)
¿Qué es esto? Una vista (como una tabla virtual).

¿Qué muestra? Todas las funciones programadas para hoy (CURDATE()).

¿Por qué es útil?
Permite que tu frontend (tu página web) consulte directamente qué funciones mostrar sin escribir un JOIN complejo.

