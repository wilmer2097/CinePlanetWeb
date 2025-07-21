// Este paquete contiene la lógica de acceso a datos (DAO - Data Access Object)
package com.cineplanet.cineplanetweb.dao;

// Se importa la clase de conexión a la base de datos
import com.cineplanet.cineplanetweb.controller.Conexion;

// Se importa el modelo Pelicula que representa los datos de una película
import com.cineplanet.cineplanetweb.model.Pelicula;

import java.nio.charset.StandardCharsets;  // Para trabajar con codificación UTF-8
import java.sql.*;                         // Para trabajar con SQL y conexiones a BD
import java.util.*;                        // Para usar listas y otras estructuras

// Clase DAO para manejar operaciones con la tabla "pelicula"
public class PeliculaDAO {

    // Consulta SQL para insertar una nueva película
    private static final String SQL_INSERT =
        "INSERT INTO pelicula (titulo, duracion_min, sinopsis, clasificacion, estreno, img_url) VALUES (?, ?, ?, ?, ?, ?)";

    // Consulta SQL para obtener todas las películas ordenadas por fecha de estreno descendente
    private static final String SQL_SELECT_ALL =
        "SELECT * FROM pelicula ORDER BY estreno DESC";

    // Consulta SQL para eliminar una película por su ID
    private static final String SQL_DELETE =
        "DELETE FROM pelicula WHERE pelicula_id = ?";

    // Método auxiliar para asegurarse de que los textos estén bien codificados en UTF-8
    private String sanitizeUTF8(String text) {
        if (text == null) return null;
        // Se vuelve a codificar en UTF-8 para evitar caracteres raros
        return new String(text.getBytes(StandardCharsets.UTF_8), StandardCharsets.UTF_8).trim();
    }

    // Método para insertar una nueva película en la base de datos
    public void create(Pelicula p) throws SQLException {
        try (
            // Abre conexión con la BD
            Connection con = Conexion.getConnection();
            // Prepara la consulta SQL para evitar SQL Injection
            PreparedStatement ps = con.prepareStatement(SQL_INSERT)
        ) {
            // Se setean los parámetros del PreparedStatement con los datos de la película
            ps.setString(1, sanitizeUTF8(p.getTitulo()));
            ps.setInt(2, p.getDuracionMin());
            ps.setString(3, sanitizeUTF8(p.getSinopsis()));
            ps.setString(4, sanitizeUTF8(p.getClasificacion()));
            ps.setString(5, p.getEstreno());
            ps.setString(6, sanitizeUTF8(p.getImgUrl()));

            // Ejecuta la inserción
            ps.executeUpdate();
        }
    }

    // Método para actualizar los datos de una película existente
    public void update(Pelicula p) throws SQLException {
        String sql = "UPDATE pelicula SET titulo = ?, duracion_min = ?, sinopsis = ?, clasificacion = ?, estreno = ?, img_url = ? WHERE pelicula_id = ?";
        try (
            Connection con = Conexion.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setString(1, sanitizeUTF8(p.getTitulo()));
            ps.setInt(2, p.getDuracionMin());
            ps.setString(3, sanitizeUTF8(p.getSinopsis()));
            ps.setString(4, sanitizeUTF8(p.getClasificacion()));
            ps.setString(5, p.getEstreno());
            ps.setString(6, sanitizeUTF8(p.getImgUrl()));
            ps.setInt(7, p.getId());

            ps.executeUpdate(); // Ejecuta la actualización
        }
    }

    // Método para obtener todas las películas de la base de datos
    public List<Pelicula> findAll() throws SQLException {
        List<Pelicula> lista = new ArrayList<>(); // Lista donde se almacenarán los resultados
        try (
            Connection con = Conexion.getConnection();
            PreparedStatement ps = con.prepareStatement(SQL_SELECT_ALL);
            ResultSet rs = ps.executeQuery() // Ejecuta la consulta
        ) {
            // Mientras haya resultados...
            while (rs.next()) {
                Pelicula p = new Pelicula(); // Se crea un objeto Pelicula vacío

                // Se llenan los datos desde la BD
                p.setId(rs.getInt("pelicula_id"));
                p.setTitulo(rs.getString("titulo"));
                p.setDuracionMin(rs.getInt("duracion_min"));
                p.setSinopsis(rs.getString("sinopsis"));
                p.setClasificacion(rs.getString("clasificacion"));
                p.setEstreno(rs.getString("estreno"));
                p.setImgUrl(rs.getString("img_url"));

                // Se añade a la lista
                lista.add(p);
            }
        }
        return lista; // Devuelve la lista de películas
    }

    // Método para eliminar una película por su ID
    public void delete(int id) throws SQLException {
        try (
            Connection con = Conexion.getConnection();
            PreparedStatement ps = con.prepareStatement(SQL_DELETE)
        ) {
            ps.setInt(1, id);     // Se indica qué película se va a eliminar
            ps.executeUpdate();   // Ejecuta el DELETE
        }
    }
}
