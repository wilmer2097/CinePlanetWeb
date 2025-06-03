// src/main/java/com/cineplanet/cineplanetweb/dao/SugerenciaDAO.java
package com.cineplanet.cineplanetweb.dao;

import com.cineplanet.cineplanetweb.controller.Conexion;
import com.cineplanet.cineplanetweb.model.Sugerencia;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class SugerenciaDAO {
    //Presenta errores o eventos importantes .
    private static final Logger LOGGER = Logger.getLogger(SugerenciaDAO.class.getName());

    private static final String SQL_INSERT =
        "INSERT INTO sugerencias (nombre, email, telefono, categoria, sugerencia, fecha_registro) " +
        "VALUES (?, ?, ?, ?, ?, ?)";

    private static final String SQL_FIND_BY_ID =
        "SELECT * FROM sugerencias WHERE sugerencia_id = ?";

    private static final String SQL_FIND_ALL =
        "SELECT * FROM sugerencias ORDER BY fecha_registro DESC";

    /** Inserta una sugerencia y devuelve el objeto con ID y fecha_registro rellenados */
    // Crea un carton de huevos , parametro son los huevinos , creo el espacio 
    public Sugerencia create(Sugerencia s) throws SQLException {
        try (Connection con = Conexion.getConnection();
             PreparedStatement ps = con.prepareStatement(SQL_INSERT, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, s.getNombre());
            ps.setString(2, s.getEmail());
            ps.setString(3, s.getTelefono());
            ps.setString(4, s.getCategoria());
            ps.setString(5, s.getTexto());
            LocalDateTime now = LocalDateTime.now();
            ps.setTimestamp(6, Timestamp.valueOf(now));

            int rows = ps.executeUpdate();
            if (rows == 0) {
                throw new SQLException("Crear sugerencia falló, no se insertó ninguna fila.");
            }
            // En caso de que fallo esto , recupera 
            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) {
                    s.setId(keys.getInt(1));
                    s.setFechaRegistro(now);
                }
            }
            return s;
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error al insertar sugerencia: " + s, ex);
            throw ex;
        }
    }

    /** Busca una sugerencia por su ID */
    public Optional<Sugerencia> findById(int id) throws SQLException {
        try (Connection con = Conexion.getConnection();
             PreparedStatement ps = con.prepareStatement(SQL_FIND_BY_ID)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(mapRow(rs));
                }
            }
            return Optional.empty();
        }
    }

    /** Recupera todas las sugerencias */
    public List<Sugerencia> findAll() throws SQLException {
        List<Sugerencia> list = new ArrayList<>();
        try (Connection con = Conexion.getConnection();
             PreparedStatement ps = con.prepareStatement(SQL_FIND_ALL);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        }
        return list;
    }

    /** Convierte un ResultSet en un objeto Sugerencia */
    private Sugerencia mapRow(ResultSet rs) throws SQLException {
        Sugerencia s = new Sugerencia();
        s.setId(rs.getInt("sugerencia_id"));
        s.setNombre(rs.getString("nombre"));
        s.setEmail(rs.getString("email"));
        s.setTelefono(rs.getString("telefono"));
        s.setCategoria(rs.getString("categoria"));
        s.setTexto(rs.getString("sugerencia"));
        Timestamp ts = rs.getTimestamp("fecha_registro");
        if (ts != null) {
            s.setFechaRegistro(ts.toLocalDateTime());
        }
        return s;
    }
}
