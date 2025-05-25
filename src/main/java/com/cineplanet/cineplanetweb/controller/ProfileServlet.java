package com.cineplanet.cineplanetweb.controller;

import com.cineplanet.cineplanetweb.dao.UserDAO;
import com.cineplanet.cineplanetweb.model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Objects;

@WebServlet(name = "ProfileServlet", urlPatterns = {"/profile"})
public class ProfileServlet extends HttpServlet {
    private UserDAO userDao;

    @Override
    public void init() throws ServletException {
        super.init();
        userDao = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // 1) Recuperar usuario de sesión
        HttpSession session = req.getSession(false);
        User sessionUser = session != null
                ? (User) session.getAttribute("user")
                : null;

        if (sessionUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // 2) Leer datos actualizados desde BD
        try {
            User u = userDao.findById(sessionUser.getId());
            if (u == null) {
                // No se encontró en BD (caso improbable si había en sesión)
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Usuario no encontrado");
                return;
            }
            req.setAttribute("usuario", u);
            req.getRequestDispatcher("/vista/perfil.jsp")
               .forward(req, resp);

        } catch (SQLException ex) {
            throw new ServletException("Error cargando datos de perfil", ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Parámetros
        int id                   = Integer.parseInt(req.getParameter("id"));
        String nombre            = req.getParameter("nombre").trim();
        String email             = req.getParameter("email").trim();
        String telefono          = req.getParameter("telefono").trim();
        String currentPassword   = req.getParameter("current_password");
        String newPassword       = req.getParameter("new_password");
        String confirmPassword   = req.getParameter("confirm_password");

        try {
            User u = userDao.findById(id);
            // Validaciones básicas
            if (nombre.isEmpty() || email.isEmpty()) {
                req.setAttribute("error", "Nombre y email no pueden quedar vacíos.");
            } else if (!newPassword.isEmpty()) {
                // Si quiere cambiar contraseña
                if (!Objects.equals(u.getPassword(), currentPassword)) {
                    req.setAttribute("error", "La contraseña actual es incorrecta.");
                } else if (!newPassword.equals(confirmPassword)) {
                    req.setAttribute("error", "La nueva contraseña no coincide.");
                } else {
                    u.setPassword(newPassword);
                }
            }

            // Si no hay error, actualiza
            if (req.getAttribute("error") == null) {
                u.setNombre(nombre);
                u.setEmail(email);
                u.setTelefono(telefono);
                userDao.update(u);
                // Actualiza objeto en sesión
                req.getSession().setAttribute("user", u);
                req.setAttribute("success", "Perfil actualizado con éxito.");
            }

        } catch (SQLException ex) {
            req.setAttribute("error", "Error al guardar perfil: " + ex.getMessage());
        }

        // Re-cargar datos (incluso tras PUT)
        doGet(req, resp);
    }
}
