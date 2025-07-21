package com.cineplanet.cineplanetweb.controller;

import com.cineplanet.cineplanetweb.model.Promocion;
import com.cineplanet.cineplanetweb.dao.FuncionDAO;
import com.cineplanet.cineplanetweb.dao.PeliculaDAO;
import com.cineplanet.cineplanetweb.dao.UserDAO;
import com.cineplanet.cineplanetweb.model.FuncionDTO;
import com.cineplanet.cineplanetweb.model.Pelicula;
import com.cineplanet.cineplanetweb.model.Reserva;
import com.cineplanet.cineplanetweb.model.User;
import com.cineplanet.cineplanetweb.model.Cine;
import com.cineplanet.cineplanetweb.model.Sala;
import org.json.JSONObject;
import com.cineplanet.cineplanetweb.model.Usuario;
import org.json.JSONArray;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@WebServlet(name = "ProfileServlet", urlPatterns = {"/profile", "/perfil"})
public class ProfileServlet extends HttpServlet {

    private UserDAO userDao;
    private PeliculaDAO peliculaDao;
    private FuncionDAO funcionDao;

    @Override
    public void init() throws ServletException {
        super.init();
        userDao = new UserDAO();
        peliculaDao = new PeliculaDAO();
        funcionDao = new FuncionDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // 1) Usuario en sesión
        HttpSession session = req.getSession(false);
        User sessionUser = session != null
                ? (User) session.getAttribute("user")
                : null;
        if (sessionUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // 2) Refrescar datos de usuario
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

        // 3) Películas
        try {
            List<Pelicula> peliculas = peliculaDao.findAll();
            req.setAttribute("peliculas", peliculas);
        } catch (SQLException ex) {
            throw new ServletException("Error cargando lista de películas", ex);
        }

        // 4) ¿Es ADMIN?
        boolean isAdmin = u.getRoles().stream()
                .anyMatch(r -> "ADMIN".equals(r.getNombre()));
        req.setAttribute("isAdmin", isAdmin);

        // 5) Si es admin, cargas también funciones y reservas
        if (isAdmin) {
            // — Funciones —
            try {
                List<FuncionDTO> funciones = funcionDao.listarTodas();
                req.setAttribute("funciones", funciones);
            } catch (SQLException ex) {
                throw new ServletException("Error cargando funciones", ex);
            }

            // — Reservas desde Supabase —
            try {
                JSONArray arr = SupabaseClient.getAll("reservas");
                List<Reserva> reservas = new ArrayList<>();
                for (int i = 0; i < arr.length(); i++) {
                    JSONObject o = arr.getJSONObject(i);
                    Reserva r = Reserva.fromJson(o);
                    // Cargar el objeto User completo para mostrar nombre
                    User usr = userDao.findById(r.getUsuarioId());
                    r.setUsuario(usr);
                    reservas.add(r);
                }
                req.setAttribute("reservas", reservas);
            } catch (Exception ex) {
                throw new ServletException("Error cargando reservas desde Supabase", ex);
            }
            try {
                JSONArray arrPromo = SupabaseClient.getAll("promociones");
                List<Promocion> promociones = new ArrayList<>();
                for (int i = 0; i < arrPromo.length(); i++) {
                    promociones.add(Promocion.fromJson(arrPromo.getJSONObject(i)));
                }
                req.setAttribute("promociones", promociones);
            } catch (Exception e) {
                throw new ServletException("Error cargando promociones desde Supabase", e);
            }
            // ——— Cargar Usuarios desde Supabase ———
            try {
                JSONArray arrUsr = SupabaseClient.getAll("usuarios");
                List<Usuario> usuarios = new ArrayList<>();
                for (int i = 0; i < arrUsr.length(); i++) {
                    usuarios.add(Usuario.fromJson(arrUsr.getJSONObject(i)));
                }
                req.setAttribute("usuarios", usuarios);
            } catch (Exception e) {
                throw new ServletException("Error cargando usuarios desde Supabase", e);
            }
            // ——— Cargar Cines y salas desde Supabase ———                                // <<<
            try {
                // 1) Cargar CINES desde Supabase
                JSONArray cinesArr = SupabaseClient.getAll("cines");
                List<Cine> cines = new ArrayList<>();
                for (int i = 0; i < cinesArr.length(); i++) {
                    cines.add(Cine.fromJson(cinesArr.getJSONObject(i)));
                }
                req.setAttribute("cines", cines);

                // 2) Cargar SALAS desde Supabase
                JSONArray salasArr = SupabaseClient.getAll("salas");
                List<Sala> salas = new ArrayList<>();
                for (int i = 0; i < salasArr.length(); i++) {
                    salas.add(Sala.fromJson(salasArr.getJSONObject(i)));
                }
                req.setAttribute("salas", salas);

            } catch (IOException | InterruptedException e) {
                throw new ServletException("Error cargando cines o salas desde Supabase", e);
            }
        } else {
            req.setAttribute("funciones", Collections.emptyList());
            req.setAttribute("reservas", Collections.emptyList());
            req.setAttribute("promociones", Collections.emptyList());
            req.setAttribute("usuarios", Collections.emptyList());
            req.setAttribute("cines", Collections.emptyList());
            req.setAttribute("salas", Collections.emptyList());
        }

        // 6) Forward a JSP
        req.getRequestDispatcher("/vista/perfil.jsp")
                .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String accion = req.getParameter("accion");
        try {
            // — Funciones CRUD —
            if ("crearFuncion".equals(accion)) {
                FuncionDTO f = buildFuncionFromRequest(req, false);
                if (funcionDao.crear(f)) {
                    req.setAttribute("success", "Función creada correctamente.");
                } else {
                    req.setAttribute("error", "No se pudo crear la función.");
                }
                doGet(req, resp);
                return;
            }
            if ("editarFuncion".equals(accion)) {
                FuncionDTO f = buildFuncionFromRequest(req, true);
                if (funcionDao.actualizar(f)) {
                    req.setAttribute("success", "Función actualizada correctamente.");
                } else {
                    req.setAttribute("error", "No se pudo actualizar la función.");
                }
                doGet(req, resp);
                return;
            }
            if ("eliminarFuncion".equals(accion)) {
                int funcionId = Integer.parseInt(req.getParameter("funcionId"));
                if (funcionDao.eliminar(funcionId)) {
                    req.setAttribute("success", "Función eliminada correctamente.");
                } else {
                    req.setAttribute("error", "No se pudo eliminar la función.");
                }
                doGet(req, resp);
                return;
            }

            // — Películas CRUD —
            if ("agregar".equals(accion) || "editar".equals(accion) || "eliminar".equals(accion)) {
                if ("agregar".equals(accion)) {
                    Pelicula pNueva = buildPeliculaFromRequest(req, false);
                    peliculaDao.create(pNueva);
                    req.setAttribute("success", "Película agregada correctamente.");
                } else if ("editar".equals(accion)) {
                    Pelicula pEdit = buildPeliculaFromRequest(req, true);
                    peliculaDao.update(pEdit);
                    req.setAttribute("success", "Película actualizada correctamente.");
                } else {
                    int delId = Integer.parseInt(req.getParameter("id"));
                    peliculaDao.delete(delId);
                    req.setAttribute("success", "Película eliminada correctamente.");
                }
                doGet(req, resp);
                return;
            }

            // — Perfil de Usuario —
            handlePerfilUsuario(req);
            doGet(req, resp);

        } catch (Exception ex) {
            req.setAttribute("error", "Error procesando la petición: " + ex.getMessage());
            doGet(req, resp);
        }
    }

    private Pelicula buildPeliculaFromRequest(HttpServletRequest req, boolean conId) {
        Pelicula p = new Pelicula();
        if (conId) {
            p.setId(Integer.parseInt(req.getParameter("id")));
        }
        p.setTitulo(req.getParameter("titulo").trim());
        p.setDuracionMin(Integer.parseInt(req.getParameter("duracion")));
        p.setSinopsis(req.getParameter("sinopsis").trim());
        p.setClasificacion(req.getParameter("clasificacion").trim());
        p.setEstreno(req.getParameter("estreno"));
        p.setImgUrl(req.getParameter("img_url").trim());
        return p;
    }

    private FuncionDTO buildFuncionFromRequest(HttpServletRequest req, boolean conId) {
        FuncionDTO f = new FuncionDTO();
        if (conId) {
            f.setFuncionId(Integer.parseInt(req.getParameter("funcionId")));
        }
        f.setSalaId(Integer.parseInt(req.getParameter("sala_id")));
        f.setPeliculaId(Integer.parseInt(req.getParameter("pelicula_id")));
        LocalDateTime ldt = LocalDateTime.parse(req.getParameter("fecha_hora"));
        f.setFechaHora(Timestamp.valueOf(ldt));
        f.setIdioma(req.getParameter("idioma"));
        f.setPrecioBase(new BigDecimal(req.getParameter("precio_base")));
        return f;
    }

    private void handlePerfilUsuario(HttpServletRequest req) throws SQLException {
        int userId = Integer.parseInt(req.getParameter("id"));
        String nombre = req.getParameter("nombre").trim();
        String email = req.getParameter("email").trim();
        String telefono = req.getParameter("telefono").trim();
        String currPwd = req.getParameter("current_password");
        String newPwd = req.getParameter("new_password");
        String confPwd = req.getParameter("confirm_password");

        User u = userDao.findById(userId);
        if (u == null) {
            req.setAttribute("error", "Usuario no encontrado.");
            return;
        }
        if (nombre.isEmpty() || email.isEmpty()) {
            req.setAttribute("error", "Nombre y email son obligatorios.");
            return;
        }
        if (!newPwd.isEmpty()) {
            if (!u.getPassword().equals(currPwd)) {
                req.setAttribute("error", "Contraseña actual incorrecta.");
                return;
            }
            if (!newPwd.equals(confPwd)) {
                req.setAttribute("error", "La nueva contraseña no coincide.");
                return;
            }
            u.setPassword(newPwd);
        }
        u.setNombre(nombre);
        u.setEmail(email);
        u.setTelefono(telefono);
        userDao.update(u);

        HttpSession session = req.getSession();
        session.setAttribute("user", u);
        req.setAttribute("success", "Perfil actualizado con éxito.");
    }
}
