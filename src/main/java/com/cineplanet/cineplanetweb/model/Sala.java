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
public class Sala {
    private int id, cineId, capacidad;
    private String nombre;

    public static Sala fromJson(JSONObject o) {
        Sala s = new Sala();
        s.id       = o.getInt("id");
        s.cineId   = o.getInt("cine_id");
        s.nombre   = o.optString("nombre");
        s.capacidad= o.getInt("capacidad");
        return s;
    }

    public JSONObject toJson() {
        return new JSONObject()
            .put("cine_id",  cineId)
            .put("nombre",   nombre)
            .put("capacidad",capacidad);
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCineId() {
        return cineId;
    }

    public void setCineId(int cineId) {
        this.cineId = cineId;
    }

    public int getCapacidad() {
        return capacidad;
    }

    public void setCapacidad(int capacidad) {
        this.capacidad = capacidad;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }


}
