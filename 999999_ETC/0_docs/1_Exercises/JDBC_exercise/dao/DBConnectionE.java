﻿package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBConnectionE {
    private static DBConnectionE instance = new DBConnectionE();
    private DBConnectionE() {}
    public static DBConnectionE getInstance() { return instance; }

    public Connection getConnection() {
        Connection conn = null;

        String url = "jdbc:oracle:thin:@localhost:1521:xe";
        String id = "***REMOVED***";
        String pw = "***REMOVED***";

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver"); // throws ClassNotFoundException
            conn = DriverManager.getConnection(url, id, pw); // throws SQLException
        } catch (Exception e) { // 일반적 예외 전부 캐치
            e.printStackTrace();
        }

        return conn;
    }

    public static void close(Connection conn, PreparedStatement pstmt) {
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
    }

    public static void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
}
