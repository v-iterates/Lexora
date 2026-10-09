package com.lexora.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/** Central JDBC connection factory. Configure LEXORA_DB_* environment variables for your machine. */
public final class DBConnection {
    private static final String DEFAULT_URL =
        "jdbc:mysql://localhost:3306/lexora_db?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    private DBConnection() {}

    public static Connection getConnection() throws SQLException {
        String url = env("LEXORA_DB_URL", DEFAULT_URL);
        String user = env("LEXORA_DB_USER", "root");
        String password = env("LEXORA_DB_PASSWORD", "");
        return DriverManager.getConnection(url, user, password);
    }

    private static String env(String key, String fallback) {
        String value = System.getenv(key);
        return value == null ? fallback : value;
    }
}
