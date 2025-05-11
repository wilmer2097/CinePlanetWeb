/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.domain;

import lombok.Data;

/**
 *
 * @author Guillermo
 */
@Data
public class usuarios {
    
    private int idUsuario;
    private String nombre;
    private String apellido;
    private String direccion;
    private String telefono;
    private String dni;
    private String correo;
    private String clave;
    private String rol;
    private String fechaRegistro;
}
