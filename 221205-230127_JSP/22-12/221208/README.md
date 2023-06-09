﻿#
### [221207 ←](/../221205-230127_JSP/22-12/221207/) | [→ 221209](/../221205-230127_JSP/22-12/221209/)

# 이날 배웠던 것: 산업기사 모의 시험(오디션 관리)

- [/src/model/](/../221205-230127_JSP/22-12/221208/jspstudy56/cbq_02/src/model/)
    - [**Dao.java**: 데이터베이스 접근 객체](/../221205-230127_JSP/22-12/221208/jspstudy56/cbq_02/src/model/Dao.java)
    - [DBConn.java: 데이터베이스 접속 객체](/../221205-230127_JSP/22-12/221208/jspstudy56/cbq_02/src/model/DBConn.java)
    - [**Dto.java**: 데이터베이스 전송 객체](/../221205-230127_JSP/22-12/221208/jspstudy56/cbq_02/src/model/Dto.java)
- [/WebContent/](/../221205-230127_JSP/22-12/221208/jspstudy56/cbq_02/WebContent/)
    - [WEB-INF/lib/ojdbc.jar: 오라클 DB XE thin(자바) 드라이버](/../221205-230127_JSP/22-12/221208/jspstudy56/cbq_02/WebContent/WEB-INF/lib/ojdbc6.jar)
    - [index.jsp: 메인 메뉴, 스타일시트 결정](/../221205-230127_JSP/22-12/221208/jspstudy56/cbq_02/WebContent/index.jsp)
    - [**create-artist.jsp**: 흔히 sub1이라 부르는 페이지. 오디션 참가자를 `<form>` 태그로 받음](/../221205-230127_JSP/22-12/221208/jspstudy56/cbq_02/WebContent/create-artist.jsp)
        - [**cr1-action.jsp**: sub1pro에 해당. `<form>`에 저장된 데이터를 `request` 객체로 자바 DTO에 저장](/../221205-230127_JSP/22-12/221208/jspstudy56/cbq_02/WebContent/cr1-action.jsp)
    - [**read-artist.jsp**: sub2에 해당. DAO 메서드로 데이터를 쿼리하여 DTO 배열로 그것을 받아 화면에 출력](/../221205-230127_JSP/22-12/221208/jspstudy56/cbq_02/WebContent/read-artist.jsp)
    - [**read-mentor.jsp**: sub3. 호출하는 DAO 메서드의 쿼리문이 `JOIN`을 포함하는 것을 제외하면 모든 작업이 동일함](/../221205-230127_JSP/22-12/221208/jspstudy56/cbq_02/WebContent/read-mentor.jsp)
    - [**read-rank.jsp**: sub4. 약간 더 심화된 `JOIN` 쿼리를 사용](/../221205-230127_JSP/22-12/221208/jspstudy56/cbq_02/WebContent/read-rank.jsp)
- [**tbl_artist_201905.sql**: 과제 테이블을 만들고 DAO 메서드의 쿼리문을 테스트했던 PL/SQL 문서](/../221205-230127_JSP/22-12/221208/tbl_artist_201905.sql)