/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cineplanet.cineplanetweb.api;

import com.cineplanet.cineplanetweb.dao.PeliculaDAO;
import com.cineplanet.cineplanetweb.model.Pelicula;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
/**
 *
 * @author wilme
 */
@WebServlet("/api/peliculas")
public class PeliculaApiServlet extends HttpServlet {

    private PeliculaDAO dao = new PeliculaDAO();
    private Gson gson = new GsonBuilder()
                            .setDateFormat("yyyy-MM-dd")
                            .create();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.setContentType("application/json;charset=UTF-8");
        try {
            List<Pelicula> lista = dao.findAll();
            String json = gson.toJson(lista);
            resp.getWriter().write(json);
        } catch (SQLException e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write(
              gson.toJson(
                new ErrorResponse("Error al leer películas", e.getMessage())
              )
            );
        }
    }

    // Clase interna para reportar errores en JSON
    private static class ErrorResponse {
        private String error;
        private String detalle;
        public ErrorResponse(String error, String detalle) {
            this.error   = error;
            this.detalle = detalle;
        }
        // getters...
        public String getError() { return error; }
        public String getDetalle() { return detalle; }
    }
}