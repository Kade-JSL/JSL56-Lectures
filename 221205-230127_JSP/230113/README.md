### [230112 ←](../../221205-230127_JSP/230112/) | [→ 230118](../../221205-230127_JSP/230118/)

# 이날 배웠던 것

- 몰?루

---

# 제6회내부평가시험과목<SQL활용>

## 데이터 사전(Data Dictionary)

- 사용 권한은 DBA가 가지고 있다.
- 메타데이터엔 다음과 같은 것이 있다.
    - 사용자 정보(ID, 비밀번호, 권한 등)
    - 데이터베이스 객체(테이블, 인덱스, 뷰 등)
    - 무결성 제약 상태
    - 함수, 프로시저 및 트리거 정보 등
- 오라클에선 뷰를 이용해 데이터 사전에 접근할 수 있는데, MVC 패턴에서 나오니까 그런 가상 테이블 같은 뭐시기라고 생각하면 된다.
- DBA_(데이터베이스 전부) > ALL_(자신의 접근 권한) > USER(계정이 소유한)
    - TABLES
    - TAB_COLUMNS
    - TAB_COMMENTS
    - CONSTRAINS

## DDL(Data Definition Language; 데이터 정의어)

- 스키마
    - DBMS의 특징과 구축 환경에 기반한 데이터 구조
    - 하나의 데이터베이스라고 이해할 수 있음
- 도메인
    - 속성의 데이터 타입과 제약조건 등을 설정한 정보
        - e.g. 주소를 VARCHAR(120)으로 설정
- 테이블
- 뷰
    - 1개 이상의 물리 테이블을 통해서 만드는 **가상의 논리 테이블**
- 인덱스
    - **빠른 검색**을 위한 데이터 구조
- CREATE, ALTER, DROP, TRUNCATE

## DML(Data Manipulation Language; 데이터 조작어)

- INSERT, SELECT, UPDATE, DELETE
- JOIN

## DCL(Data Control Language; 데이터 제어어)

- GRANT, REVOKE
- TCL을 DCL의 일부로 분류하기도 한다.
    - COMMIT, ROLLBACK, CHECKPOINT

