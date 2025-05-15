<%-- 
    Document   : login
    Created on : 14 may. 2025, 2:23:32 a. m.
    Author     : Guillermo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="es">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Login - TechSolvers</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                background-color: #f6f6f6;
                font-family: 'Segoe UI', sans-serif;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }

            .login-container {
                background-color: white;
                padding: 40px 30px;
                border-radius: 10px;
                box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
                width: 350px;
            }

            .logo-container {
                display: flex;
                justify-content: flex-start;
                margin-bottom: 20px;
            }

            .logo-container img {
                width: 90px;
                height: auto;
            }

            .login-container h2 {
                margin-bottom: 10px;
                font-size: 22px;
                color: #333;
            }

            .login-container p {
                font-size: 14px;
                margin-bottom: 20px;
                color: #666;
            }

            label {
                display: block;
                margin-bottom: 5px;
                font-weight: 500;
                color: #444;
            }

            input[type="email"],
            input[type="password"] {
                width: 100%;
                padding: 10px;
                margin-bottom: 20px;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 14px;
            }

            button {
                width: 100%;
                padding: 10px;
                background-color: #007bff;
                color: white;
                border: 1px solid #007bff;
                border-radius: 5px;
                font-size: 16px;
                cursor: pointer;
            }

            button:hover {
                background-color: #0056b3;
            }

            .register-text {
                text-align: center;
                margin-top: 15px;
                font-size: 14px;
            }

            .register-text a {
                font-weight: bold;
                color: #007bff;
                text-decoration: none;
            }

            .register-text a:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>

        <div class="login-container">
            <div class="logo-container">
                <img src="${pageContext.request.contextPath}/imagenes/logotechsolvers.jpg" alt="Logo TechSolvers">
            </div>

            <h2>Inicio de Sesión</h2>
            <p>Inicio de sesión con tu cuenta de TechSolvers</p>

            <form method="post" action="<%= request.getContextPath()%>/controladorLogin">
                <label for="email">Correo Electrónico</label>
                <input type="email" id="email" placeholder="Ingrese su correo" name="correo" required />

                <label for="password">Contraseña</label>
                <input type="password" id="password" placeholder="Ingrese su contraseña" name="clave" required />

                <button type="submit">Inicio de Sesión</button>
            </form>
            <% if (request.getAttribute("error") != null) {%>
            <p style="color:red;"><%= request.getAttribute("error")%></p>
            <% }%>
            <div class="register-text">
                ¿No tienes cuenta? <a href="${pageContext.request.contextPath}/vistas/registro.jsp">Regístrate</a>
            </div>
        </div>

    </body>
</html>
