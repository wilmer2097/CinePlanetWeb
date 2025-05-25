
package com.cineplanet.cineplanetweb.model;

public class Reclamacion {
    private String nombre, dni, telefono, email, direccion, cine, fechaIncidente, tipo, detalle, pedido;
    private boolean aceptaTerminos;

    public Reclamacion() {
    }
    
    

    public Reclamacion(String nombre, String dni, String telefono, String email, String direccion,
                       String cine, String fechaIncidente, String tipo, String detalle, String pedido,
                       boolean aceptaTerminos) {
        this.nombre = nombre;
        this.dni = dni;
        this.telefono = telefono;
        this.email = email;
        this.direccion = direccion;
        this.cine = cine;
        this.fechaIncidente = fechaIncidente;
        this.tipo = tipo;
        this.detalle = detalle;
        this.pedido = pedido;
        this.aceptaTerminos = aceptaTerminos;
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

    public String getFechaIncidente() {
        return fechaIncidente;
    }

    public void setFechaIncidente(String fechaIncidente) {
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
    
    
}

