
## 댓글 영역을 구현한 방법

```html
...
<script src="../js/commentlist.js"></script>
...
<c:if test="${empty user}"><fieldset disabled></c:if> 
<!-- empty user: 유저 세션이 없을 경우, not empty user: 유저 세션이 있을 경우 -->
<textarea id="comment" class="form-control" rows="3" placeholder="${empty user ? '':'コメント入力…'}"><c:if test="${empty user}">コメントはサインインした後で入力できます。</c:if></textarea>
<!-- {[조건문] ? [참일 때]:[거짓일 때]} -->
<input name="pno" type="hidden" id="pno" value="${map.pno}"/>
<input name="uno" type="hidden" id="uno" value="${user.uno}"/>
<!-- 요청에 들어갈 데이터를 hidden으로 정해 놓음 -->
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
        <!-- 댓글 리스트가 들어갈 자리 -->
    </tbody>
</table>
...
```

- `user`는 로그인을 할 때 받은 세션 객체입니다. 객체에는 회원번호가 저장되어 있습니다. (딴 거도 있지만 여기에선 관계 없습니다.)

- 아래는 위의 JSP에서 호출한 `commentlist.js`의 내용입니다. 

```js
$(function(){
	$.get("comment.do", { pno: $("#pno").val() }, function(data){ loadComment(data); });
	// jQuery에서 $(function(){})은 $(document).ready(function(){})의 줄임말입니다.
	// 즉 document 객체에 해당하는 웹페이지 자체가 로딩이 되었을 때 실행되는 스크립트를 담고 있는 겁니다.
	// GET 요청을 comment.do에 넣습니다.
	// loadComment(data) 함수는 아래에 기술되어 있습니다.
	
	$("#commentbtn").on("click", function(){
		// 댓글쓰기 버튼을 눌렀을 때 호출되는 부분
		if($("#comment").val() == "") {
			$("#commentbtn").addClass("btn-danger");
			$("#commentmsg").text("内容がないため作成できません。");
			// 댓글창이 비어 있으면 경고 메시지 출력
		} else {
			$("#commentbtn").removeClass("btn-danger");
			$("#commentmsg").text("");
			// 댓글에 내용이 있으면 경고 메시지 지움
			$.ajax({
				type:"post", // Comment.java에서 doPost() 메서드를 호출
				url:"comment.do", // Comment.java를 매핑하는 URL 패턴
				dataType:"json", // 받아오는 데이터 타입
				data: {
					uno: $("#uno").val(),
					pno: $("#pno").val(),
					content: $("#comment").val()
				}, // 데이터베이스에 넣을 내용을 객체 형태로 전달
				success: function(data){ // 여기서 말하는 data는 POST 요청이 성공했을 때 돌아오는 데이터를 말합니다.
					$("#comment").val(''); // 댓글 입력창 비우기
					loadComment(data); // loadComment(data) 함수는 아래에 기술되어 있습니다.
				}
			});
		}
	});
	
	function loadComment(data) { // 데이터베이스에서 댓글 리스트가 돌아왔을 경우의 함수
		$("#commentlist").empty(); // 이미 있는 태그 ID에다가 내용을 새로 달아두는 식이기 때문에 일단은 댓글창 영역을 비웁니다.
		for(let i = 0; i < data.length; i++) { // 받아온 JSON 객체 리스트의 길이만큼 반복
			$("#commentlist").append("<tr><td>" + data[i].content + "</tr></td>");
			// 리스트 안에 있는 JSON 객체의 내용을 해당 ID를 가진 태그에 삽입
			// 아래쪽에 더 넣을 수 있으나 일단은 댓글 리스트가 뜨는지 정도만 파악
		}
	}
	
	$("#commentbtn").blur(function(){ // 댓글 전송 버튼에서 포커스가 나갔을 경우 경고 메시지를 지움
		$("#commentbtn").removeClass("btn-danger");
		$("#commentmsg").text("");
	})
})
```

- 그리고 `commentlist.js`가 호출하는 `/comment.do -> Comment.java`의 일부입니다.

```java
...
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
```

- GSON은 Java 8과 호환되는 2.8.2 버전을 사용했습니다. [**이 링크**](https://repo1.maven.org/maven2/com/google/code/gson/gson/2.8.2/gson-2.8.2.jar)를 클릭하면 바로 다운로드됩니다.
- DAO 부분은 평범하게 JOIN을 활용한 쿼리 메서드가 되겠습니다. 도움이 되었으면 좋겠습니다.