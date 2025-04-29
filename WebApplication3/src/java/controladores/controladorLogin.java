/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controladores;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Guillermo
 */
@WebServlet(name = "controladorLogin", urlPatterns = {"/controladorLogin"})
public class controladorLogin extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        processRequest(request, response);
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/tecsolve?useTimeZone=true&"
                + "serverTimezone=UTC&autoReconnect=true", "root", "12345678");
            String usuario=request.getParameter("usuario");
            String contraseña=request.getParameter("clave");
                 
            String sql = "SELECT clave FROM usuario WHERE nombre = ?";
            PreparedStatement statement = conexion.prepareStatement(sql);
            statement.setString(1, usuario);

            ResultSet resultado = statement.executeQuery();

            if (resultado.next()) {
                String contraseñaBD = resultado.getString("clave");

                if (contraseña.equals(contraseñaBD)) { // ← comparación segura
                    // Inicio de sesión correcto
                    HttpSession session = request.getSession();
                    session.setAttribute("usuario", usuario);
                    request.getRequestDispatcher("./vistas/dashBoard.jsp").forward(request, response);
                } else {
                    System.out.println("Contraseña incorrecta");
                    response.sendRedirect("./vistas/login.jsp?error=contraseña");
                    request.setAttribute("error", "Usuario o contraseña incorrectos.");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("./vistas/login.jsp");
                    dispatcher.forward(request, response);
                }
            } else {
                request.setAttribute("error", "Usuario o contraseña incorrectos.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("./vistas/login.jsp");
                dispatcher.forward(request, response);
            }

            resultado.close();
            statement.close();
            conexion.close();
        }catch (Exception e){
            System.out.println(e);
        }
        
        
        
                
                
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
