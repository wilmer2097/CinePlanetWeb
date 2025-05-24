// src/main/java/com/cineplanet/cineplanetweb/controller/CarteleraServlet.java
package com.cineplanet.cineplanetweb.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "CarteleraServlet", urlPatterns = {"/cartelera"})
public class CarteleraServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        log("🛠 doGet /cartelera – forward a vista/cartelera.jsp");
        req.getRequestDispatcher("/vista/cartelera.jsp")
           .forward(req, resp);
    }
}
