/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cineplanet.cineplanetweb.dao;

/**
 *
 * @author wilme
 */

import com.cineplanet.cineplanetweb.controller.Conexion;
import com.cineplanet.cineplanetweb.model.Pelicula;

import java.sql.*;
import java.util.*;

public class PeliculaDAO {

    private static final String SQL_INSERT = "INSERT INTO pelicula (titulo, duracion_min, sinopsis, clasificacion, estreno, img_url) VALUES (?, ?, ?, ?, ?, ?)";
    private static final String SQL_SELECT_ALL = "SELECT * FROM pelicula ORDER BY estreno DESC";
    private static final String SQL_DELETE = "DELETE FROM pelicula WHERE pelicula_id = ?";

    public void create(Pelicula p) throws SQLException {
        try (Connection con = Conexion.getConnection();
             PreparedStatement ps = con.prepareStatement(SQL_INSERT)) {
            ps.setString(1, p.getTitulo());
            ps.setInt(2, p.getDuracionMin());
            ps.setString(3, p.getSinopsis());
            ps.setString(4, p.getClasificacion());
            ps.setString(5, p.getEstreno());
            ps.setString(6, p.getImgUrl());
            ps.executeUpdate();
        }
    }
    public void update(Pelicula p) throws SQLException {
    String sql = "UPDATE pelicula SET titulo = ?, duracion_min = ?, sinopsis = ?, clasificacion = ?, estreno = ?, img_url = ? WHERE pelicula_id = ?";
    try (Connection con = Conexion.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setString(1, p.getTitulo());
        ps.setInt(2, p.getDuracionMin());
        ps.setString(3, p.getSinopsis());
        ps.setString(4, p.getClasificacion());
        ps.setString(5, p.getEstreno());
        ps.setString(6, p.getImgUrl());
        ps.setInt(7, p.getId());

        ps.executeUpdate();
    }
}
    public List<Pelicula> findAll() throws SQLException {
        List<Pelicula> lista = new ArrayList<>();
        try (Connection con = Conexion.getConnection();
             PreparedStatement ps = con.prepareStatement(SQL_SELECT_ALL);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Pelicula p = new Pelicula();
                p.setId(rs.getInt("pelicula_id"));
                p.setTitulo(rs.getString("titulo"));
                p.setDuracionMin(rs.getInt("duracion_min"));
                p.setSinopsis(rs.getString("sinopsis"));
                p.setClasificacion(rs.getString("clasificacion"));
                p.setEstreno(rs.getString("estreno"));
                p.setImgUrl(rs.getString("img_url"));
                lista.add(p);
            }
        }
        return lista;
    }

    public void delete(int id) throws SQLException {
        try (Connection con = Conexion.getConnection();
             PreparedStatement ps = con.prepareStatement(SQL_DELETE)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }
}
