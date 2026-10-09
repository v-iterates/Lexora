package com.lexora.dao;
import com.lexora.util.DBConnection;
import java.sql.*;
import java.util.*;

public class VocabularyDAO {
    public record VocabularyItem(int id, String word, String translation, String pronunciation, String example) {}
    public List<VocabularyItem> findByLesson(int lessonId) throws SQLException {
        String sql="SELECT vocabulary_id,word,translation,pronunciation,usage_example FROM vocabulary WHERE lesson_id=? ORDER BY vocabulary_id";
        List<VocabularyItem> list=new ArrayList<>();
        try(Connection c=DBConnection.getConnection(); PreparedStatement p=c.prepareStatement(sql)) {
            p.setInt(1,lessonId);
            try(ResultSet r=p.executeQuery()) { while(r.next()) list.add(new VocabularyItem(r.getInt(1),r.getString(2),r.getString(3),r.getString(4),r.getString(5))); }
        }
        return list;
    }
}
