package dao;

import entidades.usuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import servicios.ConectaDB;

/**
 *
 * @author Guillermo
 */
public class usuarioDao {

    private Connection cnx;

    public usuarioDao() {
        cnx = new ConectaDB().getConnection();
    }

    public usuario get(int idx) {
        usuario u = null;
        PreparedStatement ps;
        ResultSet rs;

        String cadSQL = "select idUsuario, nombre, apellido, correo, telefono, dni, direccion, rol from usuario where idUsuario=?";

        try {
            ps = cnx.prepareStatement(cadSQL);
            ps.setInt(1, idx);
            rs = ps.executeQuery();

            if (rs.next()) {
                u = new usuario();
                u.setIdUsuario(rs.getInt("idUsuario"));
                u.setNombre(rs.getString("nombre"));
                u.setApellido(rs.getString("apellido"));
                u.setCorreo(rs.getString("correo"));
                u.setTelefono(rs.getString("telefono"));
                u.setDni(rs.getString("dni"));
                u.setDireccion(rs.getString("direccion"));
                u.setRol(rs.getString("rol"));
            }
            rs.close();
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return u;
    }

    public List<usuario> getList() {
        PreparedStatement ps;
        ResultSet rs;
        String cadSQL = "select idUsuario, nombre, apellido, direccion, telefono, dni, correo, rol from usuario";
        List<usuario> lista = null;
        try {
            ps = cnx.prepareStatement(cadSQL);
            rs = ps.executeQuery();
            lista = new ArrayList<>();
            while (rs.next()) {
                usuario u= new usuario(
                rs.getInt("idUsuario"),        
                rs.getString("nombre"),
                rs.getString("apellido"),
                rs.getString("direccion"),
                rs.getString("telefono"),
                rs.getString("dni"),
                rs.getString("correo"),
                rs.getString("rol")
                );
                lista.add(u);
            }
            rs.close();
        } catch (SQLException ex) {
        }
        return lista;
    }

}
