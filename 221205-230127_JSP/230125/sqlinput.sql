CREATE TABLE NEWORDERS AS SELECT * FROM ORDERS;

SELECT * FROM NEWORDERS;

-- 내장 함수

SELECT ABS(-84), ABS(-78) FROM DUAL;
-- DUAL: 오라클에서 일시적인 연산 작업에 사용하기 위해 만든 가상 테이블
SELECT ROUND(4.5678, 1) FROM DUAL;

-- 고객별 평균 주문 금액을 백원 단위로 반올림한 값을 구하시오
SELECT CUSTID, ROUND(SUM(SALEPRICE) / COUNT(*), -2) FROM ORDERS GROUP BY CUSTID ORDER BY CUSTID;

-- 도서 제목에 '야구'가 포함된 도서를 '농구'로 변경한 다음 도서목록을 보이시오
SELECT BOOKID, REPLACE(BOOKNAME, '야구', '농구') BOOKNAME FROM BOOK;

-- 글자의 수
SELECT BOOKNAME "제목", LENGTH(BOOKNAME) "글자수", LENGTHB(BOOKNAME) "바이트수" FROM BOOK;

-- 고객 중에서 같은 성을 가진 사람이 몇 명이나 되는지 성별 인원 수를 보이시오
SELECT SUBSTR(NAME, 1, 1) "성", COUNT(*) "인원" FROM CUSTOMER GROUP BY SUBSTR(NAME, 1, 1);
