package com.cineplanet.cineplanetweb.controller;

import com.cineplanet.cineplanetweb.dao.FuncionDAO;
import com.cineplanet.cineplanetweb.model.FuncionDTO;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/admin/funciones")
public class FuncionServlet extends HttpServlet {
    
    private FuncionDAO funcionDAO = new FuncionDAO();
    private Gson gson = new Gson();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        try {
            switch (action != null ? action : "listar") {
                case "listar":
                    listarFunciones(response);
                    break;
                case "obtener":
                    obtenerFuncion(request, response);
                    break;
                default:
                    enviarError(response, "Acción no válida");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            enviarError(response, "Error en la base de datos: " + e.getMessage());
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        try {
            switch (action != null ? action : "") {
                case "crear":
                    crearFuncion(request, response);
                    break;
                case "actualizar":
                    actualizarFuncion(request, response);
                    break;
                case "eliminar":
                    eliminarFuncion(request, response);
                    break;
                default:
                    enviarError(response, "Acción no válida");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            enviarError(response, "Error en la base de datos: " + e.getMessage());
        }
    }
    
    private void listarFunciones(HttpServletResponse response) throws SQLException, IOException {
        List<FuncionDTO> funciones = funcionDAO.listarTodas();
        
        JsonObject jsonResponse = new JsonObject();
        jsonResponse.addProperty("success", true);
        jsonResponse.addProperty("message", "Funciones obtenidas correctamente");
        jsonResponse.add("data", gson.toJsonTree(funciones));
        
        try (PrintWriter out = response.getWriter()) {
            out.print(gson.toJson(jsonResponse));
        }
    }
    
    private void obtenerFuncion(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, IOException {
        
        try {
            int funcionId = Integer.parseInt(request.getParameter("id"));
            FuncionDTO funcion = funcionDAO.obtenerPorId(funcionId);
            
            JsonObject jsonResponse = new JsonObject();
            if (funcion != null) {
                jsonResponse.addProperty("success", true);
                jsonResponse.addProperty("message", "Función encontrada");
                jsonResponse.add("data", gson.toJsonTree(funcion));
            } else {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Función no encontrada");
            }
            
            try (PrintWriter out = response.getWriter()) {
                out.print(gson.toJson(jsonResponse));
            }
        } catch (NumberFormatException e) {
            enviarError(response, "ID de función no válido");
        }
    }
    
    private void crearFuncion(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, IOException {
        
        try {
            FuncionDTO funcion = extraerDatosFuncion(request);
            
            // Verificar conflicto de horarios
            if (funcionDAO.existeConflictoHorario(funcion.getSalaId(), funcion.getFechaHora(), 0)) {
                JsonObject jsonResponse = new JsonObject();
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Ya existe una función programada en esa sala con horario conflictivo");
                
                try (PrintWriter out = response.getWriter()) {
                    out.print(gson.toJson(jsonResponse));
                }
                return;
            }
            
            boolean exito = funcionDAO.crear(funcion);
            
            JsonObject jsonResponse = new JsonObject();
            if (exito) {
                jsonResponse.addProperty("success", true);
                jsonResponse.addProperty("message", "Función creada correctamente");
            } else {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Error al crear la función");
            }
            
            try (PrintWriter out = response.getWriter()) {
                out.print(gson.toJson(jsonResponse));
            }
            
        } catch (Exception e) {
            enviarError(response, "Error al procesar los datos: " + e.getMessage());
        }
    }
    
    private void actualizarFuncion(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, IOException {
        
        try {
            int funcionId = Integer.parseInt(request.getParameter("funcionId"));
            FuncionDTO funcion = extraerDatosFuncion(request);
            funcion.setFuncionId(funcionId);
            
            // Verificar conflicto de horarios (excluyendo la función actual)
            if (funcionDAO.existeConflictoHorario(funcion.getSalaId(), funcion.getFechaHora(), funcionId)) {
                JsonObject jsonResponse = new JsonObject();
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Ya existe una función programada en esa sala con horario conflictivo");
                
                try (PrintWriter out = response.getWriter()) {
                    out.print(gson.toJson(jsonResponse));
                }
                return;
            }
            
            boolean exito = funcionDAO.actualizar(funcion);
            
            JsonObject jsonResponse = new JsonObject();
            if (exito) {
                jsonResponse.addProperty("success", true);
                jsonResponse.addProperty("message", "Función actualizada correctamente");
            } else {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Error al actualizar la función");
            }
            
            try (PrintWriter out = response.getWriter()) {
                out.print(gson.toJson(jsonResponse));
            }
            
        } catch (Exception e) {
            enviarError(response, "Error al procesar los datos: " + e.getMessage());
        }
    }
    
    private void eliminarFuncion(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, IOException {
        
        try {
            int funcionId = Integer.parseInt(request.getParameter("funcionId"));
            boolean exito = funcionDAO.eliminar(funcionId);
            
            JsonObject jsonResponse = new JsonObject();
            if (exito) {
                jsonResponse.addProperty("success", true);
                jsonResponse.addProperty("message", "Función eliminada correctamente");
            } else {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Error al eliminar la función");
            }
            
            try (PrintWriter out = response.getWriter()) {
                out.print(gson.toJson(jsonResponse));
            }
            
        } catch (NumberFormatException e) {
            enviarError(response, "ID de función no válido");
        }
    }
    
    private FuncionDTO extraerDatosFuncion(HttpServletRequest request) throws Exception {
        FuncionDTO funcion = new FuncionDTO();
        
        // Validar y establecer sala_id
        String salaIdStr = request.getParameter("sala_id");
        if (salaIdStr == null || salaIdStr.trim().isEmpty()) {
            throw new Exception("El ID de sala es requerido");
        }
        funcion.setSalaId(Integer.parseInt(salaIdStr));
        
        // Validar y establecer pelicula_id
        String peliculaIdStr = request.getParameter("pelicula_id");
        if (peliculaIdStr == null || peliculaIdStr.trim().isEmpty()) {
            throw new Exception("El ID de película es requerido");
        }
        funcion.setPeliculaId(Integer.parseInt(peliculaIdStr));
        
        // Validar y establecer fecha_hora
        String fechaHoraStr = request.getParameter("fecha_hora");
        if (fechaHoraStr == null || fechaHoraStr.trim().isEmpty()) {
            throw new Exception("La fecha y hora son requeridas");
        }
        
        // Convertir string datetime-local a Timestamp
        LocalDateTime fechaHora = LocalDateTime.parse(fechaHoraStr, DateTimeFormatter.ISO_LOCAL_DATE_TIME);
        funcion.setFechaHora(Timestamp.valueOf(fechaHora));
        
        // Validar y establecer idioma
        String idioma = request.getParameter("idioma");
        if (idioma == null || idioma.trim().isEmpty()) {
            idioma = "SUB"; // Valor por defecto
        }
        funcion.setIdioma(idioma);
        
        // Validar y establecer precio_base
        String precioBaseStr = request.getParameter("precio_base");
        if (precioBaseStr == null || precioBaseStr.trim().isEmpty()) {
            throw new Exception("El precio base es requerido");
        }
        BigDecimal precioBase = new BigDecimal(precioBaseStr);
        if (precioBase.compareTo(BigDecimal.ZERO) <= 0) {
            throw new Exception("El precio base debe ser mayor a cero");
        }
        funcion.setPrecioBase(precioBase);
        
        return funcion;
    }
    
    private void enviarError(HttpServletResponse response, String mensaje) throws IOException {
        JsonObject jsonResponse = new JsonObject();
        jsonResponse.addProperty("success", false);
        jsonResponse.addProperty("message", mensaje);
        
        try (PrintWriter out = response.getWriter()) {
            out.print(gson.toJson(jsonResponse));
        }
    }
}