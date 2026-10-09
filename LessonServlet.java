package com.lexora.controller;
import com.lexora.dao.*;
import com.lexora.model.Lesson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Optional;

@WebServlet("/lesson")
public class LessonServlet extends HttpServlet {
    private final LessonDAO lessons=new LessonDAO();
    private final VocabularyDAO vocabulary=new VocabularyDAO();
    @Override protected void doGet(HttpServletRequest req,HttpServletResponse resp)throws ServletException,IOException {
        int id;
        try { id=Integer.parseInt(req.getParameter("id")); }
        catch(Exception ex){resp.sendError(400,"A valid lesson ID is required.");return;}
        try {
            Optional<Lesson> lesson=lessons.findApprovedById(id);
            if(lesson.isEmpty()){resp.sendError(404,"Lesson not found.");return;}
            req.setAttribute("lesson",lesson.get());
            req.setAttribute("vocabulary",vocabulary.findByLesson(id));
            req.getRequestDispatcher("/WEB-INF/views/lesson.jsp").forward(req,resp);
        } catch(SQLException ex) {
            getServletContext().log("Unable to load lesson "+id,ex);
            resp.sendError(500,"Could not load this lesson.");
        }
    }
}
