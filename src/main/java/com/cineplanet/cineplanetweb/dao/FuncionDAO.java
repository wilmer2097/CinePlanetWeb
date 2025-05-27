package com.cineplanet.cineplanetweb.dao;

import com.cineplanet.cineplanetweb.controller.Conexion;
import com.cineplanet.cineplanetweb.model.FuncionDTO;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FuncionDAO {
    
    public List<FuncionDTO> listarTodas() throws SQLException {
        List<FuncionDTO> funciones = new ArrayList<>();
        String sql =
            "SELECT " +
            "f.funcion_id, " +
            "f.sala_id, " +
            "f.pelicula_id, " +
            "f.fecha_hora, " +
            "f.idioma, " +
            "f.precio_base, " +
            "s.nombre as nombre_sala, " +
            "p.titulo as nombre_pelicula " +
            "FROM funcion f " +
            "LEFT JOIN sala s ON f.sala_id = s.sala_id " +
            "LEFT JOIN pelicula p ON f.pelicula_id = p.pelicula_id " +
            "ORDER BY f.fecha_hora DESC";

        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                FuncionDTO funcion = new FuncionDTO();
                funcion.setFuncionId(rs.getInt("funcion_id"));
                funcion.setSalaId(rs.getInt("sala_id"));
                funcion.setPeliculaId(rs.getInt("pelicula_id"));
                funcion.setFechaHora(rs.getTimestamp("fecha_hora"));
                funcion.setIdioma(rs.getString("idioma"));
                funcion.setPrecioBase(rs.getBigDecimal("precio_base"));
                funcion.setNombreSala(rs.getString("nombre_sala"));
                funcion.setNombrePelicula(rs.getString("nombre_pelicula"));
                funciones.add(funcion);
            }
        }
        
        return funciones;
    }
    
    public FuncionDTO obtenerPorId(int funcionId) throws SQLException {
        String sql =
            "SELECT " +
            "f.funcion_id, " +
            "f.sala_id, " +
            "f.pelicula_id, " +
            "f.fecha_hora, " +
            "f.idioma, " +
            "f.precio_base, " +
            "s.nombre as nombre_sala, " +
            "p.titulo as nombre_pelicula " +
            "FROM funcion f " +
            "LEFT JOIN sala s ON f.sala_id = s.sala_id " +
            "LEFT JOIN pelicula p ON f.pelicula_id = p.pelicula_id " +
            "WHERE f.funcion_id = ?";

        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, funcionId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    FuncionDTO funcion = new FuncionDTO();
                    funcion.setFuncionId(rs.getInt("funcion_id"));
                    funcion.setSalaId(rs.getInt("sala_id"));
                    funcion.setPeliculaId(rs.getInt("pelicula_id"));
                    funcion.setFechaHora(rs.getTimestamp("fecha_hora"));
                    funcion.setIdioma(rs.getString("idioma"));
                    funcion.setPrecioBase(rs.getBigDecimal("precio_base"));
                    funcion.setNombreSala(rs.getString("nombre_sala"));
                    funcion.setNombrePelicula(rs.getString("nombre_pelicula"));
                    return funcion;
                }
            }
        }
        
        return null;
    }
    
    public boolean crear(FuncionDTO funcion) throws SQLException {
        String sql =
            "INSERT INTO funcion (sala_id, pelicula_id, fecha_hora, idioma, precio_base) " +
            "VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, funcion.getSalaId());
            ps.setInt(2, funcion.getPeliculaId());
            ps.setTimestamp(3, funcion.getFechaHora());
            ps.setString(4, funcion.getIdioma());
            ps.setBigDecimal(5, funcion.getPrecioBase());
            
            return ps.executeUpdate() > 0;
        }
    }
    
    public boolean actualizar(FuncionDTO funcion) throws SQLException {
        String sql =
            "UPDATE funcion " +
            "SET sala_id = ?, pelicula_id = ?, fecha_hora = ?, idioma = ?, precio_base = ? " +
            "WHERE funcion_id = ?";

        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, funcion.getSalaId());
            ps.setInt(2, funcion.getPeliculaId());
            ps.setTimestamp(3, funcion.getFechaHora());
            ps.setString(4, funcion.getIdioma());
            ps.setBigDecimal(5, funcion.getPrecioBase());
            ps.setInt(6, funcion.getFuncionId());
            
            return ps.executeUpdate() > 0;
        }
    }
    
    public boolean eliminar(int funcionId) throws SQLException {
        String sql = "DELETE FROM funcion WHERE funcion_id = ?";

        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, funcionId);
            return ps.executeUpdate() > 0;
        }
    }
    
    public boolean existeConflictoHorario(int salaId, Timestamp fechaHora, int funcionIdExcluir) throws SQLException {
        String sql =
            "SELECT COUNT(*) " +
            "FROM funcion " +
            "WHERE sala_id = ? " +
            "AND funcion_id != ? " +
            "AND ( " +
            "(fecha_hora <= ? AND DATE_ADD(fecha_hora, INTERVAL 3 HOUR) > ?) OR " +
            "(fecha_hora < DATE_ADD(?, INTERVAL 3 HOUR) AND fecha_hora >= ?) " +
            ")";

        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, salaId);
            ps.setInt(2, funcionIdExcluir);
            ps.setTimestamp(3, fechaHora);
            ps.setTimestamp(4, fechaHora);
            ps.setTimestamp(5, fechaHora);
            ps.setTimestamp(6, fechaHora);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        
        return false;
    }
    
    public List<FuncionDTO> obtenerPorSala(int salaId) throws SQLException {
        List<FuncionDTO> funciones = new ArrayList<>();
        String sql =
            "SELECT " +
            "f.funcion_id, " +
            "f.sala_id, " +
            "f.pelicula_id, " +
            "f.fecha_hora, " +
            "f.idioma, " +
            "f.precio_base, " +
            "s.nombre as nombre_sala, " +
            "p.titulo as nombre_pelicula " +
            "FROM funcion f " +
            "LEFT JOIN sala s ON f.sala_id = s.sala_id " +
            "LEFT JOIN pelicula p ON f.pelicula_id = p.pelicula_id " +
            "WHERE f.sala_id = ? " +
            "ORDER BY f.fecha_hora ASC";

        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, salaId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    FuncionDTO funcion = new FuncionDTO();
                    funcion.setFuncionId(rs.getInt("funcion_id"));
                    funcion.setSalaId(rs.getInt("sala_id"));
                    funcion.setPeliculaId(rs.getInt("pelicula_id"));
                    funcion.setFechaHora(rs.getTimestamp("fecha_hora"));
                    funcion.setIdioma(rs.getString("idioma"));
                    funcion.setPrecioBase(rs.getBigDecimal("precio_base"));
                    funcion.setNombreSala(rs.getString("nombre_sala"));
                    funcion.setNombrePelicula(rs.getString("nombre_pelicula"));
                    funciones.add(funcion);
                }
            }
        }
        
        return funciones;
    }
    
    public List<FuncionDTO> obtenerPorPelicula(int peliculaId) throws SQLException {
        List<FuncionDTO> funciones = new ArrayList<>();
        String sql =
            "SELECT " +
            "f.funcion_id, " +
            "f.sala_id, " +
            "f.pelicula_id, " +
            "f.fecha_hora, " +
            "f.idioma, " +
            "f.precio_base, " +
            "s.nombre as nombre_sala, " +
            "p.titulo as nombre_pelicula " +
            "FROM funcion f " +
            "LEFT JOIN sala s ON f.sala_id = s.sala_id " +
            "LEFT JOIN pelicula p ON f.pelicula_id = p.pelicula_id " +
            "WHERE f.pelicula_id = ? " +
            "ORDER BY f.fecha_hora ASC";

        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, peliculaId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    FuncionDTO funcion = new FuncionDTO();
                    funcion.setFuncionId(rs.getInt("funcion_id"));
                    funcion.setSalaId(rs.getInt("sala_id"));
                    funcion.setPeliculaId(rs.getInt("pelicula_id"));
                    funcion.setFechaHora(rs.getTimestamp("fecha_hora"));
                    funcion.setIdioma(rs.getString("idioma"));
                    funcion.setPrecioBase(rs.getBigDecimal("precio_base"));
                    funcion.setNombreSala(rs.getString("nombre_sala"));
                    funcion.setNombrePelicula(rs.getString("nombre_pelicula"));
                    funciones.add(funcion);
                }
            }
        }
        
        return funciones;
    }
}
