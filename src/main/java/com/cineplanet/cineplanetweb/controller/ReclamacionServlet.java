// src/main/java/com/cineplanet/cineplanetweb/controller/ReclamacionServlet.java
package com.cineplanet.cineplanetweb.controller;

import com.cineplanet.cineplanetweb.dao.ReclamacionDAO;
import com.cineplanet.cineplanetweb.model.Reclamacion;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;

@WebServlet(name = "ReclamacionServlet", urlPatterns = {"/ver-anexos", "/procesar-reclamacion"})
public class ReclamacionServlet extends HttpServlet {

    private ReclamacionDAO dao;

    @Override
    public void init() throws ServletException {
        super.init();
        dao = new ReclamacionDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Forward al JSP que contiene ambos formularios
        req.getRequestDispatcher("/vista/ver-anexos.jsp")
           .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Parámetros del formulario de reclamación
        String nombre   = req.getParameter("nombre");
        String dni      = req.getParameter("dni");
        String telefono = req.getParameter("telefono");
        String email    = req.getParameter("email");
        String direccion= req.getParameter("direccion");
        String cine     = req.getParameter("cine");
        LocalDate fecha = LocalDate.parse(req.getParameter("fecha"));  // yyyy-MM-dd
        String tipo     = req.getParameter("tipo");
        String detalle  = req.getParameter("detalle");
        String pedido   = req.getParameter("pedido");
        boolean acepta  = req.getParameter("acepta-terminos") != null;

        String resultado;
        try {
            Reclamacion r = new Reclamacion(
                nombre, dni, telefono, email,
                direccion, cine, fecha,
                tipo, detalle, pedido, acepta
            );
            dao.create(r);
            resultado = "ok";
        } catch (SQLException ex) {
            log("Error procesando reclamación", ex);
            resultado = "error";
        }

        // Redirect con parámetro de resultado
        resp.sendRedirect(req.getContextPath() + "/ver-anexos?mensaje=" + resultado);
    }
}
