/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cineplanet.cineplanetweb.controller;
import com.cineplanet.cineplanetweb.model.Usuario;
import org.json.JSONArray;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
/**
 *
 * @author wilme
 */
@WebServlet("/usuarios")
public class UsuarioController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String accion = req.getParameter("accion");
        try {
            if ("agregar".equals(accion)) {
                JSONObject body = new JSONObject()
                    .put("nombre", req.getParameter("nombre"))
                    .put("email", req.getParameter("email"))
                    .put("telefono", req.getParameter("telefono"))
                    .put("password_hash", req.getParameter("password"))   // idealmente hasheada
                    .put("rol", req.getParameter("rol"))
                    .put("activo", req.getParameter("activo") != null);
                SupabaseClient.insert("usuarios", body);

            } else if ("editar".equals(accion)) {
                int id = Integer.parseInt(req.getParameter("id"));
                JSONObject body = new JSONObject()
                    .put("nombre", req.getParameter("nombre"))
                    .put("email", req.getParameter("email"))
                    .put("telefono", req.getParameter("telefono"))
                    .put("rol", req.getParameter("rol"))
                    .put("activo", req.getParameter("activo") != null);
                SupabaseClient.update("usuarios", id, body);

            } else if ("eliminar".equals(accion)) {
                int id = Integer.parseInt(req.getParameter("id"));
                SupabaseClient.delete("usuarios", id);
            }

            resp.sendRedirect(req.getContextPath() + "/perfil");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
