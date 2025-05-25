
package com.cineplanet.cineplanetweb.dao;

import com.cineplanet.cineplanetweb.controller.Conexion;
import com.cineplanet.cineplanetweb.model.Sugerencia;
import java.sql.*;


public class SugerenciaDAO {
    public void insertarSugerencia(Sugerencia s) {
        String sql = "INSERT INTO sugerencias (nombre, email, telefono, categoria, sugerencia) VALUES (?, ?, ?, ?, ?)";

        try (Connection con = Conexion.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, s.getNombre());
            ps.setString(2, s.getEmail());
            ps.setString(3, s.getTelefono());
            ps.setString(4, s.getCategoria());
            ps.setString(5, s.getSugerencia());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

