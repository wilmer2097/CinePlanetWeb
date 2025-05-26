package com.cineplanet.cineplanetweb.model;

import java.util.Date;

public class FuncionHoy {
    private int funcionId;
    private String titulo;
    private String sinopsis;
    private String imgUrl;
    private String complejo;
    private String sala;
    private Date fechaHora;            // <-- java.util.Date en lugar de LocalDateTime
    private String idioma;
    private double precioBase;

    public int getFuncionId() { return funcionId; }
    public void setFuncionId(int funcionId) { this.funcionId = funcionId; }

    public String getTitulo() { return titulo; }
    public void setTitulo(String titulo) { this.titulo = titulo; }

    public String getSinopsis() { return sinopsis; }
    public void setSinopsis(String sinopsis) { this.sinopsis = sinopsis; }

    public String getImgUrl() { return imgUrl; }
    public void setImgUrl(String imgUrl) { this.imgUrl = imgUrl; }

    public String getComplejo() { return complejo; }
    public void setComplejo(String complejo) { this.complejo = complejo; }

    public String getSala() { return sala; }
    public void setSala(String sala) { this.sala = sala; }

    public Date getFechaHora() { return fechaHora; }        // <-- Date getter
    public void setFechaHora(Date fechaHora) {              // <-- Date setter
        this.fechaHora = fechaHora;
    }

    public String getIdioma() { return idioma; }
    public void setIdioma(String idioma) { this.idioma = idioma; }

    public double getPrecioBase() { return precioBase; }
    public void setPrecioBase(double precioBase) { this.precioBase = precioBase; }
}
