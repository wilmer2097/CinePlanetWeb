
package com.cineplanet.cineplanetweb.model;


public class Sugerencia {
    private String nombre, email, telefono, categoria, sugerencia;

    public Sugerencia() {
    }
    
    
    
    public Sugerencia(String nombre, String email, String telefono, String categoria, String sugerencia) {
        this.nombre = nombre;
        this.email = email;
        this.telefono = telefono;
        this.categoria = categoria;
        this.sugerencia = sugerencia;
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

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public String getSugerencia() {
        return sugerencia;
    }

    public void setSugerencia(String sugerencia) {
        this.sugerencia = sugerencia;
    }

    
}

