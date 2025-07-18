// src/main/java/com/cineplanet/cineplanetweb/dao/UserDAO.java
package com.cineplanet.cineplanetweb.dao;

import com.cineplanet.cineplanetweb.controller.Conexion;
import com.cineplanet.cineplanetweb.model.Role;
import com.cineplanet.cineplanetweb.model.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

public User validate(String email, String password) throws SQLException {
    String sql = "SELECT usuario_id, nombre, email, password, telefono "
               + "FROM usuario WHERE email = ? AND password = ?";
    try (Connection conn = Conexion.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setString(1, email);
        ps.setString(2, password);

        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("usuario_id"));
                u.setNombre(rs.getString("nombre"));
                u.setEmail(rs.getString("email"));
                u.setPassword(rs.getString("password"));
                u.setTelefono(rs.getString("telefono"));

                // **Carga roles**
                List<Role> roles = findRolesByUserId(u.getId());
                if (roles.isEmpty()) {
                    // asigna rol USUARIO = 3 si no tiene ninguno
                    assignRole(u.getId(), 3);
                    roles.add(new Role(3, "USUARIO"));
                }
                u.setRoles(roles);

                return u;
            }
        }
    }
    return null;
}
    public User findById(int id) throws SQLException {
        String sql = "SELECT usuario_id, nombre, email, password, telefono, fecha_reg "
                   + "FROM usuario WHERE usuario_id = ?";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User u = new User();
                    u.setId(rs.getInt("usuario_id"));
                    u.setNombre(rs.getString("nombre"));
                    u.setEmail(rs.getString("email"));
                    u.setPassword(rs.getString("password"));
                    u.setTelefono(rs.getString("telefono"));
                    u.setFechaReg(rs.getTimestamp("fecha_reg"));
                    return u;
                } else {
                    return null;  // usuario no existe
                }
            }
        }
    }
    public void update(User u) throws SQLException {
        String sql = "UPDATE usuario "
                   + "SET nombre = ?, email = ?, password = ?, telefono = ? "
                   + "WHERE usuario_id = ?";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, u.getNombre());
            ps.setString(2, u.getEmail());
            ps.setString(3, u.getPassword());
            ps.setString(4, u.getTelefono());
            ps.setInt   (5, u.getId());

            int rows = ps.executeUpdate();
            if (rows == 0) {
                throw new SQLException("No se actualizó ningún registro de usuario.");
            }
        }
    }


    public User create(User user) throws SQLException {
        String sql = "INSERT INTO usuario (nombre, email, password, telefono) "
                   + "VALUES (?, ?, ?, ?)";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, user.getNombre());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getTelefono());

            int rows = ps.executeUpdate();
            if (rows == 0) {
                throw new SQLException("Crear usuario falló, no se insertó ninguna fila.");
            }

            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) {
                    user.setId(keys.getInt(1));
                } else {
                    throw new SQLException("Crear usuario falló, no se obtuvo ID generado.");
                }
            }
            return user;
        } catch (SQLIntegrityConstraintViolationException dup) {
            throw new SQLException(
                "El correo '" + user.getEmail() + "' ya está registrado.", dup);
        }
    }
    
    public List<Role> findRolesByUserId(int userId) throws SQLException {
    String sql = "SELECT r.rol_id, r.nombre "
               + "FROM usuario_rol ur "
               + " JOIN rol r ON ur.rol_id = r.rol_id "
               + "WHERE ur.usuario_id = ?";
    try (Connection conn = Conexion.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, userId);
        try (ResultSet rs = ps.executeQuery()) {
            List<Role> roles = new ArrayList<>();
            while (rs.next()) {
                roles.add(new Role(
                    rs.getInt("rol_id"),
                    rs.getString("nombre")
                ));
            }
            return roles;
        }
    }
}
    public void assignRole(int userId, int rolId) throws SQLException {
    String sql = "INSERT IGNORE INTO usuario_rol (usuario_id, rol_id) VALUES (?, ?)";
    try (Connection conn = Conexion.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, userId);
        ps.setInt(2, rolId);
        ps.executeUpdate();
    }
}
    
    

}
