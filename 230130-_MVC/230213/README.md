### [230130 ←](/230130-_MVC/230130/)

# 제6회내부평가시험과목<SQL활용>

## 인덱스 관련 DDL

```sql
CREATE [UNIQUE] INDEX <index name> ON <table name> (<indexing columns>);
DROP INDEX <index name>;
ALTER [UNIQUE] INDEX <index name> ON <table name> (<indexing columns>);
```

## 뷰의 장점

- 논리적 독립성 제공
    - 뷰는 논리 테이블이기 때문에 테이블의 구조가 변경되더라도 뷰를 활용하는 응용프로그램을 계속 수정할 필요가 없어짐
- 사용자 데이터 관리 용이
    - 다수 테이블에 있는 다양한 데이터에 대해 단순한 쿼리로 활용 가능
- 데이터 보안 용이
    - 중요한 보안 데이터가 있는 테이블은 접근하지 못하도록 설정하고 접근이 가능한 일부 데이터만을 조회할 수 있도록 뷰를 생성한

## 뷰의 단점

- 인덱스 사용 불가
    - 논리 테이블인 뷰에는 인덱스를 만들 수 없음
- 뷰 구조 변경 불가
    - 뷰는 삭제 후 재생성을 통해서만 뷰의 구조 변경이 가능함
- 데이터 변경 제약 존재
    - 뷰로 조회된 데이터에 대한 삽입, 변경, 삭제 제약이 있음

## 뷰 관련 DDL

```sql
CREATE VIEW <view name> AS SELECT * FROM <table name> -- 테이블 그대로
CREATE VIEW <view name> AS SELECT <columns> FROM <table name> -- 일부 컬럼만
CREATE VIEW <view name> AS SELECT * FROM <tab1>, <tab2> WHERE tab1.col1 = tab2.col2; -- 조인 결과(아마도 ANSI 조인 가능)
DROP VIEW <view name> -- 뷰 삭제
/* 뷰의 구조는 변경 불가! */
```

