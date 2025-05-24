// src/main/java/com/cineplanet/cineplanetweb/controller/LoginServlet.java
package com.cineplanet.cineplanetweb.controller;

import com.cineplanet.cineplanetweb.dao.UserDAO;
import com.cineplanet.cineplanetweb.model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Optional;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String ATTR_USER     = "user";
    private static final String JSP_LOGIN     = "/vista/login.jsp";
    private static final String URL_CARTELERA = "/cartelera";

    private UserDAO userDao;

    @Override
    public void init() throws ServletException {
        super.init();
        userDao = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        if (req.getSession().getAttribute(ATTR_USER) != null) {
            resp.sendRedirect(req.getContextPath() + URL_CARTELERA);
            return;
        }
        req.getRequestDispatcher(JSP_LOGIN)
           .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        log("LoginServlet.doPost() invoked");

        String email = Optional.ofNullable(req.getParameter("email"))
                               .orElse("").trim();
        String password = Optional.ofNullable(req.getParameter("password"))
                                  .orElse("");

        if (email.isEmpty() || password.isEmpty()) {
            req.setAttribute("error", "Usuario y contraseña son obligatorios");
            req.getRequestDispatcher(JSP_LOGIN)
               .forward(req, resp);
            return;
        }

        try {
            User usuario = userDao.validate(email, password);
            if (usuario != null) {
                log("✔ Login exitoso para usuario=" + email);
                req.getSession().setAttribute(ATTR_USER, usuario);
                resp.sendRedirect(req.getContextPath() + URL_CARTELERA);
            } else {
                log("✘ Credenciales inválidas para usuario=" + email);
                req.setAttribute("error", "Usuario o contraseña incorrectos");
                req.getRequestDispatcher(JSP_LOGIN)
                   .forward(req, resp);
            }
        } catch (Exception ex) {
            log("Error validando usuario", ex);
            throw new ServletException("Error al validar usuario", ex);
        }
    }
}
