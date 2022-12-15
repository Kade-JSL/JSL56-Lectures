package com.jslhrd.dao;

import java.sql.*;
import java.util.*;
import com.jslhrd.dto.NoticeDto;
import com.jslhrd.dbmanager.DBManager;

public class NoticeDao {

	private static NoticeDao instance = new NoticeDao();
	private NoticeDao() {}
	public static NoticeDao getInstance() { return instance; }
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	DBManager dbm = DBManager.getInstance();
	List<NoticeDto> noticeList = null;
	NoticeDto dto = null;
	String query = null;
	
	public void noticeInsert(NoticeDto dto) {
		conn = dbm.getConnection();
		
		query = "INSERT INTO NOTICE (" +
					"BNO, TITLE, CONTENT, WRITER, REGDATE, VIEWCOUNT" +
				") VALUES (" +
					"NOTICE_SEQ.NEXTVAL, ?, ?, ?, SYSDATE, 0" + 
				")";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getWriter());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dbm.close(conn, pstmt);
		}
	}
	
}
