# Lexora — Language, lived through stories

A Java web application prototype for learning languages through short stories, contextual vocabulary, and cultural notes. This first-review build focuses on project structure, database design/connectivity, and responsive UI.

## Stack
- Java 17+, Maven
- Jakarta Servlets 6 / JSP, Apache Tomcat 10.1+
- MySQL 8+, JDBC
- HTML/CSS and minimal vanilla JavaScript

## Included
- Responsive landing page with lesson cards loaded from MySQL
- Lesson reading page with vocabulary and cultural notes
- JDBC connection factory and DAO classes
- `/health` endpoint to test database connectivity
- MySQL schema and starter seed data

Not yet implemented: registration/login, role-protected dashboards, quiz submission/scoring, saved-word operations, lesson authoring/approval, feedback submission, community posting, admin settings/activity UI. Do not claim these are complete.

## Setup
1. Install JDK 17+, Maven, MySQL 8+, and Tomcat 10.1+.
2. Run `database/schema.sql` in MySQL Workbench.
3. Run `database/seed.sql`.
4. Default local config is `localhost:3306/lexora_db`, user `root`, blank password. If your local password differs, set environment variables `LEXORA_DB_URL`, `LEXORA_DB_USER`, `LEXORA_DB_PASSWORD` before launching Tomcat. Never commit secrets.
5. From project root run `mvn clean package`. Output: `target/lexora.war`.
6. Copy WAR to Tomcat `webapps`, start Tomcat.
7. Open `http://localhost:8080/lexora/` and `http://localhost:8080/lexora/health`.

Tomcat 10.1 uses `jakarta.servlet.*`; Tomcat 9 is not compatible without conversion.

## Common errors
- Communications link failure: MySQL is stopped or URL/port is wrong.
- Access denied: check environment credentials.
- Unknown database/no lesson cards: run schema and seed scripts.
- 404: check Tomcat deployment and `/lexora/` context path.
- Maven command missing: install Maven or use IDE Maven integration.

## Architecture
Browser -> Servlet -> DAO -> DBConnection (JDBC) -> MySQL. JSP renders request data; DAOs isolate SQL. Prepared statements are used for parameterized queries.
