package com.cineplanet.cineplanetweb.model;

import java.time.LocalDate;
import java.util.Objects;

// Donde guarda esos valores guardados 
public class Reclamacion {
    private int id;
    private String nombre;
    private String dni;
    private String telefono;
    private String email;
    private String direccion;
    private String cine;
    private LocalDate fechaIncidente;
    private String tipo;
    private String detalle;
    private String pedido;
    private boolean aceptaTerminos;

    public Reclamacion() {
    }

    /** Constructor sin ID, para crear nuevos registros */
    public Reclamacion(String nombre,
                       String dni,
                       String telefono,
                       String email,
                       String direccion,
                       String cine,
                       LocalDate fechaIncidente,
                       String tipo,
                       String detalle,
                       String pedido,
                       boolean aceptaTerminos) {
        this(0, nombre, dni, telefono, email, direccion, cine,
             fechaIncidente, tipo, detalle, pedido, aceptaTerminos);
    }

    /** Constructor con ID, para instancias recuperadas de la BD */
    public Reclamacion(int id,
                       String nombre,
                       String dni,
                       String telefono,
                       String email,
                       String direccion,
                       String cine,
                       LocalDate fechaIncidente,
                       String tipo,
                       String detalle,
                       String pedido,
                       boolean aceptaTerminos) {
        this.id              = id;
        this.nombre          = nombre;
        this.dni             = dni;
        this.telefono        = telefono;
        this.email           = email;
        this.direccion       = direccion;
        this.cine            = cine;
        this.fechaIncidente  = fechaIncidente;
        this.tipo            = tipo;
        this.detalle         = detalle;
        this.pedido          = pedido;
        this.aceptaTerminos  = aceptaTerminos;
    }

    // --- Getters & Setters ---

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

    public String getDni() {
        return dni;
    }

    public void setDni(String dni) {
        this.dni = dni;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getCine() {
        return cine;
    }

    public void setCine(String cine) {
        this.cine = cine;
    }

    public LocalDate getFechaIncidente() {
        return fechaIncidente;
    }

    public void setFechaIncidente(LocalDate fechaIncidente) {
        this.fechaIncidente = fechaIncidente;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getDetalle() {
        return detalle;
    }

    public void setDetalle(String detalle) {
        this.detalle = detalle;
    }

    public String getPedido() {
        return pedido;
    }

    public void setPedido(String pedido) {
        this.pedido = pedido;
    }

    public boolean isAceptaTerminos() {
        return aceptaTerminos;
    }

    public void setAceptaTerminos(boolean aceptaTerminos) {
        this.aceptaTerminos = aceptaTerminos;
    }

    // --- equals / hashCode based on id ---

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Reclamacion)) return false;
        Reclamacion that = (Reclamacion) o;
        return id == that.id;
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    // --- toString ---

    @Override
    public String toString() {
        return "Reclamacion{" +
               "id=" + id +
               ", nombre='" + nombre + '\'' +
               ", dni='" + dni + '\'' +
               ", telefono='" + telefono + '\'' +
               ", email='" + email + '\'' +
               ", direccion='" + direccion + '\'' +
               ", cine='" + cine + '\'' +
               ", fechaIncidente=" + fechaIncidente +
               ", tipo='" + tipo + '\'' +
               ", detalle='" + detalle + '\'' +
               ", pedido='" + pedido + '\'' +
               ", aceptaTerminos=" + aceptaTerminos +
               '}';
    }
}
