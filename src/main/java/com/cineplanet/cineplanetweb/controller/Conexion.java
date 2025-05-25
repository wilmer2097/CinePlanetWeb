// src/main/java/com/cineplanet/cineplanetweb/controller/Conexion.java
package com.cineplanet.cineplanetweb.controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {
    private static final String USERNAME = "root";
    private static final String PASSWORD = "root";
    private static final String DATABASE = "cineplanet_web";
    private static final String URL      =
        "jdbc:mysql://localhost:3306/" + DATABASE + "?useSSL=false&serverTimezone=UTC";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Driver JDBC no encontrado", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }
}
