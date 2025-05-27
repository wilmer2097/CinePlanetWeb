package com.cineplanet.cineplanetweb.controller;

import com.cineplanet.cineplanetweb.dao.PeliculaDAO;
import com.cineplanet.cineplanetweb.model.Pelicula;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "PeliculaServlet", urlPatterns = {"/perfil"})
public class PeliculaServlet extends HttpServlet {

    private PeliculaDAO dao;

    @Override
    public void init() throws ServletException {
        dao = new PeliculaDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            List<Pelicula> peliculas = dao.findAll();
            req.setAttribute("peliculas", peliculas);
            req.getRequestDispatcher("/vista/perfil.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException("Error al obtener películas", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        //Asegura que los datos se interpreten como UTF-8
        req.setCharacterEncoding("UTF-8");

        String accion = req.getParameter("accion");

        try {
            if ("agregar".equals(accion)) {
                Pelicula p = new Pelicula();
                p.setTitulo(req.getParameter("titulo"));
                p.setDuracionMin(Integer.parseInt(req.getParameter("duracion")));
                p.setSinopsis(req.getParameter("sinopsis"));
                p.setClasificacion(req.getParameter("clasificacion"));
                p.setEstreno(req.getParameter("estreno"));
                p.setImgUrl(req.getParameter("img_url"));
                dao.create(p);

            } else if ("editar".equals(accion)) {
                Pelicula p = new Pelicula();
                p.setId(Integer.parseInt(req.getParameter("id")));
                p.setTitulo(req.getParameter("titulo"));
                p.setDuracionMin(Integer.parseInt(req.getParameter("duracion")));
                p.setSinopsis(req.getParameter("sinopsis"));
                p.setClasificacion(req.getParameter("clasificacion"));
                p.setEstreno(req.getParameter("estreno"));
                p.setImgUrl(req.getParameter("img_url"));
                dao.update(p);

            } else if ("eliminar".equals(accion)) {
                int id = Integer.parseInt(req.getParameter("id"));
                dao.delete(id);
            }

        } catch (SQLException e) {
            throw new ServletException("Error al procesar acción", e);
        }

        // Vuelve a cargar la vista con la lista actualizada
        doGet(req, resp);
    }
}
