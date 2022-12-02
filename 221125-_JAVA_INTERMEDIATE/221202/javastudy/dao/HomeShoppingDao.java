﻿package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import DBManager.DBConnection;
import dto.HomeShoppingDto;

public class HomeShoppingDao {

    /* Singleton */
    private static HomeShoppingDao instance = new HomeShoppingDao();
    private HomeShoppingDao() {}
    public static HomeShoppingDao getInstance() { return instance; }

    /* C */
    public int insert(HomeShoppingDto dto) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        conn = DBConnection.getInstance().getConnection();

        String query = "INSERT INTO TBL_MEMBER (" +
        "CUSTNO, CUSTNAME, PHONE, GENDER, JOINDATE, GRADE, CITY" +
        ") VALUES (" +
        "?, ?, ?, ?, ?, ?, ?" +
        ")";
        int result = 0;

        try {
            pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, dto.getCustNo());
            pstmt.setString(2, dto.getCustName());
            pstmt.setString(3, dto.getPhone());
            pstmt.setString(4, dto.getGender());
            pstmt.setString(5, dto.getJoinDate());
            pstmt.setString(6, dto.getGrade());
            pstmt.setString(7, dto.getCity());

            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.close(conn, pstmt);
        }

        return result;
    }

    /* R */
    public HomeShoppingDto select(int custNo) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        conn = DBConnection.getInstance().getConnection();

        String query = "SELECT * FROM TBL_MEMBER WHERE CUSTNO = " + custNo;
        HomeShoppingDto dto = null;

        try {
            pstmt = conn.prepareStatement(query);
            rs = pstmt.executeQuery();
            if (!rs.next()) return null;
            dto = new HomeShoppingDto();
            dto.setCustNo(custNo);
            dto.setCustName(rs.getString("CUSTNAME"));
            dto.setPhone(rs.getString("PHONE"));
            dto.setGender(rs.getString("GENDER"));
            dto.setJoinDate(rs.getString("JOINDATE"));
            dto.setGrade(rs.getString("GRADE"));
            dto.setCity(rs.getString("CITY"));
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.close(conn, pstmt, rs);
        }

        return dto;
    }

    public List<HomeShoppingDto> selectAll() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        conn = DBConnection.getInstance().getConnection();

        String query = "SELECT * FROM TBL_MEMBER";
        List<HomeShoppingDto> dtoList = new ArrayList<HomeShoppingDto>();
        HomeShoppingDto dto = null;

        try {
            pstmt = conn.prepareStatement(query);
            rs = pstmt.executeQuery();
            while(rs.next()) {
                dto = new HomeShoppingDto();
                dto.setCustNo(rs.getInt("CUSTNO"));
                dto.setCustName(rs.getString("CUSTNAME"));
                dto.setPhone(rs.getString("PHONE"));
                dto.setGender(rs.getString("GENDER"));
                dto.setJoinDate(rs.getString("JOINDATE"));
                dto.setGrade(rs.getString("GRADE"));
                dto.setCity(rs.getString("CITY"));
                dtoList.add(dto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.close(conn, pstmt, rs);
        }

        return dtoList;
    }

    /* U */
    public int update(HomeShoppingDto dto) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        conn = DBConnection.getInstance().getConnection();

        String query = "UPDATE TBL_MEMBER SET " +
        "CUSTNAME = ?, PHONE = ?, GENDER = ?, GRADE = ?, CITY = ? " +
        "WHERE " +
        "CUSTNO = ?";
        int result = 0;

        try {
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, dto.getCustName());
            pstmt.setString(2, dto.getPhone());
            pstmt.setString(3, dto.getGender());
            pstmt.setString(4, dto.getGrade());
            pstmt.setString(5, dto.getCity());
            pstmt.setInt(6, dto.getCustNo());

            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.close(conn, pstmt);
        }

        return result;
    }

    /* D */
    public int delete(int custNo) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        conn = DBConnection.getInstance().getConnection();

        String query = "DELETE FROM TBL_MEMBER WHERE CUSTNO = " + custNo;
        int result = 0;

        try {
            pstmt = conn.prepareStatement(query);
            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.close(conn, pstmt);
        }

        return result;
    }

    public List<HomeShoppingDto> selectSaleList() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        conn = DBConnection.getInstance().getConnection();

        String query =
        "SELECT " +
            "MO.SALENO," +
            "ME.CUSTNAME," +
            "MO.SDATE," +
            "GO.PNAME," +
            "MO.AMOUNT," +
            "GO.PCOST," +
            "MO.AMOUNT * GO.PCOST AS TOT " +
        "FROM " +
            "TBL_MEMBER ME " +
            "INNER JOIN TBL_MONEY MO " +
            "ON MO.CUSTNO = ME.CUSTNO " +
            "INNER JOIN TBL_GOODS GO " +
            "ON MO.PCODE = GO.PCODE";
        List<HomeShoppingDto> dtoList = new ArrayList<HomeShoppingDto>();
        HomeShoppingDto dto = null;

        try {
            pstmt = conn.prepareStatement(query);
            rs = pstmt.executeQuery();
            while(rs.next()) {
                dto = new HomeShoppingDto();
                dto.setSaleNo(rs.getInt("SALENO"));
                dto.setCustName(rs.getString("CUSTNAME"));
                dto.setsDate(rs.getString("SDATE"));
                dto.setpName(rs.getString("PNAME"));
                dto.setAmount(rs.getInt("AMOUNT"));
                dto.setpCost(rs.getInt("PCOST"));
                dto.setAmountXcost(rs.getInt("TOT"));
                dtoList.add(dto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.close(conn, pstmt, rs);
        }

        return dtoList;
    }

    public List<HomeShoppingDto> selectCustSale() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        conn = DBConnection.getInstance().getConnection();

        String query =
        "SELECT " + 
            "A.CUSTNO," +
            "A.CUSTNAME," +
            "A.PHONE," + 
            "A.GRADE," +
            "SUM(B.AMOUNT * C.PCOST) AS TOT " +
        "FROM " +
            "TBL_MEMBER A " +
            "INNER JOIN TBL_MONEY B " +
            "ON A.CUSTNO = B.CUSTNO " +
            "INNER JOIN TBL_GOODS C " +
            "ON B.PCODE = C.PCODE " +
        "GROUP BY " +
            "A.CUSTNO," +
            "A.CUSTNAME," +
            "A.PHONE," +
            "A.GRADE " +
        "ORDER BY " +
            "TOT DESC";
        
        List<HomeShoppingDto> dtoList = new ArrayList<HomeShoppingDto>();
        HomeShoppingDto dto = null;

        try {
            pstmt = conn.prepareStatement(query);
            rs = pstmt.executeQuery();
            while(rs.next()) {
                dto = new HomeShoppingDto();
                dto.setCustNo(rs.getInt("CUSTNO"));
                dto.setCustName(rs.getString("CUSTNAME"));
                dto.setPhone(rs.getString("PHONE"));
                dto.setGrade(rs.getString("GRADE"));
                dto.setAmountXcost(rs.getInt("TOT"));
                dtoList.add(dto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.close(conn, pstmt, rs);
        }

        return dtoList;
    }

    public int getCustNo() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        conn = DBConnection.getInstance().getConnection();

        String query = "SELECT MAX(CUSTNO) AS MNO FROM TBL_MEMBER";
        int mno = 0;

        try {
            pstmt = conn.prepareStatement(query);
            rs = pstmt.executeQuery();
            if(rs.next()) { mno = rs.getInt("MNO"); }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.close(conn, pstmt, rs);
        }

        return mno;
    }
}
