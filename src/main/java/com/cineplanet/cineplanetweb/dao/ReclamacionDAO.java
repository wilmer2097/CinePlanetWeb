
package com.cineplanet.cineplanetweb.dao;

import com.cineplanet.cineplanetweb.controller.Conexion;
import com.cineplanet.cineplanetweb.model.Reclamacion;
import java.sql.*;


public class ReclamacionDAO {
    public void insertarReclamacion(Reclamacion r) {
        String sql = "INSERT INTO reclamaciones (nombre, dni, telefono, email, direccion, cine, fecha_incidente, tipo, detalle, pedido, acepta_terminos) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = Conexion.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, r.getNombre());
            ps.setString(2, r.getDni());
            ps.setString(3, r.getTelefono());
            ps.setString(4, r.getEmail());
            ps.setString(5, r.getDireccion());
            ps.setString(6, r.getCine());
            ps.setDate(7, java.sql.Date.valueOf(r.getFechaIncidente()));
            ps.setString(8, r.getTipo());
            ps.setString(9, r.getDetalle());
            ps.setString(10, r.getPedido());
            ps.setBoolean(11, r.isAceptaTerminos());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

