package com.shim.controller.comment;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.shim.dao.CommentsDao;

/**
 * Servlet implementation class Comment
 */
@WebServlet("/comment.do")
public class Comment extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Comment() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		int pno = Integer.parseInt(request.getParameter("pno"));
		List<Map<String, Object>> list = CommentsDao.getInstance().readComments(pno);
		String res = new Gson().toJson(list); // GSON 라이브러리로 리스트 객체를 JSON으로 간단하게 변환
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json"); // 보내는 데이터의 형태가 JSON
		PrintWriter out = response.getWriter(); // 출력 스트림 객체
		out.print(res); // 요청 결과를 호출한 곳에 전달.
		out.close();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uno", Integer.parseInt(request.getParameter("uno")));
		int pno = Integer.parseInt(request.getParameter("pno"));
		map.put("pno", pno);
		map.put("content", request.getParameter("content"));
		// 댓글 폼에서 받아온 정보들을 HashMap에 저장
		CommentsDao dao = CommentsDao.getInstance();
		dao.createComment(map); // 댓글을 DB에 작성
		
		List<Map<String, Object>> list = dao.readComments(pno); // 작성 후 댓글창이 바로 갱신되도록 댓글 리스트를 새로 불러옴
		String res = new Gson().toJson(list); // 똑같이 JSON으로 변환
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		out.print(res); // 똑같이 전송
		out.close();
	}

}
