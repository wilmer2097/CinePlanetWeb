/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cineplanet.cineplanetweb.controller;

import com.cineplanet.cineplanetweb.model.Cine;
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
@WebServlet("/cines")
public class CineController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            JSONArray arr = SupabaseClient.getAll("cines");
            List<Cine> list = new ArrayList<>();
            for (int i = 0; i < arr.length(); i++) {
                list.add(Cine.fromJson(arr.getJSONObject(i)));
            }
            req.setAttribute("cines", list);
            req.getRequestDispatcher("/vista/perfil.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String accion = req.getParameter("accion");
        try {
            if ("agregar".equals(accion)) {
                JSONObject body = new JSONObject()
                    .put("nombre", req.getParameter("nombre"))
                    .put("direccion", req.getParameter("direccion"))
                    .put("ciudad", req.getParameter("ciudad"))
                    .put("telefono", req.getParameter("telefono"));
                SupabaseClient.insert("cines", body);

            } else if ("editar".equals(accion)) {
                int id = Integer.parseInt(req.getParameter("id"));
                JSONObject body = new JSONObject()
                    .put("nombre", req.getParameter("nombre"))
                    .put("direccion", req.getParameter("direccion"))
                    .put("ciudad", req.getParameter("ciudad"))
                    .put("telefono", req.getParameter("telefono"));
                SupabaseClient.update("cines", id, body);

            } else if ("eliminar".equals(accion)) {
                int id = Integer.parseInt(req.getParameter("id"));
                SupabaseClient.delete("cines", id);
            }

            resp.sendRedirect(req.getContextPath() + "/perfil");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}