package com.lexora.model;

public class Lesson {
    private int lessonId, readingMinutes;
    private String title, subtitle, description, language, proficiencyLevel, theme, content, culturalNote;
    public int getLessonId(){return lessonId;} public void setLessonId(int v){lessonId=v;}
    public int getReadingMinutes(){return readingMinutes;} public void setReadingMinutes(int v){readingMinutes=v;}
    public String getTitle(){return title;} public void setTitle(String v){title=v;}
    public String getSubtitle(){return subtitle;} public void setSubtitle(String v){subtitle=v;}
    public String getDescription(){return description;} public void setDescription(String v){description=v;}
    public String getLanguage(){return language;} public void setLanguage(String v){language=v;}
    public String getProficiencyLevel(){return proficiencyLevel;} public void setProficiencyLevel(String v){proficiencyLevel=v;}
    public String getTheme(){return theme;} public void setTheme(String v){theme=v;}
    public String getContent(){return content;} public void setContent(String v){content=v;}
    public String getCulturalNote(){return culturalNote;} public void setCulturalNote(String v){culturalNote=v;}
}
