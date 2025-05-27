// src/main/java/com/cineplanet/cineplanetweb/model/User.java
package com.cineplanet.cineplanetweb.model;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Objects;
import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "usuario")
public class User implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "usuario_id")
    private Integer id;

    @Column(nullable = false, length = 100)
    private String nombre;

    @Column(nullable = false, unique = true, length = 120)
    private String email;

    @Column(nullable = false, length = 60)
    private String password;

    @Column(nullable = false, length = 9)
    private String telefono;

    public User() { }

    public User(Integer id, String nombre, String email, String telefono, String password) {
        this.id       = id;
        this.nombre   = nombre;
        this.email    = email;
        this.telefono = telefono;
        this.password = password;
    }

    public Integer getId()              { return id; }
    public void setId(Integer id)       { this.id = id; }
    public String getNombre()           { return nombre; }
    public void setNombre(String nombre){ this.nombre = nombre; }
    public String getEmail()            { return email; }
    public void setEmail(String email)  { this.email = email; }
    public String getPassword()         { return password; }
    public void setPassword(String p)   { this.password = p; }
    public String getTelefono()         { return telefono; }
    public void setTelefono(String t)   { this.telefono = t; }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof User)) return false;
        User other = (User) o;
        return Objects.equals(id, other.id)
            && Objects.equals(email, other.email);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, email);
    }

    @Override
    public String toString() {
        return "User{" +
               "id=" + id +
               ", email='" + email + '\'' +
               '}';
    }

    private java.sql.Timestamp fechaReg;
    public java.sql.Timestamp getFechaReg() { return fechaReg; }
    public void setFechaReg(java.sql.Timestamp ts) { this.fechaReg = ts; }
    
    private List<Role> roles = new ArrayList<>();

    public List<Role> getRoles() { return roles; }
    public void setRoles(List<Role> roles) { this.roles = roles; }
    public void addRole(Role r) { this.roles.add(r); }
}
