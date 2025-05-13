package dao;

import entidades.categoria;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import servicios.ConectaDB;

public class categoriaDao {

    private Connection cnx;

    public categoriaDao() {
        cnx = ConectaDB.getConnection();
    }

    public List<categoria> getList() {
        PreparedStatement ps;
        ResultSet rs;
        String cadSQL = "select idCategoria, nombreCategoria from categorias";
        List<categoria> lista = null;
        try {
            ps = cnx.prepareStatement(cadSQL);
            rs = ps.executeQuery();
            lista = new ArrayList<>();
            while (rs.next()) {
                categoria c = new categoria(
                        rs.getInt("idCategoria"),
                        rs.getString("nombreCategoria"));
                lista.add(c);
            }
            rs.close();
        } catch (SQLException ex) {
        }
        return lista;
    }
}
