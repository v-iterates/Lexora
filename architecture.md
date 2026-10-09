# Lexora architecture
Browser -> HomeServlet/LessonServlet -> LessonDAO/VocabularyDAO -> DBConnection -> MySQL.
JSP views render data placed on the request by Servlets. DAO classes isolate SQL. DBConnection centralizes connection settings. Parameterized SQL uses PreparedStatement.

## Relationships
- One instructor may create many lessons.
- One lesson has many vocabulary entries and at most one quiz.
- One quiz has many questions and many learner attempts.
- Learners have one progress record per lesson and can save vocabulary.
- Feedback connects an instructor and learner, optionally to a lesson.
- Discussion posts can reply to other posts.
