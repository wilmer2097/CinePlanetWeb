package com.cineplanet.cineplanetweb.controller;

import com.cineplanet.cineplanetweb.model.Movie;
import org.json.JSONArray;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.net.*;
import java.util.*;

@WebServlet("/peliculasAnio")
public class PeliculasAnioServlet extends HttpServlet {

    private static final String DISCOVER_URL = "https://api.themoviedb.org/3/discover/movie";
    private static final String SEARCH_URL = "https://api.themoviedb.org/3/search/movie";
    private static final String BEARER_TOKEN
            = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhNGJmMDMwZmM0ZjcxMWI2MTQxYWM1ZmQzNDgyZDIzNCIsIm5iZiI6MTY3ODkxMDY0NC44MDQsInN1YiI6IjY0MTIyNGI0YjQyMjQyMDA4YTJmNDUwNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ."
            + "u1vZlVKu-k8lY5UYz6XmjLo5IpZo0FxSOawn0hj5sI4";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String q = req.getParameter("q");
        // Si no viene ningún parámetro 'q', redirigimos añadiéndolo vacío
        if (q == null) {
            resp.sendRedirect(req.getContextPath() + "/peliculasAnio?q=");
            return;
        }

        int year = java.time.Year.now().getValue();
        StringBuilder sb = new StringBuilder();
        if (!q.trim().isEmpty()) {
            sb.append(SEARCH_URL)
                    .append("?language=es-ES")
                    .append("&year=").append(year)
                    .append("&query=").append(URLEncoder.encode(q.trim(), "UTF-8"));
        } else {
            sb.append(DISCOVER_URL)
                    .append("?language=es-ES")
                    .append("&primary_release_year=").append(year)
                    .append("&sort_by=popularity.desc");
        }

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

        List<Movie> lista = new ArrayList<>();
        JSONObject root = new JSONObject(json.toString());
        JSONArray results = root.getJSONArray("results");
        for (int i = 0; i < results.length(); i++) {
            JSONObject o = results.getJSONObject(i);
            Movie m = new Movie();
            m.setTitle(o.optString("title"));
            m.setReleaseDate(o.optString("release_date"));
            m.setOverview(o.optString("overview"));
            m.setPosterPath(o.optString("poster_path"));
            lista.add(m);
        }

        req.setAttribute("peliculas", lista);
        req.setAttribute("searchQuery", q);

        req.getRequestDispatcher("/vista/peliculasAnio.jsp")
                .forward(req, resp);
    }
}
