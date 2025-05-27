/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cineplanet.cineplanetweb.model;

/**
 *
 * @author wilme
 */

public class Pelicula {
    private int id;
    private String titulo;
    private int duracionMin;
    private String sinopsis;
    private String clasificacion;
    private String estreno; // formato yyyy-MM-dd
    private String imgUrl;

    // Constructor vacío (requerido por frameworks y JSP)
    public Pelicula() {
    }

    // Constructor con todos los campos (útil para crear instancias fácilmente)
    public Pelicula(int id, String titulo, int duracionMin, String sinopsis,
                    String clasificacion, String estreno, String imgUrl) {
        this.id = id;
        this.titulo = titulo;
        this.duracionMin = duracionMin;
        this.sinopsis = sinopsis;
        this.clasificacion = clasificacion;
        this.estreno = estreno;
        this.imgUrl = imgUrl;
    }

    // Getters y Setters
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

    public int getDuracionMin() {
        return duracionMin;
    }

    public void setDuracionMin(int duracionMin) {
        this.duracionMin = duracionMin;
    }

    public String getSinopsis() {
        return sinopsis;
    }

    public void setSinopsis(String sinopsis) {
        this.sinopsis = sinopsis;
    }

    public String getClasificacion() {
        return clasificacion;
    }

    public void setClasificacion(String clasificacion) {
        this.clasificacion = clasificacion;
    }

    public String getEstreno() {
        return estreno;
    }

    public void setEstreno(String estreno) {
        this.estreno = estreno;
    }

    public String getImgUrl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl;
    }
}
