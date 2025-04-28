<%-- 
    Document   : index
    Created on : 31 mar. 2025, 2:40:51 p. m.
    Author     : Guillermo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <% response.sendRedirect(request.getContextPath()
        + "/vistas/login.jsp");%>
    </body>
</html>
