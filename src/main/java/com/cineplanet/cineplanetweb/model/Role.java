// src/main/java/com/cineplanet/cineplanetweb/model/Role.java
package com.cineplanet.cineplanetweb.model;
import java.io.Serializable;
public class Role implements Serializable{
    private static final long serialVersionUID = 1L;
    private int id;
    private String nombre;

    public Role() {}
    public Role(int id, String nombre) {
        this.id = id;
        this.nombre = nombre;
    }

    public int getId()            { return id; }
    public void setId(int id)     { this.id = id; }
    public String getNombre()     { return nombre; }
    public void setNombre(String n){ this.nombre = n; }
}
