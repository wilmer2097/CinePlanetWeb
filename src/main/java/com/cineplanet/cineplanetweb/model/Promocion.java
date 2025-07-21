// src/main/java/com/cineplanet/cineplanetweb/model/Promocion.java
package com.cineplanet.cineplanetweb.model;

import org.json.JSONObject;
import java.sql.Date;

public class Promocion {
    private int id;
    private String titulo, descripcion;
    private double descuentoPct;
    private Date fechaInicio, fechaFin;   // ← ahora Date
    private boolean activo;

    public static Promocion fromJson(JSONObject o) {
        Promocion p = new Promocion();
        p.id           = o.getInt("id");
        p.titulo       = o.optString("titulo");
        p.descripcion  = o.optString("descripcion");
        p.descuentoPct = o.optDouble("descuento_pct");
        // parseo de fechas ISO “YYYY-MM-DD”
        String fi = o.optString("fecha_inicio", null);
        if (fi != null && !fi.isEmpty()) {
            p.fechaInicio = Date.valueOf(fi);
        }
        String ff = o.optString("fecha_fin", null);
        if (ff != null && !ff.isEmpty()) {
            p.fechaFin = Date.valueOf(ff);
        }
        p.activo       = o.optBoolean("activo");
        return p;
    }

    public JSONObject toJson() {
        return new JSONObject()
            .put("titulo",        titulo)
            .put("descripcion",   descripcion)
            .put("descuento_pct", descuentoPct)
            .put("fecha_inicio",  fechaInicio.toString())
            .put("fecha_fin",     fechaFin.toString())
            .put("activo",        activo);
    }

    // — getters y setters —
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getTitulo() { return titulo; }
    public void setTitulo(String titulo) { this.titulo = titulo; }
    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }
    public double getDescuentoPct() { return descuentoPct; }
    public void setDescuentoPct(double descuentoPct) { this.descuentoPct = descuentoPct; }
    public Date getFechaInicio() { return fechaInicio; }
    public void setFechaInicio(Date fechaInicio) { this.fechaInicio = fechaInicio; }
    public Date getFechaFin() { return fechaFin; }
    public void setFechaFin(Date fechaFin) { this.fechaFin = fechaFin; }
    public boolean isActivo() { return activo; }
    public void setActivo(boolean activo) { this.activo = activo; }
}
