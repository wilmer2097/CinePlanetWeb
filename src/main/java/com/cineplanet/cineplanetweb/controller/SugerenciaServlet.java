// src/main/java/com/cineplanet/cineplanetweb/controller/SugerenciaServlet.java
package com.cineplanet.cineplanetweb.controller;

import com.cineplanet.cineplanetweb.dao.SugerenciaDAO;
import com.cineplanet.cineplanetweb.model.Sugerencia;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
//URL para para encontrar el servlet 
@WebServlet(name = "SugerenciaServlet", urlPatterns = {"/procesar-sugerencia"})
public class SugerenciaServlet extends HttpServlet {
    // Para inicializar el DAO de sugerencia
    private SugerenciaDAO dao;
    
    //Hereda 
    @Override
    public void init() throws ServletException {
        super.init();
        dao = new SugerenciaDAO();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String nombre    = req.getParameter("nombre");
        String email     = req.getParameter("email");
        String telefono  = req.getParameter("telefono");
        String categoria = req.getParameter("categoria");
        String texto     = req.getParameter("sugerencia");

        String resultado;
        try {
            Sugerencia s = new Sugerencia(nombre, email, telefono, categoria, texto);
            dao.create(s);
            resultado = "sugerencia_ok";
        } catch (SQLException ex) {
            log("Error al guardar sugerencia", ex);
            resultado = "sugerencia_error";
        }

        // Redirige de vuelta al JSP de anexos con un mensaje
        resp.sendRedirect(req.getContextPath() +
                         "/ver-anexos?mensaje=" + resultado);
    }
}
