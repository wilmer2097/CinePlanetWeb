<%-- 
    Document   : login
    Created on : 28 abr. 2025, 3:22:56 a. m.
    Author     : Guillermo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>LOGIN</title>
    </head>
    <body>
        <%String error = (String) request.getAttribute("error");
          if (error != null) { 
        %>
           <p style="color:red;"><%= error %></p>
        <%} 
        %>
        <div>
           <h1>INICIAR SESION</h1>
           <form method="post" action="${pageContext.request.contextPath}/controladorLogin">
            <h3>Usuario</h3>
            <input type="text" name="usuario">
            <h3>Contraseña</h3>
            <input type="password" name="clave"><br>
            <input type="submit" name="Iniciar Sesion">
           </form>
           
        </div>
        
    </body>
</html>
