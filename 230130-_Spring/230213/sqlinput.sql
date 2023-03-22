﻿CREATE VIEW BOOK_VW AS
    SELECT
        *
    FROM
        BOOK
    WHERE
        BOOKNAME LIKE '%축구%';

SELECT
    *
FROM
    BOOK_VW;

CREATE VIEW ORDERS_VW(
    ORDERID,
    CUSTID,
    NAME,
    BOOKID,
    BOOKNAME,
    SALEPRICE,
    ORDERDATE
) AS
    SELECT
        OD.ORDERID,
        OD.CUSTID,
        CS.NAME,
        OD.BOOKID,
        BK.BOOKNAME,
        OD.SALEPRICE,
        OD.ORDERDATE
    FROM
        ORDERS   OD,
        CUSTOMER CS,
        BOOK     BK
    WHERE
        OD.CUSTID = CS.CUSTID
        AND OD.BOOKID = BK.BOOKID;

SELECT
    *
FROM
    ORDERS_VW;

CREATE VIEW CUSTOMER_VW AS
    SELECT
        *
    FROM
        CUSTOMER
    WHERE
        ADDRESS LIKE '%대한민국%';

CREATE OR REPLACE VIEW CUSTOMER_VW (
    CUSTID,
    NAME,
    ADDRESS
) AS
    SELECT
        CUSTID,
        NAME,
        ADDRESS
    FROM
        CUSTOMER
    WHERE
        ADDRESS LIKE '%영국%';

SELECT
    *
FROM
    CUSTOMER_VW;

CREATE INDEX BOOK_IDX ON BOOK(BOOKNAME);
CREATE INDEX BOOK_IDX2 ON BOOK(PUBLISHER, PRICE);
DROP INDEX BOOK_IDX;
ALTER INDEX BOOK_IDX2 REBUILD;
DROP INDEX BOOK_IDX2;
