<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<script src="../js/commentlist.js"></script>

<div class="col-md-9 col-md-offset-0 col-xs-10 col-xs-offset-1 container-fluid piecesview">
	<h4 class="bolder text-left">
		<a href="pieceslist.do"><span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>作品リストへ</a>
	</h4>
	<h1 class="boldest text-center">${map.title}<br></h1>
	<p class="text-center">
	<span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>&nbsp;${map.regdate}&nbsp;/&nbsp;
	<span class="glyphicon glyphicon-eye-open" aria-hidden="true"></span>&nbsp;${map.viewcount}&nbsp;/&nbsp;
	<span class="glyphicon glyphicon-heart" aria-hidden="true"></span>&nbsp;${map.likecount}<br><br>
	</p>
	<p class="text-right pr15"><img class="img-responsive" src="../upload/${map.profileimg}"></p>
	<h3 class="text-right pr15">${map.uname}<br><br></h3>
	<p class="text-justify content">${map.content}</p>
	<h2 class="text-left bolder"><br><br><span class="glyphicon glyphicon-comment"></span>&nbsp;コメント</h2><br><br>
	<c:if test="${empty user}"><fieldset disabled></c:if>
	<textarea id="comment" class="form-control" rows="3" placeholder="${empty user ? '':'コメント入力…'}"><c:if test="${empty user}">コメントはサインインした後で入力できます。</c:if></textarea>
	<input name="pno" type="hidden" id="pno" value="${map.pno}"/>
	<input name="uno" type="hidden" id="uno" value="${user.uno}"/>
	<c:if test="${empty user}"></fieldset></c:if>
	<c:if test="${not empty user}">
		<div class="text-right">
			<button id="commentbtn" class="btn btn-default" style="margin-top: 1em;">コメント作成</button><br>
			<span id="commentmsg" class="form-empty"></span>
		</div>
	</c:if>
	<br><br>
	<table class="table">
		<tbody id="commentlist">
		</tbody>
	</table>
	<br><br>
	<c:if test="${not empty admin}">
		<p class="text-center">
			<a href="piecesdel.do?where=${map.pno}" class="btn btn-danger">削除</a>
			<a href="piecesmod.do?where=${map.pno}" class="btn btn-success">修正</a>
		</p>
	</c:if>
	<h4 class="bolder text-left">
		<a href="pieceslist.do"><span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>作品リストへ</a>
	</h4>
</div>


<%@ include file="../footer.jsp" %>