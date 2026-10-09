package com.lexora.controller;
import com.lexora.util.DBConnection;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/health")
public class HealthServlet extends HttpServlet {
    @Override protected void doGet(HttpServletRequest req,HttpServletResponse resp)throws IOException {
        resp.setContentType("text/plain;charset=UTF-8");
        try(Connection ignored=DBConnection.getConnection()) {
            resp.setStatus(200); resp.getWriter().println("Lexora database connection: OK");
        } catch(SQLException ex) {
            resp.setStatus(503); resp.getWriter().println("Lexora database connection: FAILED");
            getServletContext().log("Database health check failed",ex);
        }
    }
}
