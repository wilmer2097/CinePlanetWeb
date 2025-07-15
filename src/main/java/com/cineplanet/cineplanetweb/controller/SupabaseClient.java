/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cineplanet.cineplanetweb.controller;

import java.io.IOException;
import java.net.URI;
import java.net.http.*;
import java.net.http.HttpResponse.BodyHandlers;
import java.time.Duration;

import org.json.JSONArray;
import org.json.JSONObject;
import org.json.JSONTokener;

/**
 *
 * @author wilme
 */
public class SupabaseClient {

    private static final String URL = "https://ksgmirhswbafvuzlmtiz.supabase.co";
    private static final String KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtzZ21pcmhzd2JhZnZ1emxtdGl6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTI1NTcyMzksImV4cCI6MjA2ODEzMzIzOX0.ntilgoyzsdT_Nd_FbUxaAdT-KSrcN-gMLxtIS2PryaY";
    private static final HttpClient CLIENT = HttpClient
            .newBuilder()
            .connectTimeout(Duration.ofSeconds(10))
            .build();

    public static JSONArray getAll(String table) throws IOException, InterruptedException {
        HttpRequest req = HttpRequest.newBuilder()
                .uri(URI.create(URL + "/rest/v1/" + table + "?select=*"))
                .header("apikey", KEY)
                .header("Authorization", "Bearer " + KEY)
                .GET()
                .build();
        HttpResponse<String> resp = CLIENT.send(req, BodyHandlers.ofString());
        return new JSONArray(resp.body());
    }

    public static JSONObject insert(String table, JSONObject body) throws IOException, InterruptedException {
        HttpRequest req = HttpRequest.newBuilder()
                .uri(URI.create(URL + "/rest/v1/" + table))
                .header("apikey", KEY)
                .header("Authorization", "Bearer " + KEY)
                .header("Content-Type", "application/json")
                .header("Prefer", "return=representation") // ← esta línea
                .POST(HttpRequest.BodyPublishers.ofString(body.toString()))
                .build();
        HttpResponse<String> resp = CLIENT.send(req, BodyHandlers.ofString());
        return parseSingle(resp.body());
    }

    public static JSONObject update(String table, int id, JSONObject body) throws IOException, InterruptedException {
        HttpRequest req = HttpRequest.newBuilder()
                .uri(URI.create(URL + "/rest/v1/" + table + "?id=eq." + id))
                .header("apikey", KEY)
                .header("Authorization", "Bearer " + KEY)
                .header("Content-Type", "application/json")
                .header("Prefer", "return=representation") // ← y aquí también
                .method("PATCH", HttpRequest.BodyPublishers.ofString(body.toString()))
                .build();
        HttpResponse<String> resp = CLIENT.send(req, BodyHandlers.ofString());
        return parseSingle(resp.body());
    }

    public static void delete(String table, int id) throws IOException, InterruptedException {
        HttpRequest req = HttpRequest.newBuilder()
                .uri(URI.create(URL + "/rest/v1/" + table + "?id=eq." + id))
                .header("apikey", KEY)
                .header("Authorization", "Bearer " + KEY)
                .DELETE()
                .build();
        CLIENT.send(req, BodyHandlers.discarding());
    }

    /**
     * Si la respuesta es un array [ {...} ], devuelve el primer objeto. Si es
     * un objeto { ... }, lo devuelve directamente.
     */
    private static JSONObject parseSingle(String responseBody) {
        String trimmed = responseBody.trim();
        Object json = new JSONTokener(trimmed).nextValue();
        if (json instanceof JSONArray) {
            JSONArray arr = (JSONArray) json;
            return arr.getJSONObject(0);
        } else {
            return (JSONObject) json;
        }
    }
}
