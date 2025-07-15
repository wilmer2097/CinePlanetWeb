// src/main/java/com/cineplanet/cineplanetweb/controller/Conexion.java
package com.cineplanet.cineplanetweb.controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {

    // Credenciales y configuración de MySQL
    private static final String USERNAME = "root";
    private static final String PASSWORD = "root";
    private static final String DATABASE = "cineplanet_web";
    private static final String HOST     = "localhost";
    private static final int    PORT     = 3306;

    // URL completa del JDBC (UTF-8 activado)
    private static final String URL =
        "jdbc:mysql://" + HOST + ":" + PORT + "/" + DATABASE +
        "?useUnicode=true&characterEncoding=UTF-8&useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";

    // Carga del driver al inicio de la clase
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("Driver MySQL cargado correctamente.");
        } catch (ClassNotFoundException e) {
            System.err.println("Error: Driver JDBC no encontrado.");
            throw new RuntimeException(e);
        }
    }

    // Método público para obtener la conexión
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }
}










