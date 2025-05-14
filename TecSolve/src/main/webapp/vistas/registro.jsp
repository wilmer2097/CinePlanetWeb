<%-- 
    Document   : registro
    Created on : 14 may. 2025, 3:53:30 a. m.
    Author     : Guillermo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Registro - TechSolvers</title>
        <style>
            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
            }

            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: #f6f6f6;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
            }

            .registro-container {
                background-color: #ffffff;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
                width: 900px;
                display: flex;
                flex-direction: column;
                gap: 20px;
            }

            .cabecera-con-imagen {
                display: flex;
                align-items: flex-start;
                justify-content: space-between;
                margin-bottom: 10px; /* Reducido de 25px a 10px */
            }

            .cabecera {
                flex: 1.5; /* Antes: 2 */
            }

            .logo {
                width: 160px;
                margin-bottom: 10px; /* Ajuste más compacto */
            }

            h2 {
                font-size: 22px;
                margin-bottom: 8px;
                color: #333;
            }

            .descripcion {
                font-size: 14px;
                margin-bottom: 10px; /* Reducido para acercarlo más */
                color: #666;
            }

            .descripcion strong {
                font-weight: bold;
            }

            .imagen-lateral {
                flex: 1.2; /* Antes: 1. Ahora ocupa menos para acercarse más */
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .imagen-lateral img {
                max-width: 100%;
                height: auto;
            }

            .form-grid {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 20px 20px;
            }

            .form-group {
                display: flex;
                flex-direction: column;
            }

            label {
                margin-bottom: 5px;
                color: #444;
                font-weight: 500;
            }

            input {
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 14px;
            }

            .form-bottom {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 20px;
                margin-top: 20px;
            }

            .submit-section {
                margin-top: 30px;
            }

            button {
                width: 100%;
                padding: 12px;
                background-color: #007bff;
                color: white;
                font-size: 16px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
            }

            button:hover {
                background-color: #0056b3;
            }

            .derechos {
                margin-top: 10px;
                text-align: center;
                font-size: 12px;
                color: #777;
            }
        </style>
        <script>
            function validarContraseñas() {
                const password = document.getElementById("password").value;
                const confirmar = document.getElementById("confirmar").value;

                if (password === confirmar) {
                    alert("Las contraseñas coinciden.");
                    return true;
                } else {
                    alert("Las contraseñas no coinciden.");
                    return false;
                }
            }
        </script>
    </head>
    <body>

        <div class="registro-container">

            <!-- Cabecera con imagen -->
            <div class="cabecera-con-imagen">
                <div class="cabecera">
                    <img src="../imagenes/logotechsolvers.jpg" alt="Logo TechSolvers" class="logo">
                    <h2>Registrar</h2>
                    <p class="descripcion">
                        Regístrate y recibe un 30% de descuento<br>en tu primera compra en <strong>Techsolvers</strong>.
                    </p>
                </div>

                <div class="imagen-lateral">
                    <img src="../imagenes/graficartx.png" alt="Gráfico Techsolvers">
                </div>
            </div>

            <!-- Formulario -->
            <div >
                <form class="form-grid" action="<%= request.getContextPath()%>/controladorUsuario" method="post" onsubmit="return validarContraseñas()">
                    <div class="form-group">
                        <label for="nombre">Nombre:</label>
                        <input type="text" id="nombre" name="nombre" placeholder="Ingrese su nombre">
                    </div>
                    <div class="form-group">
                        <label for="apellido">Apellidos:</label>
                        <input type="text" id="apellido" name="apellido" placeholder="Ingrese sus apellidos">
                    </div>
                    <div class="form-group">
                        <label for="direccion">Direccion:</label>
                        <input type="text" id="direccion" name="direccion" placeholder="Direccion">
                    </div>
                    <div class="form-group">
                        <label for="telefono">Teléfono:</label>
                        <input type="tel" id="telefono" name="telefono" placeholder="Ingrese su número de teléfono">
                    </div>
                    <div class="form-group">
                        <label for="dni">Número de DNI:</label>
                        <input type="text" id="dni" name="dni" placeholder="Ingrese su número de documento">
                    </div>

                    <div class="form-group">
                        <label for="email">Correo Electrónico</label>
                        <input type="email" id="email" name="correo" placeholder="Ingrese su correo" required />
                    </div>
                    <div class="form-group">
                        <label for="codigo">Codigo corporativo</label>
                        <input type="text" id="codigo" name="rol" placeholder="En caso no tener dejar en blanco"/><!-- tecsolve si el usuario tendra rol de admin -->
                    </div>
                    <div class="form-group">
                        <label for="password">Contraseña:</label>
                        <input type="password" id="password" name="clave" placeholder="Cree una contraseña">
                    </div>
                    <div class="form-group">
                        <label for="confirmar">Confirma Contraseña:</label>
                        <input type="password" id="confirmar" name="confirmar" placeholder="Repita la contraseña">
                    </div>
                    <div class="submit-section">
                        <button type="submit">Crear cuenta</button>
                        <div class="derechos">© Todos los derechos reservados 2025</div>
                    </div>
                </form>

            </div>



        </div>

    </body>
</html>
