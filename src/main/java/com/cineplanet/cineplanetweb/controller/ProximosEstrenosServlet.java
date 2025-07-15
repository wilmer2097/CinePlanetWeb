package com.cineplanet.cineplanetweb.controller;

import com.cineplanet.cineplanetweb.model.Movie;
import org.json.JSONArray;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.net.*;
import java.time.LocalDate;
import java.util.*;

@WebServlet("/proximosEstrenos")
public class ProximosEstrenosServlet extends HttpServlet {

    private static final String DISCOVER_URL = "https://api.themoviedb.org/3/discover/movie";
    private static final String BEARER_TOKEN = 
        "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhNGJmMDMwZmM0ZjcxMWI2MTQxYWM1ZmQzNDgyZDIzNCIsIm5iZiI6MTY3ODkxMDY0NC44MDQsInN1YiI6IjY0MTIyNGI0YjQyMjQyMDA4YTJmNDUwNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ."
      + "u1vZlVKu-k8lY5UYz6XmjLo5IpZo0FxSOawn0hj5sI4";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Fecha de mañana en formato ISO (yyyy-MM-dd)
        String tomorrow = LocalDate.now().plusDays(1).toString();

        // Construir URL de TMDb para próximos estrenos a partir de mañana
        StringBuilder sb = new StringBuilder(DISCOVER_URL)
          .append("?language=es-ES")
          .append("&primary_release_date.gte=").append(tomorrow)
          .append("&sort_by=primary_release_date.asc");

        // Conectar y leer respuesta JSON
        URL url = new URL(sb.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Authorization", BEARER_TOKEN);

        int status = conn.getResponseCode();
        InputStream is = (status == 200) ? conn.getInputStream() : conn.getErrorStream();
        BufferedReader reader = new BufferedReader(new InputStreamReader(is, "UTF-8"));
        StringBuilder json = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            json.append(line);
        }
        reader.close();
        conn.disconnect();

        // Parsear JSON y crear lista de Movie
        List<Movie> proximos = new ArrayList<>();
        JSONObject root = new JSONObject(json.toString());
        JSONArray results = root.optJSONArray("results");
        if (results != null) {
            for (int i = 0; i < results.length(); i++) {
                JSONObject o = results.getJSONObject(i);
                Movie m = new Movie();
                m.setTitle      ( o.optString("title") );
                m.setReleaseDate( o.optString("release_date") );
                m.setOverview   ( o.optString("overview") );
                m.setPosterPath ( o.optString("poster_path") );
                proximos.add(m);
            }
        }

        // Pasar al JSP protegido en WEB-INF
        req.setAttribute("peliculasProximas", proximos);
        req.getRequestDispatcher("/vista/proximosEstrenos.jsp")
           .forward(req, resp);
    }
}
