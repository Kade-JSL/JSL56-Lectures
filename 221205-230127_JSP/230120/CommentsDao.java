package com.shim.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.shim.utility.UtilityMethods;

public class CommentsDao {

	private static CommentsDao instance = new CommentsDao() {};
	private CommentsDao() {}
	public static CommentsDao getInstance() { return instance; }
	
	DBConn dbc = DBConn.getInstance();
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	public void createComment (Map<String, Object> map) {
		conn = dbc.getConnection();
		
		String sql = "INSERT INTO P1_COMMENTS (CNO, UNO, PNO, CONTENT) VALUES (CNO_SEQ.NEXTVAL, ?, ?, ?)";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, (int) map.get("uno"));
			pstmt.setInt(2, (int) map.get("pno"));
			pstmt.setString(3, (String) map.get("content"));
			
			pstmt.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dbc.close(conn, pstmt);
		}
	}
	
	public List<Map<String, Object>> readComments (int pno) {
		List<Map<String, Object>> list = null;
		Map<String, Object> map = null;
		conn = dbc.getConnection();
		
		String sql = "SELECT /*+ INDEX_DESC (P1_USERS P1_USERS_PK) +*/ " +
				"P.PNO, U.UNAME, U.PROFILEIMG, C.REGDATE, C.LIKECOUNT, C.CONTENT " + 
				"FROM P1_COMMENTS C INNER JOIN P1_PIECES P ON C.PNO = P.PNO " + 
				"INNER JOIN P1_USERS U ON C.UNO = U.UNO WHERE P.PNO = ? ORDER BY C.REGDATE DESC";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pno);
			rs = pstmt.executeQuery();
			if (rs != null) {
				list = new ArrayList<Map<String, Object>>();
			}
			while (rs.next()) {
				map = new HashMap<String, Object>();
				map.put("pno", pno);
				map.put("uname", rs.getString("UNAME"));
				map.put("profileimg", rs.getString("PROFILEIMG"));
				String date = rs.getString("REGDATE");
				map.put("regdate", UtilityMethods.flexDate(date));
				map.put("likecount", rs.getInt("LIKECOUNT"));
				map.put("content", rs.getString("CONTENT"));
				list.add(map);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dbc.close(conn, pstmt, rs);
		}
		
		return list;
	}
}
