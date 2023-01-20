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