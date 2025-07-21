/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cineplanet.cineplanetweb.model;

import org.json.JSONObject;
import java.sql.Timestamp;
import java.time.OffsetDateTime;
import java.time.format.DateTimeFormatter;

/**
 *
 * @author wilme
 */
public class Reserva {
    private int id, usuarioId, funcionId, cantidad;
    private String asiento, estado;
    private double total;
    private Timestamp fechaReserva;  // cambiado de String a Timestamp
    private User usuario;            // nuevo campo

    public static Reserva fromJson(JSONObject o) {
        Reserva r = new Reserva();
        r.id           = o.getInt("id");
        r.usuarioId    = o.getInt("usuario_id");
        r.funcionId    = o.getInt("funcion_id");
        r.asiento      = o.optString("asiento", "");
        r.cantidad     = o.getInt("cantidad");
        r.total        = o.getDouble("total");
        r.estado       = o.optString("estado");
        // pasamos fecha_reserva (ISO) a Timestamp
        String fs = o.optString("fecha_reserva", null);
        if (fs != null && !fs.isEmpty()) {
            // parsea algo como "2025-07-20T15:30:00.000Z" o con offset "+00:00"
            OffsetDateTime odt = OffsetDateTime.parse(fs, DateTimeFormatter.ISO_OFFSET_DATE_TIME);
            r.fechaReserva = Timestamp.from(odt.toInstant());
        }
        return r;
    }

    public JSONObject toJson() {
        return new JSONObject()
            .put("usuario_id",   usuarioId)
            .put("funcion_id",   funcionId)
            .put("asiento",      asiento)
            .put("cantidad",     cantidad)
            .put("total",        total)
            .put("estado",       estado);
            // fecha_reserva la pone Supabase por default si no la envías
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUsuarioId() {
        return usuarioId;
    }

    public void setUsuarioId(int usuarioId) {
        this.usuarioId = usuarioId;
    }

    public int getFuncionId() {
        return funcionId;
    }

    public void setFuncionId(int funcionId) {
        this.funcionId = funcionId;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public String getAsiento() {
        return asiento;
    }

    public void setAsiento(String asiento) {
        this.asiento = asiento;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public Timestamp getFechaReserva() {
        return fechaReserva;
    }

    public void setFechaReserva(Timestamp fechaReserva) {
        this.fechaReserva = fechaReserva;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public User getUsuario() {
        return usuario;
    }

    public void setUsuario(User usuario) {
        this.usuario = usuario;
    }
}
