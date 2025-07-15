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
public class Promocion {
    private int id;
    private String titulo, descripcion;
    private double descuentoPct;
    private String fechaInicio, fechaFin;
    private boolean activo;

    public static Promocion fromJson(JSONObject o) {
        Promocion p = new Promocion();
        p.id           = o.getInt("id");
        p.titulo       = o.optString("titulo");
        p.descripcion  = o.optString("descripcion");
        p.descuentoPct = o.optDouble("descuento_pct");
        p.fechaInicio  = o.optString("fecha_inicio");
        p.fechaFin     = o.optString("fecha_fin");
        p.activo       = o.optBoolean("activo");
        return p;
    }

    public JSONObject toJson() {
        return new JSONObject()
            .put("titulo",        titulo)
            .put("descripcion",   descripcion)
            .put("descuento_pct", descuentoPct)
            .put("fecha_inicio",  fechaInicio)
            .put("fecha_fin",     fechaFin)
            .put("activo",        activo);
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public double getDescuentoPct() {
        return descuentoPct;
    }

    public void setDescuentoPct(double descuentoPct) {
        this.descuentoPct = descuentoPct;
    }

    public String getFechaInicio() {
        return fechaInicio;
    }

    public void setFechaInicio(String fechaInicio) {
        this.fechaInicio = fechaInicio;
    }

    public String getFechaFin() {
        return fechaFin;
    }

    public void setFechaFin(String fechaFin) {
        this.fechaFin = fechaFin;
    }

    public boolean isActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
    }

    
}