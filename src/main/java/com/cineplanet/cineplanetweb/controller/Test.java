package com.cineplanet.cineplanetweb.controller;

import java.sql.Connection;
import java.sql.SQLException;

public class Test {
    public static void main(String[] args) {
        System.out.println("Probando conexión a la base de datos...");
        // try-with-resources cierra automáticamente la conexión
        try (Connection conn = Conexion.getConnection()) {
            if (conn != null && !conn.isClosed()) {
                System.out.println("Conexión establecida con éxito: " + conn);
            } else {
                System.out.println("No se pudo establecer la conexión.");
            }
        } catch (SQLException ex) {
            System.err.println("Error al conectar con la base de datos:");
            ex.printStackTrace();
        }
    }
}
