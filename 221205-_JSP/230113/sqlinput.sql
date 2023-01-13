﻿SELECT * FROM USER_TABLES;
SELECT * FROM TAB;
SELECT * FROM ALL_TABLES;
SELECT * FROM USER_CONSTRAINTS;

SELECT * FROM BOOK;
SELECT BOOKNAME, PRICE FROM BOOK;
SELECT DISTINCT PUBLISHER FROM BOOK;
SELECT * FROM BOOK WHERE PRICE < 20000;
SELECT * FROM BOOK WHERE PRICE >= 10000 AND PRICE <= 20000;
SELECT * FROM BOOK WHERE PRICE BETWEEN 10000 AND 20000;
SELECT * FROM BOOK WHERE PUBLISHER = '대한미디어' OR PUBLISHER = '굿스포츠';
SELECT * FROM BOOK WHERE PUBLISHER IN ('대한미디어', '굿스포츠');
SELECT * FROM BOOK WHERE PUBLISHER NOT IN ('대한미디어', '굿스포츠');
SELECT * FROM BOOK WHERE BOOKNAME LIKE '축구의 역사';
SELECT * FROM BOOK WHERE BOOKNAME LIKE '%축구%'; --  글자 길이 관계없이 포함
SELECT * FROM BOOK WHERE BOOKNAME LIKE '_구%'; -- 언더바의 갯수만큼 글자를 포함
SELECT * FROM BOOK WHERE BOOKNAME LIKE '%축구%' AND PRICE >= 20000;
SELECT * FROM BOOK ORDER BY BOOKNAME;
SELECT * FROM BOOK ORDER BY PRICE DESC, BOOKNAME;