package com.cineplanet.cineplanetweb.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class FuncionDTO {
    private int funcionId;
    private int salaId;
    private int peliculaId;
    private Timestamp fechaHora;
    private String idioma;
    private BigDecimal precioBase;
    
    // Campos adicionales para mostrar información relacionada
    private String nombreSala;
    private String nombrePelicula;
    private String nombreCine;
    
    // Constructor vacío
    public FuncionDTO() {}
    
    // Constructor con parámetros básicos
    public FuncionDTO(int salaId, int peliculaId, Timestamp fechaHora, String idioma, BigDecimal precioBase) {
        this.salaId = salaId;
        this.peliculaId = peliculaId;
        this.fechaHora = fechaHora;
        this.idioma = idioma;
        this.precioBase = precioBase;
    }
    
    // Getters y Setters
    public int getFuncionId() {
        return funcionId;
    }
    
    public void setFuncionId(int funcionId) {
        this.funcionId = funcionId;
    }
    
    public int getSalaId() {
        return salaId;
    }
    
    public void setSalaId(int salaId) {
        this.salaId = salaId;
    }
    
    public int getPeliculaId() {
        return peliculaId;
    }
    
    public void setPeliculaId(int peliculaId) {
        this.peliculaId = peliculaId;
    }
    
    public Timestamp getFechaHora() {
        return fechaHora;
    }
    
    public void setFechaHora(Timestamp fechaHora) {
        this.fechaHora = fechaHora;
    }
    
    public String getIdioma() {
        return idioma;
    }
    
    public void setIdioma(String idioma) {
        this.idioma = idioma;
    }
    
    public BigDecimal getPrecioBase() {
        return precioBase;
    }
    
    public void setPrecioBase(BigDecimal precioBase) {
        this.precioBase = precioBase;
    }
    
    public String getNombreSala() {
        return nombreSala;
    }
    
    public void setNombreSala(String nombreSala) {
        this.nombreSala = nombreSala;
    }
    
    public String getNombrePelicula() {
        return nombrePelicula;
    }
    
    public void setNombrePelicula(String nombrePelicula) {
        this.nombrePelicula = nombrePelicula;
    }
    
    public String getNombreCine() {
        return nombreCine;
    }
    
    public void setNombreCine(String nombreCine) {
        this.nombreCine = nombreCine;
    }
    
    @Override
    public String toString() {
        return "FuncionDTO{" +
                "funcionId=" + funcionId +
                ", salaId=" + salaId +
                ", peliculaId=" + peliculaId +
                ", fechaHora=" + fechaHora +
                ", idioma='" + idioma + '\'' +
                ", precioBase=" + precioBase +
                ", nombreSala='" + nombreSala + '\'' +
                ", nombrePelicula='" + nombrePelicula + '\'' +
                ", nombreCine='" + nombreCine + '\'' +
                '}';
    }
}