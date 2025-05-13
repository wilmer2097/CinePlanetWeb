package dao;

import entidades.categoria;
import entidades.producto;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import servicios.ConectaDB;

public class productoDao {

    private Connection cnx;

    public productoDao() {
        cnx = new ConectaDB().getConnection();
    }

    public producto get(int idx) {
        producto p = null;
        PreparedStatement ps;
        ResultSet rs;

        String cadSQL = "select idProducto, idCategoria, nombreProducto, descripcion, precio, stock from producto where idProducto=?";

        try {
            ps = cnx.prepareStatement(cadSQL);
            ps.setInt(1, idx);
            rs = ps.executeQuery();

            if (rs.next()) {
                p = new producto();
                p.setIdProducto(rs.getInt("idProducto"));
                p.setCategoria(new categoria(rs.getInt("idCategoria"), ""));
                p.setNombreProducto(rs.getString("nombreProducto"));
                p.setDescripcion(rs.getString("descripcion"));
                p.setPrecio(rs.getDouble("precio"));
                p.setStock(rs.getInt("stock"));
            }
            rs.close();
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return p;
    }

    public List<producto> getList() {
        PreparedStatement ps;
        ResultSet rs;
        String cadSQL = "SELECT p.idProducto, c.idCategoria, p.nombreProducto, p.descripcion, p.precio, p.stock, c.nombreCategoria as NombreCategoria "
                + "FROM producto p inner join categorias c "
                + "on p.idCategoria = c.idCategoria; ";
        List<producto> lista = null;
        try {
            ps = cnx.prepareStatement(cadSQL);
            rs = ps.executeQuery();
            lista = new ArrayList<>();
            while (rs.next()) {
                producto p = new producto(
                        rs.getInt("idProducto"),
                        new categoria(rs.getInt("idCategoria"), rs.getString("NombreCategoria")),
                        rs.getString("nombreProducto"),
                        rs.getString("descripcion"),
                        rs.getDouble("precio"),
                        rs.getInt("stock")
                );
                lista.add(p);
            }
            rs.close();
        } catch (SQLException ex) {
        }
        return lista;
    }

    public void agregarProducto(producto p) {
        String sql = "INSERT INTO producto (idCategoria, nombreProducto, descripcion, precio, stock, imagenUrl) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = cnx.prepareStatement(sql)) {
            ps.setInt(1, p.getCategoria().getIdCategoria());
            ps.setString(2, p.getNombreProducto());
            ps.setString(3, p.getDescripcion());
            ps.setDouble(4, p.getPrecio());
            ps.setInt(5, p.getStock());
            ps.setString(6, p.getNombreProducto());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void actualizarProducto(producto p) {
        String sql = "UPDATE producto SET idCategoria=?, nombreProducto=?, descripcion=?, precio=?, stock=? WHERE idProducto=?";
        try (PreparedStatement ps = cnx.prepareStatement(sql)) {
            ps.setInt(1, p.getCategoria().getIdCategoria());
            ps.setString(2, p.getNombreProducto());
            ps.setString(3, p.getDescripcion());
            ps.setDouble(4, p.getPrecio());
            ps.setInt(5, p.getStock());
            ps.setInt(6, p.getIdProducto());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void eliminarProducto(int id) {
        String sql = "DELETE FROM producto WHERE idProducto = ?";
        try (PreparedStatement ps = cnx.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
