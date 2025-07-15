package com.cineplanet.cineplanetweb.controller;

import com.cineplanet.cineplanetweb.dao.UserDAO;
import com.cineplanet.cineplanetweb.dao.PeliculaDAO;
import com.cineplanet.cineplanetweb.model.User;
import com.cineplanet.cineplanetweb.model.Pelicula;
import com.cineplanet.cineplanetweb.model.Cine;
import com.cineplanet.cineplanetweb.model.Sala;
import com.cineplanet.cineplanetweb.model.Promocion;
import com.cineplanet.cineplanetweb.model.Usuario;   // tu modelo de usuario Supabase
import com.cineplanet.cineplanetweb.model.Reserva;
import org.json.JSONArray;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@WebServlet(name = "ProfileServlet", urlPatterns = {"/profile", "/perfil"})
public class ProfileServlet extends HttpServlet {
    private UserDAO userDao;
    private PeliculaDAO peliculaDao;

    @Override
    public void init() throws ServletException {
        super.init();
        userDao     = new UserDAO();
        peliculaDao = new PeliculaDAO(); // Debe implementar List<Pelicula> findAll()
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // — 1) Usuario en sesión —
        HttpSession session = req.getSession(false);
        User sessionUser = session != null
                ? (User) session.getAttribute("user")
                : null;
        if (sessionUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // — 2) Refrescar datos de usuario desde MySQL —
        User u;
        try {
            u = userDao.findById(sessionUser.getId());
            if (u == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Usuario no encontrado");
                return;
            }
        } catch (SQLException ex) {
            throw new ServletException("Error cargando datos de perfil", ex);
        }
        req.setAttribute("usuario", u);

        // — 3) Cargar listado de películas (MySQL) —
        try {
            List<Pelicula> peliculas = peliculaDao.findAll();
            req.setAttribute("peliculas", peliculas);
        } catch (SQLException ex) {
            throw new ServletException("Error cargando lista de películas", ex);
        }

        // — 4) ¿Es ADMIN? —
        boolean isAdmin = u.getRoles().stream()
                           .anyMatch(r -> "ADMIN".equals(r.getNombre()));
        req.setAttribute("isAdmin", isAdmin);

        // — 5) Si es ADMIN, cargar desde Supabase —
        if (isAdmin) {
            try {
                JSONArray arr;
                List<Cine>         cines       = new ArrayList<>();
                List<Sala>         salas       = new ArrayList<>();
                List<Promocion>    promos      = new ArrayList<>();
                List<Usuario>      usuarios    = new ArrayList<>();
                List<Reserva>      reservas    = new ArrayList<>();

                // --- CINES ---
                arr = SupabaseClient.getAll("cines");
                System.out.println("⭑ Supabase GET cines → " + arr.toString());
                for (int i = 0; i < arr.length(); i++) {
                    cines.add(Cine.fromJson(arr.getJSONObject(i)));
                }
                req.setAttribute("cines", cines);

                // --- SALAS ---
                arr = SupabaseClient.getAll("salas");
                System.out.println("⭑ Supabase GET salas → " + arr.toString());
                for (int i = 0; i < arr.length(); i++) {
                    salas.add(Sala.fromJson(arr.getJSONObject(i)));
                }
                req.setAttribute("salas", salas);

                // --- PROMOCIONES ---
                arr = SupabaseClient.getAll("promociones");
                System.out.println("⭑ Supabase GET promociones → " + arr.toString());
                for (int i = 0; i < arr.length(); i++) {
                    promos.add(Promocion.fromJson(arr.getJSONObject(i)));
                }
                req.setAttribute("promociones", promos);

                // --- USUARIOS (Supabase) ---
                arr = SupabaseClient.getAll("usuarios");
                System.out.println("⭑ Supabase GET usuarios → " + arr.toString());
                for (int i = 0; i < arr.length(); i++) {
                    usuarios.add(Usuario.fromJson(arr.getJSONObject(i)));
                }
                req.setAttribute("usuarios", usuarios);

                // --- RESERVAS (Supabase) ---
                arr = SupabaseClient.getAll("reservas");
                System.out.println("⭑ Supabase GET reservas → " + arr.toString());
                for (int i = 0; i < arr.length(); i++) {
                    reservas.add(Reserva.fromJson(arr.getJSONObject(i)));
                }
                req.setAttribute("reservas", reservas);

            } catch (Exception e) {
                throw new ServletException("Error cargando datos de administración", e);
            }
        }

        // — 6) Forward a la vista —
        req.getRequestDispatcher("/vista/perfil.jsp")
           .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Recuperar sesión
        HttpSession session = req.getSession();

        // Parámetros del form de perfil
        int    id              = Integer.parseInt(req.getParameter("id"));
        String nombre          = req.getParameter("nombre").trim();
        String email           = req.getParameter("email").trim();
        String telefono        = req.getParameter("telefono").trim();
        String currentPassword = req.getParameter("current_password");
        String newPassword     = req.getParameter("new_password");
        String confirmPassword = req.getParameter("confirm_password");

        try {
            User u = userDao.findById(id);

            if (nombre.isEmpty() || email.isEmpty()) {
                req.setAttribute("error", "Nombre y email no pueden quedar vacíos.");
            } else if (!newPassword.isEmpty()) {
                // Cambio de contraseña
                if (!Objects.equals(u.getPassword(), currentPassword)) {
                    req.setAttribute("error", "La contraseña actual es incorrecta.");
                } else if (!newPassword.equals(confirmPassword)) {
                    req.setAttribute("error", "La nueva contraseña no coincide.");
                } else {
                    u.setPassword(newPassword);
                }
            }

            // Si pasó validaciones, guardar
            if (req.getAttribute("error") == null) {
                u.setNombre(nombre);
                u.setEmail(email);
                u.setTelefono(telefono);
                userDao.update(u);
                session.setAttribute("user", u);
                req.setAttribute("success", "Perfil actualizado con éxito.");
            }
        } catch (SQLException ex) {
            req.setAttribute("error", "Error al guardar perfil: " + ex.getMessage());
        }

        // Recargar todo (incluyendo tablas admin)
        doGet(req, resp);
    }
}
