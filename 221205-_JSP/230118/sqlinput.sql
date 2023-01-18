SELECT
    *
FROM
    BOOK;

SELECT
    *
FROM
    CUSTOMER;

SELECT
    *
FROM
    ORDERS;

-- 고객과 고객의 주문에 관한 데이터를 모두 보이시오.

SELECT
    *
FROM
    CUSTOMER C
    INNER JOIN ORDERS O
    ON C.CUSTID = O.CUSTID;

-- 고객과 고객의 주문에 관한 데이터를 고객 번호 순으로 정렬하여 보이시오.

SELECT
    *
FROM
    CUSTOMER C
    INNER JOIN ORDERS O
    ON C.CUSTID = O.CUSTID
ORDER BY
    C.CUSTID;

-- 고객의 이름과 고객의 주문한 도서의 판매가격을 검색하시오

SELECT
    C.NAME,
    O.SALEPRICE
FROM
    CUSTOMER C
    INNER JOIN ORDERS O
    ON C.CUSTID = O.CUSTID;

-- 고객별로 주문한 모든 도서의 총 판매액을 구하고, 고객별로 정렬하시오

SELECT
    C.NAME,
    SUM(SALEPRICE) AS 총_판매액
FROM
    CUSTOMER C
    INNER JOIN ORDERS O
    ON C.CUSTID = O.CUSTID
GROUP BY
    C.NAME
ORDER BY
    C.NAME;

-- 부속 질의(서브쿼리)

-- 가격이 가장 비싼 도서의 이름을 검색하시오

SELECT
    BOOKNAME,
    PRICE
FROM
    BOOK
WHERE
    PRICE = (
        SELECT
            MAX(PRICE)
        FROM
            BOOK
    );

-- 도서를 구매한 적이 있는 고객의 이름을 검색하시오

SELECT
    *
FROM
    ORDERS;

SELECT
    *
FROM
    CUSTOMER;

SELECT
    NAME
FROM
    CUSTOMER
WHERE
    CUSTID IN (
        SELECT
            CUSTID
        FROM
            ORDERS
    );

-- 대한미디어에서 출판한 도서를 구매한 고객의 이름을 보이시오

SELECT
    NAME
FROM
    CUSTOMER
WHERE
    CUSTID IN (
        SELECT
            CUSTID
        FROM
            ORDERS
        WHERE
            BOOKID IN (
                SELECT
                    BOOKID
                FROM
                    BOOK
                WHERE
                    PUBLISHER = '대한미디어'
            )
    );

-- JOIN 문장으로 바꾸어 같은 쿼리를 실행해 보이시오

SELECT
    C.NAME
FROM
    CUSTOMER C
    INNER JOIN ORDERS O
    ON C.CUSTID = O.CUSTID
    INNER JOIN BOOK B
    ON B.BOOKID = O.BOOKID
WHERE
    B.PUBLISHER = '대한미디어';