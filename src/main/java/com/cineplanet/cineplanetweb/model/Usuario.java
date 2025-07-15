/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cineplanet.cineplanetweb.model;
import org.json.JSONObject;
/**
 *
 * @author wilme
 */
public class Usuario {
    private int id;
    private String nombre, email, telefono, rol;
    private boolean activo;

    public static Usuario fromJson(JSONObject o) {
        Usuario u = new Usuario();
        u.id       = o.getInt("id");
        u.nombre   = o.optString("nombre");
        u.email    = o.optString("email");
        u.telefono = o.optString("telefono");
        u.rol      = o.optString("rol");
        u.activo   = o.optBoolean("activo");
        return u;
    }

    public JSONObject toJson() {
        return new JSONObject()
            .put("nombre",   nombre)
            .put("email",    email)
            .put("telefono", telefono)
            .put("rol",      rol)
            .put("activo",   activo);
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }

    public boolean isActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
    }

    
}