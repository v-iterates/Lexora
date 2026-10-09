CREATE DATABASE IF NOT EXISTS lexora_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE lexora_db;
CREATE TABLE IF NOT EXISTS users (
 user_id INT PRIMARY KEY AUTO_INCREMENT, full_name VARCHAR(100) NOT NULL,
 email VARCHAR(150) NOT NULL UNIQUE, password_hash VARCHAR(100) NOT NULL,
 role ENUM('ADMIN','INSTRUCTOR','LEARNER') NOT NULL DEFAULT 'LEARNER',
 is_active BOOLEAN NOT NULL DEFAULT TRUE, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS lessons (
 lesson_id INT PRIMARY KEY AUTO_INCREMENT, instructor_id INT NULL,
 title VARCHAR(180) NOT NULL, subtitle VARCHAR(240), description TEXT,
 language VARCHAR(60) NOT NULL,
 proficiency_level ENUM('BEGINNER','INTERMEDIATE','ADVANCED') NOT NULL DEFAULT 'BEGINNER',
 theme VARCHAR(80) NOT NULL DEFAULT 'Stories & Folklore', reading_minutes INT NOT NULL DEFAULT 5,
 content_type ENUM('READING','DIALOGUE') NOT NULL DEFAULT 'READING', content MEDIUMTEXT NOT NULL,
 cultural_note TEXT, approval_status ENUM('DRAFT','PENDING','APPROVED','REJECTED') NOT NULL DEFAULT 'APPROVED',
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 FOREIGN KEY (instructor_id) REFERENCES users(user_id) ON DELETE SET NULL
);
CREATE TABLE IF NOT EXISTS vocabulary (
 vocabulary_id INT PRIMARY KEY AUTO_INCREMENT, lesson_id INT NOT NULL, word VARCHAR(100) NOT NULL,
 translation VARCHAR(150) NOT NULL, pronunciation VARCHAR(150), usage_example TEXT,
 FOREIGN KEY (lesson_id) REFERENCES lessons(lesson_id) ON DELETE CASCADE, UNIQUE KEY uq_lesson_word(lesson_id,word)
);
CREATE TABLE IF NOT EXISTS quizzes (
 quiz_id INT PRIMARY KEY AUTO_INCREMENT, lesson_id INT NOT NULL UNIQUE, title VARCHAR(180) NOT NULL,
 FOREIGN KEY (lesson_id) REFERENCES lessons(lesson_id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS questions (
 question_id INT PRIMARY KEY AUTO_INCREMENT, quiz_id INT NOT NULL, question_text TEXT NOT NULL,
 option_a VARCHAR(250) NOT NULL, option_b VARCHAR(250) NOT NULL, option_c VARCHAR(250) NOT NULL, option_d VARCHAR(250) NOT NULL,
 correct_option CHAR(1) NOT NULL CHECK (correct_option IN ('A','B','C','D')), explanation TEXT,
 FOREIGN KEY (quiz_id) REFERENCES quizzes(quiz_id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS lesson_progress (
 progress_id INT PRIMARY KEY AUTO_INCREMENT, learner_id INT NOT NULL, lesson_id INT NOT NULL,
 status ENUM('NOT_STARTED','IN_PROGRESS','COMPLETED') NOT NULL DEFAULT 'NOT_STARTED',
 best_score DECIMAL(5,2), attempts INT NOT NULL DEFAULT 0, started_at TIMESTAMP NULL, completed_at TIMESTAMP NULL,
 updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 FOREIGN KEY (learner_id) REFERENCES users(user_id) ON DELETE CASCADE,
 FOREIGN KEY (lesson_id) REFERENCES lessons(lesson_id) ON DELETE CASCADE, UNIQUE KEY uq_learner_lesson(learner_id,lesson_id)
);
CREATE TABLE IF NOT EXISTS quiz_attempts (
 attempt_id INT PRIMARY KEY AUTO_INCREMENT, learner_id INT NOT NULL, quiz_id INT NOT NULL,
 score DECIMAL(5,2) NOT NULL, total_questions INT NOT NULL, attempted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY (learner_id) REFERENCES users(user_id) ON DELETE CASCADE,
 FOREIGN KEY (quiz_id) REFERENCES quizzes(quiz_id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS saved_words (
 saved_word_id INT PRIMARY KEY AUTO_INCREMENT, learner_id INT NOT NULL, vocabulary_id INT NOT NULL,
 saved_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, FOREIGN KEY (learner_id) REFERENCES users(user_id) ON DELETE CASCADE,
 FOREIGN KEY (vocabulary_id) REFERENCES vocabulary(vocabulary_id) ON DELETE CASCADE, UNIQUE KEY uq_saved_word(learner_id,vocabulary_id)
);
CREATE TABLE IF NOT EXISTS feedback (
 feedback_id INT PRIMARY KEY AUTO_INCREMENT, instructor_id INT NOT NULL, learner_id INT NOT NULL, lesson_id INT NULL,
 message TEXT NOT NULL, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY (instructor_id) REFERENCES users(user_id), FOREIGN KEY (learner_id) REFERENCES users(user_id) ON DELETE CASCADE,
 FOREIGN KEY (lesson_id) REFERENCES lessons(lesson_id) ON DELETE SET NULL
);
CREATE TABLE IF NOT EXISTS discussion_posts (
 post_id INT PRIMARY KEY AUTO_INCREMENT, user_id INT NOT NULL, parent_post_id INT NULL, title VARCHAR(180), body TEXT NOT NULL,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
 FOREIGN KEY (parent_post_id) REFERENCES discussion_posts(post_id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS app_settings (
 setting_key VARCHAR(100) PRIMARY KEY, setting_value VARCHAR(500) NOT NULL,
 updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS activity_logs (
 activity_id BIGINT PRIMARY KEY AUTO_INCREMENT, user_id INT NULL, action VARCHAR(100) NOT NULL, details VARCHAR(500),
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE SET NULL,
 INDEX idx_activity_created(created_at)
);
INSERT INTO app_settings(setting_key,setting_value) VALUES ('site_name','Lexora'),('allow_registration','true'),('default_language','French')
ON DUPLICATE KEY UPDATE setting_value=VALUES(setting_value);
