// src/main/java/com/cineplanet/cineplanetweb/dao/ReclamacionDAO.java
package com.cineplanet.cineplanetweb.dao;

import com.cineplanet.cineplanetweb.controller.Conexion;
import com.cineplanet.cineplanetweb.model.Reclamacion;
// Prueba 1
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ReclamacionDAO {
    private static final Logger LOGGER = Logger.getLogger(ReclamacionDAO.class.getName());

    private static final String SQL_INSERT =
        "INSERT INTO reclamaciones " +
        "(nombre, dni, telefono, email, direccion, cine, fecha_incidente, tipo, detalle, pedido, acepta_terminos) " +
        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    private static final String SQL_FIND_BY_ID =
        "SELECT * FROM reclamaciones WHERE reclamacion_id = ?";
    private static final String SQL_FIND_ALL =
        "SELECT * FROM reclamaciones ORDER BY fecha_incidente DESC";

    /**
     * Inserta una nueva reclamación y devuelve el objeto con su ID generado.
     */
    public Reclamacion create(Reclamacion r) throws SQLException {
        try (Connection con = Conexion.getConnection();
             PreparedStatement ps = con.prepareStatement(SQL_INSERT, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, r.getNombre());
            ps.setString(2, r.getDni());
            ps.setString(3, r.getTelefono());
            ps.setString(4, r.getEmail());
            ps.setString(5, r.getDireccion());
            ps.setString(6, r.getCine());
            ps.setDate(7, Date.valueOf(r.getFechaIncidente()));
            ps.setString(8, r.getTipo());
            ps.setString(9, r.getDetalle());
            ps.setString(10, r.getPedido());
            ps.setBoolean(11, r.isAceptaTerminos());

            int affected = ps.executeUpdate();
            if (affected == 0) {
                throw new SQLException("Crear reclamación falló, no se insertó ninguna fila.");
            }

            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) {
                    r.setId(keys.getInt(1));
                }
            }

            return r;
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error al insertar reclamación: " + r, ex);
            throw ex;
        }
    }

    /**
     * Busca una reclamación por ID.
     */
    public Optional<Reclamacion> findById(int id) throws SQLException {
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

    /**
     * Recupera todas las reclamaciones.
     */
    public List<Reclamacion> findAll() throws SQLException {
        List<Reclamacion> lista = new ArrayList<>();
        try (Connection con = Conexion.getConnection();
             PreparedStatement ps = con.prepareStatement(SQL_FIND_ALL);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                lista.add(mapRow(rs));
            }
        }
        return lista;
    }

    /**
     * Mapea una fila de ResultSet a un objeto Reclamacion.
     */
    private Reclamacion mapRow(ResultSet rs) throws SQLException {
        Reclamacion r = new Reclamacion();
        r.setId(rs.getInt("reclamacion_id"));
        r.setNombre(rs.getString("nombre"));
        r.setDni(rs.getString("dni"));
        r.setTelefono(rs.getString("telefono"));
        r.setEmail(rs.getString("email"));
        r.setDireccion(rs.getString("direccion"));
        r.setCine(rs.getString("cine"));
        r.setFechaIncidente(rs.getDate("fecha_incidente").toLocalDate());
        r.setTipo(rs.getString("tipo"));
        r.setDetalle(rs.getString("detalle"));
        r.setPedido(rs.getString("pedido"));
        r.setAceptaTerminos(rs.getBoolean("acepta_terminos"));
        return r;
    }
}
