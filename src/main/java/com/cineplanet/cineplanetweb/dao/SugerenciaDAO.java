
package com.cineplanet.cineplanetweb.dao;

import com.cineplanet.cineplanetweb.model.Sugerencia;
import java.sql.*;

public class SugerenciaDAO {

    private final String URL = "jdbc:mysql://localhost:3306/cineplanet_web";
    private final String USUARIO = "root";
    private final String CLAVE = "@123polFer123"; /*cambiar de acuerdo a tu propio pass*/

    private Connection conectar() throws SQLException {
        return DriverManager.getConnection(URL, USUARIO, CLAVE);
    }

    public boolean guardarSugerencia(Sugerencia s) {
        String sql = "INSERT INTO sugerencias (nombre, email, telefono, categoria, sugerencia) VALUES (?, ?, ?, ?, ?)";

        try (Connection con = conectar(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, s.getNombre());
            ps.setString(2, s.getEmail());
            ps.setString(3, s.getTelefono());
            ps.setString(4, s.getCategoria());
            ps.setString(5, s.getSugerencia());

            ps.executeUpdate();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}

