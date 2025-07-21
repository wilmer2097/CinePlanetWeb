/*
 * Plantillas de licencia y edición del IDE NetBeans
 */
package com.cineplanet.cineplanetweb.api;

// Importa la clase que maneja las películas desde la base de datos
import com.cineplanet.cineplanetweb.dao.PeliculaDAO;
// Importa el modelo de Película
import com.cineplanet.cineplanetweb.model.Pelicula;
// Importa la librería Gson para convertir objetos Java en JSON
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

// Librerías de Java EE para manejar Servlets y peticiones HTTP
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/**
 * Servlet que funciona como API REST en /api/peliculas
 * Responde con una lista de películas en formato JSON
 */
@WebServlet("/api/peliculas")
public class PeliculaApiServlet extends HttpServlet {

    // Objeto para acceder a la base de datos de películas
    private PeliculaDAO dao = new PeliculaDAO();
    // Objeto Gson configurado para convertir fechas al formato yyyy-MM-dd
    private Gson gson = new GsonBuilder()
                            .setDateFormat("yyyy-MM-dd")
                            .create();

    // Método que responde a solicitudes GET (cuando alguien entra a /api/peliculas)
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Define que la respuesta será en formato JSON
        resp.setContentType("application/json;charset=UTF-8");

        try {
            // Llama al DAO para obtener la lista de películas
            List<Pelicula> lista = dao.findAll();
            // Convierte esa lista en un string JSON
            String json = gson.toJson(lista);
            // Escribe ese JSON en la respuesta
            resp.getWriter().write(json);
        } catch (SQLException e) {
            // Si hay un error con la base de datos, responde con estado 500
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            // Crea un objeto de error y lo convierte en JSON
            resp.getWriter().write(
              gson.toJson(
                new ErrorResponse("Error al leer películas", e.getMessage())
              )
            );
        }
    }

    // Clase interna para estructurar mensajes de error en formato JSON
    private static class ErrorResponse {
        private String error;
        private String detalle;

        public ErrorResponse(String error, String detalle) {
            this.error   = error;
            this.detalle = detalle;
        }

        public String getError() { return error; }
        public String getDetalle() { return detalle; }
    }
}
