/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cineplanet.cineplanetweb.controller;
import com.cineplanet.cineplanetweb.model.Promocion;
import org.json.JSONArray;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author wilme
 */
@WebServlet("/promociones")
public class PromocionController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String accion = req.getParameter("accion");
        try {
            if ("agregar".equals(accion)) {
                JSONObject body = new JSONObject()
                    .put("titulo", req.getParameter("titulo"))
                    .put("descripcion", req.getParameter("descripcion"))
                    .put("descuento_pct", Double.parseDouble(req.getParameter("descuentoPct")))
                    .put("fecha_inicio", req.getParameter("fechaInicio"))
                    .put("fecha_fin", req.getParameter("fechaFin"))
                    .put("activo", req.getParameter("activo") != null);
                SupabaseClient.insert("promociones", body);

            } else if ("editar".equals(accion)) {
                int id = Integer.parseInt(req.getParameter("id"));
                JSONObject body = new JSONObject()
                    .put("titulo", req.getParameter("titulo"))
                    .put("descripcion", req.getParameter("descripcion"))
                    .put("descuento_pct", Double.parseDouble(req.getParameter("descuentoPct")))
                    .put("fecha_inicio", req.getParameter("fechaInicio"))
                    .put("fecha_fin", req.getParameter("fechaFin"))
                    .put("activo", req.getParameter("activo") != null);
                SupabaseClient.update("promociones", id, body);

            } else if ("eliminar".equals(accion)) {
                int id = Integer.parseInt(req.getParameter("id"));
                SupabaseClient.delete("promociones", id);
            }

            resp.sendRedirect(req.getContextPath() + "/perfil");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
