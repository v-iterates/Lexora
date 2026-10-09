package com.lexora.dao;

import com.lexora.model.Lesson;
import com.lexora.util.DBConnection;
import java.sql.*;
import java.util.*;

public class LessonDAO {
    public List<Lesson> findApprovedLessons() throws SQLException {
        String sql = "SELECT * FROM lessons WHERE approval_status='APPROVED' ORDER BY lesson_id";
        List<Lesson> lessons = new ArrayList<>();
        try (Connection con=DBConnection.getConnection();
             PreparedStatement ps=con.prepareStatement(sql);
             ResultSet rs=ps.executeQuery()) {
            while(rs.next()) lessons.add(map(rs));
        }
        return lessons;
    }
    public Optional<Lesson> findApprovedById(int id) throws SQLException {
        String sql = "SELECT * FROM lessons WHERE lesson_id=? AND approval_status='APPROVED'";
        try(Connection con=DBConnection.getConnection(); PreparedStatement ps=con.prepareStatement(sql)) {
            ps.setInt(1,id);
            try(ResultSet rs=ps.executeQuery()) { if(rs.next()) return Optional.of(map(rs)); }
        }
        return Optional.empty();
    }
    private Lesson map(ResultSet rs) throws SQLException {
        Lesson l=new Lesson(); l.setLessonId(rs.getInt("lesson_id")); l.setTitle(rs.getString("title"));
        l.setSubtitle(rs.getString("subtitle")); l.setDescription(rs.getString("description"));
        l.setLanguage(rs.getString("language")); l.setProficiencyLevel(rs.getString("proficiency_level"));
        l.setTheme(rs.getString("theme")); l.setReadingMinutes(rs.getInt("reading_minutes"));
        l.setContent(rs.getString("content")); l.setCulturalNote(rs.getString("cultural_note")); return l;
    }
}
