// src/main/java/com/cineplanet/cineplanetweb/model/Sugerencia.java
package com.cineplanet.cineplanetweb.model;

import java.time.LocalDateTime;
import java.util.Objects;

public class Sugerencia {
    private int id;
    private String nombre;
    private String email;
    private String telefono;
    private String categoria;
    private String texto;
    private LocalDateTime fechaRegistro;

    public Sugerencia() { }

    /** Para crear nuevas sugerencias (el DAO asignará id y fechaRegistro) */
    public Sugerencia(String nombre,
                      String email,
                      String telefono,
                      String categoria,
                      String texto) {
        this(0, nombre, email, telefono, categoria, texto, null);
    }

    /** Para instancias leídas de la BD */
    public Sugerencia(int id,
                      String nombre,
                      String email,
                      String telefono,
                      String categoria,
                      String texto,
                      LocalDateTime fechaRegistro) {
        this.id = id;
        this.nombre = nombre;
        this.email = email;
        this.telefono = telefono;
        this.categoria = categoria;
        this.texto = texto;
        this.fechaRegistro = fechaRegistro;
    }

    // Getters & Setters

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

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public String getTexto() {
        return texto;
    }

    public void setTexto(String texto) {
        this.texto = texto;
    }

    public LocalDateTime getFechaRegistro() {
        return fechaRegistro;
    }

    public void setFechaRegistro(LocalDateTime fechaRegistro) {
        this.fechaRegistro = fechaRegistro;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Sugerencia)) return false;
        Sugerencia that = (Sugerencia) o;
        return id == that.id;
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    @Override
    public String toString() {
        return "Sugerencia{" +
               "id=" + id +
               ", nombre='" + nombre + '\'' +
               ", email='" + email + '\'' +
               ", telefono='" + telefono + '\'' +
               ", categoria='" + categoria + '\'' +
               ", texto='" + texto + '\'' +
               ", fecha_registro=" + fechaRegistro +
               '}';
    }
}
