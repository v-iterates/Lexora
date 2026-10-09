package com.lexora.controller;
import com.lexora.dao.LessonDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(urlPatterns={"","/home"})
public class HomeServlet extends HttpServlet {
    private final LessonDAO dao=new LessonDAO();
    @Override protected void doGet(HttpServletRequest req,HttpServletResponse resp)throws ServletException,IOException {
        try {
            req.setAttribute("lessons",dao.findApprovedLessons());
            req.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(req,resp);
        } catch(SQLException e) {
            getServletContext().log("Unable to load lessons. Check MySQL setup.",e);
            resp.sendError(500,"Lexora could not load lessons. Check database/schema.sql and your database connection.");
        }
    }
}
