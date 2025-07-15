/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cineplanet.cineplanetweb.controller;

import com.cineplanet.cineplanetweb.model.Reserva;
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
@WebServlet("/reservas")
public class ReservaController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String accion = req.getParameter("accion");
        try {
            if ("editar".equals(accion)) {
                int id = Integer.parseInt(req.getParameter("id"));
                JSONObject body = new JSONObject()
                    .put("estado", req.getParameter("estado"))
                    .put("asiento", req.getParameter("asiento"))
                    .put("cantidad", Integer.parseInt(req.getParameter("cantidad")));
                SupabaseClient.update("reservas", id, body);

            } else if ("eliminar".equals(accion)) {
                int id = Integer.parseInt(req.getParameter("id"));
                SupabaseClient.delete("reservas", id);
            }
            // No creamos reservas desde admin—usamos MySQL + front—pero aquí podrías incluir “agregar” si lo necesitas.
            resp.sendRedirect(req.getContextPath() + "/perfil");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}