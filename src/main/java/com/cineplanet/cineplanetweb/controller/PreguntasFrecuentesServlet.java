// src/main/java/com/cineplanet/cineplanetweb/controller/PreguntasFrecuentesServlet.java
package com.cineplanet.cineplanetweb.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "PreguntasFrecuentesServlet", urlPatterns = {"/preguntas-frecuentes"})
public class PreguntasFrecuentesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Forward al JSP de preguntas frecuentes
        req.getRequestDispatcher("/vista/preguntas-frec.jsp")
           .forward(req, resp);
    }
}
