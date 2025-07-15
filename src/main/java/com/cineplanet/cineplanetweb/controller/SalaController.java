/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cineplanet.cineplanetweb.controller;


import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/**
 *
 * @author wilme
 */
@WebServlet("/salas")
public class SalaController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String accion = req.getParameter("accion");
        try {
            if ("agregar".equals(accion)) {
                JSONObject body = new JSONObject()
                    .put("cine_id", Integer.parseInt(req.getParameter("cine_id")))
                    .put("nombre", req.getParameter("nombre"))
                    .put("capacidad", Integer.parseInt(req.getParameter("capacidad")));
                SupabaseClient.insert("salas", body);

            } else if ("editar".equals(accion)) {
                int id = Integer.parseInt(req.getParameter("id"));
                JSONObject body = new JSONObject()
                    .put("cine_id", Integer.parseInt(req.getParameter("cine_id")))
                    .put("nombre", req.getParameter("nombre"))
                    .put("capacidad", Integer.parseInt(req.getParameter("capacidad")));
                SupabaseClient.update("salas", id, body);

            } else if ("eliminar".equals(accion)) {
                int id = Integer.parseInt(req.getParameter("id"));
                SupabaseClient.delete("salas", id);
            }

            resp.sendRedirect(req.getContextPath() + "/perfil");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
