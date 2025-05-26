package com.cineplanet.cineplanetweb.controller;

import com.cineplanet.cineplanetweb.dao.CarteleraDAO;
import com.cineplanet.cineplanetweb.model.FuncionHoy;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "CarteleraServlet", urlPatterns = {"/cartelera"})
public class CarteleraServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final CarteleraDAO dao = new CarteleraDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        log("doGet /cartelera – fetching funcionesHoy desde DAO");

        try {
            List<FuncionHoy> funcionesHoy = dao.obtenerFuncionesHoy();
            req.setAttribute("funcionesHoy", funcionesHoy);
        } catch (SQLException e) {
            throw new ServletException("Error al obtener funciones de hoy", e);
        }

        req.getRequestDispatcher("/vista/cartelera.jsp")
           .forward(req, resp);
    }
}
