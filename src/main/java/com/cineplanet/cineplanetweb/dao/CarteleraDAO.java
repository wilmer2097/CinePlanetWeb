package com.cineplanet.cineplanetweb.dao;

import com.cineplanet.cineplanetweb.controller.Conexion;
import com.cineplanet.cineplanetweb.model.FuncionHoy;
import com.cineplanet.cineplanetweb.model.Pelicula;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CarteleraDAO {
    public List<Pelicula> obtenerProximosEstrenos() throws SQLException {
        String sql = "SELECT pelicula_id, titulo, duracion_min, sinopsis, clasificacion, estreno, img_url " +
                     "FROM pelicula WHERE estreno > CURDATE() ORDER BY estreno ASC";

        List<Pelicula> lista = new ArrayList<>();
        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Pelicula p = new Pelicula();
                p.setId(rs.getInt("pelicula_id"));
                p.setTitulo(rs.getString("titulo"));
                p.setDuracionMin(rs.getInt("duracion_min"));
                p.setSinopsis(rs.getString("sinopsis"));
                p.setClasificacion(rs.getString("clasificacion"));
                p.setEstreno(rs.getString("estreno")); // ya es String
                p.setImgUrl(rs.getString("img_url"));
                lista.add(p);
            }
        }
        return lista;
    }

    public List<FuncionHoy> obtenerFuncionesHoy() throws SQLException {
        String sql =
          "SELECT funcion_id, titulo, sinopsis, img_url, complejo, sala, fecha_hora, idioma, precio_base "
        + "FROM cartelera_hoy";

        List<FuncionHoy> lista = new ArrayList<>();
        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                FuncionHoy f = new FuncionHoy();
                f.setFuncionId(rs.getInt("funcion_id"));
                f.setTitulo(rs.getString("titulo"));
                f.setSinopsis(rs.getString("sinopsis"));
                f.setImgUrl(rs.getString("img_url"));
                f.setComplejo(rs.getString("complejo"));
                f.setSala(rs.getString("sala"));

                // Leemos directamente un java.sql.Timestamp (subclase de Date)
                Timestamp ts = rs.getTimestamp("fecha_hora");
                f.setFechaHora(ts);  

                f.setIdioma(rs.getString("idioma"));
                f.setPrecioBase(rs.getDouble("precio_base"));

                lista.add(f);
            }
        }
        return lista;
    }
}
