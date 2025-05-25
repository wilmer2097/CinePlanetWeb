package com.cineplanet.cineplanetweb.controller;

import com.cineplanet.cineplanetweb.dao.SugerenciaDAO;
import com.cineplanet.cineplanetweb.model.Sugerencia;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "SugerenciaServlet", urlPatterns = {"/SugerenciaServlet"})
public class SugerenciaServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SugerenciaServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SugerenciaServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Configurar codificación UTF-8
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        try {
            // Crear objeto Sugerencia con los datos del formulario
            Sugerencia sugerencia = new Sugerencia();
            sugerencia.setNombre(request.getParameter("nombre"));
            sugerencia.setEmail(request.getParameter("email"));
            sugerencia.setTelefono(request.getParameter("telefono"));
            sugerencia.setCategoria(request.getParameter("categoria"));
            sugerencia.setSugerencia(request.getParameter("sugerencia"));
            
            // Guardar en base de datos
            SugerenciaDAO dao = new SugerenciaDAO();
            boolean exito = dao.guardarSugerencia(sugerencia);
            
            // Redireccionar con mensaje de resultado
            String mensaje = exito ? "sugerencia-ok" : "sugerencia-error";
            response.sendRedirect(request.getContextPath() + "/ver-anexos?mensaje=" + mensaje);
            
        } catch (Exception e) {
            e.printStackTrace();
            // En caso de error, redireccionar con mensaje de error
            response.sendRedirect(request.getContextPath() + "/ver-anexos?mensaje=sugerencia-error");
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet para manejar sugerencias de usuarios";
    }
}