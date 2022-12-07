<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ page import="model.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>

<%
	List<Vo> stuList = Dao.getInstance().selectAllStudent();
	DecimalFormat df = new DecimalFormat("###.#");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고교 성적 관리 프로그램</title>
<style>
	* {margin: 0; padding: 0;}
	a {text-decoration: none;}
	ul, ol {list-style: none;}
	table, th, td {border: 1px solid #ccc;}
	
	header {background: #00f; padding: 20px 0;}
	h1 {text-align: center; color: #fff;}
	nav {overflow: hidden; background: #06f;}
	nav ul li {float:left;}
	nav ul li a {padding: 12px 16px; display: block; color: #fff;}
	section {height: 500px;}
	h2 {padding: 30px 0; text-align: center;}
	p {padding: 0 0 0 16px;}
	footer {background: #00f; padding: 20px 0;}
	footer p {color: #fff; text-align: center;}
	table {margin: 0 auto;}
	table tr td, table tr th {text-align: center;}
	.sname {width: 220px;}
	.birth {width: 220px;}
	.tel {width: 60px;}
</style>
</head>
<body>
<header>
	<h1>(과정평가형 정보처리산업기사)고교성적관리프로그램 ver2019-05</h1>
</header>
<nav>
	<ul>
		<li><a href="sub1.jsp">학생등록</a></li>
		<li><a href="sub2.jsp">성적입력</a></li>
		<li><a href="sub3.jsp">성적조회</a></li>
		<li><a href="sub4.jsp">반별통계</a></li>
		<li><a href="index.jsp">홈으로</a></li>
	</ul>
</nav>
<section>
	<h2>학생 성적 조회</h2>
	<table>
		<tr>
			<th>학년-반-번호</th>
			<th>이름</th>
			<th>성별</th>
			<th>국어</th>
			<th>영어</th>
			<th>수학</th>
			<th>총점</th>
			<th>평균</th>
		</tr>
		<%
		int kor = 0, eng = 0, mat = 0;
		String korAvg, engAvg, matAvg;
		for (Vo v : stuList) {
		%>
		<tr>
			<td><%=v.getSyear()+"-"+v.getSclass()+"-"+v.getSno()%></td>
			<td><%=v.getSname()%></td>
			<%
				String genderString = null;
				if (v.getGender().equals("M")) {
					genderString = "남";
				} else if (v.getGender().equals("F")) {
					genderString = "여";
				} else {
					genderString = "논";
				}
			%>
			<td><%=genderString%></td>
			<td><%=v.getKor()%></td>
			<td><%=v.getEng()%></td>
			<td><%=v.getMat()%></td>
			<td><%=v.getTot()%></td>
			<td><%=v.getAvg()%></td>
		</tr>
		<%
		kor += v.getKor();
		eng += v.getEng();
		mat += v.getMat();
		}
		korAvg = df.format(kor / (double) stuList.size());
		engAvg = df.format(eng / (double) stuList.size());
		matAvg = df.format(mat / (double) stuList.size());
		%>
		<tr>
			<td></td>
			<td></td>
			<td>학년총점</td>
			<td><%=kor%></td>
			<td><%=eng%></td>
			<td><%=mat%></td>
			<td></td>
			<td></td>
		</tr>
		<tr>
			<td></td>
			<td></td>
			<td>학년평균</td>
			<td><%=korAvg%></td>
			<td><%=engAvg%></td>
			<td><%=matAvg%></td>
			<td></td>
			<td></td>
		</tr>
	</table>
</section>
<footer>
	<p>HRDKOREA Copyright &copy; 2016 All rights reserved. Human Resources Development Service of Korea</p>
</footer>
</body>
</html>