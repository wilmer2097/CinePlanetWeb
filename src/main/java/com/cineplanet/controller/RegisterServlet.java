package com.cineplanet.controller;

import com.cineplanet.dao.UserDAO;
import com.cineplanet.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private UserDAO userDao;

    @Override
    public void init() throws ServletException {
        super.init();
        userDao = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Mostrar formulario vacío
        req.getRequestDispatcher("/WEB-INF/jsp/register.jsp")
           .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String nombre        = req.getParameter("nombre");
        String email         = req.getParameter("email");
        String telefono      = req.getParameter("telefono");
        String pass          = req.getParameter("password");
        String confirmPass   = req.getParameter("confirmPassword");

        // Validar campos básicos
        if (nombre.isEmpty() || email.isEmpty() || pass.isEmpty() || !pass.equals(confirmPass)) {
            req.setAttribute("error",
                "Revisa los campos: contraseñas deben coincidir y todos los campos son obligatorios.");
            forwardForm(req, resp);
            return;
        }

        // Construir entidad usuario
        User u = new User();
        u.setNombre(nombre);
        u.setEmail(email);
        u.setPassword(pass);   
        u.setTelefono(telefono);

        try {
            userDao.create(u);
            // Registro exitoso → redirigir al login
            resp.sendRedirect(req.getContextPath() + "/login");
        } catch (SQLException ex) {
            String mensaje;
            // Detección de duplicado en email
            if (ex instanceof SQLIntegrityConstraintViolationException
                || ex.getMessage().contains("Duplicate entry")) {
                mensaje = "El correo '" + email + "' ya está registrado.";
            } else {
                mensaje = "Error al crear usuario: " + ex.getMessage();
            }
            req.setAttribute("error", mensaje);
            forwardForm(req, resp);
        }
    }

    private void forwardForm(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Conservar valores ingresados
        req.setAttribute("prevNombre",   req.getParameter("nombre"));
        req.setAttribute("prevEmail",    req.getParameter("email"));
        req.setAttribute("prevTelefono", req.getParameter("telefono"));
        req.getRequestDispatcher("/WEB-INF/jsp/register.jsp")
           .forward(req, resp);
    }
}
