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
public class Reserva {
    private int id, usuarioId, funcionId, cantidad;
    private String asiento, estado, fechaReserva;
    private double total;

    public static Reserva fromJson(JSONObject o) {
        Reserva r = new Reserva();
        r.id           = o.getInt("id");
        r.usuarioId    = o.getInt("usuario_id");
        r.funcionId    = o.getInt("funcion_id");
        r.asiento      = o.optString("asiento", "");
        r.cantidad     = o.getInt("cantidad");
        r.total        = o.getDouble("total");
        r.estado       = o.optString("estado");
        r.fechaReserva = o.optString("fecha_reserva");
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

    public String getFechaReserva() {
        return fechaReserva;
    }

    public void setFechaReserva(String fechaReserva) {
        this.fechaReserva = fechaReserva;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    
}
