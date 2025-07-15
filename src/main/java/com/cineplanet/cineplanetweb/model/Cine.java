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

public class Cine {
    private int id;
    private String nombre, direccion, ciudad, telefono;

    public static Cine fromJson(JSONObject o) {
        Cine c = new Cine();
        c.id        = o.getInt("id");
        c.nombre    = o.optString("nombre");
        c.direccion = o.optString("direccion");
        c.ciudad    = o.optString("ciudad");
        c.telefono  = o.optString("telefono");
        return c;
    }

    public JSONObject toJson() {
        return new JSONObject()
            .put("nombre",    nombre)
            .put("direccion", direccion)
            .put("ciudad",    ciudad)
            .put("telefono",  telefono);
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

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getCiudad() {
        return ciudad;
    }

    public void setCiudad(String ciudad) {
        this.ciudad = ciudad;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }


}
