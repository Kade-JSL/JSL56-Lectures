﻿CREATE TABLE TBL_GOODS (
    PCODE CHAR(4) NOT NULL,
    PNAME VARCHAR(2) NOT NULL,
    PCOST NUMBER(8) NOT NULL,
    STOCK NUMBER(8),
    PRIMARY KEY (PCODE) -- 이렇게 해도 됨!
);

ALTER TABLE TBL_GOODS MODIFY (PNAME VARCHAR(20));

INSERT INTO TBL_GOODS VALUES (
    'A001',
    '마우스',
    5000,
    150
);

INSERT INTO TBL_GOODS VALUES (
    'A002',
    '키보드',
    12000,
    50
);

INSERT INTO TBL_GOODS VALUES (
    'A003',
    '모니터',
    150000,
    10
);

INSERT INTO TBL_GOODS VALUES (
    'A004',
    '프린터',
    180000,
    10
);

INSERT INTO TBL_GOODS VALUES (
    'A005',
    '메모리',
    27000,
    100
);

SELECT
    *
FROM
    TBL_GOODS;

/* 회원매출정보 명세서 테이블 */
CREATE TABLE TBL_MONEY (
    CUSTNO NUMBER(6) NOT NULL, -- 회원번호
    SALENO NUMBER(8) NOT NULL, -- 판매번호
    PCODE CHAR(4), -- 상품코드
    AMOUNT NUMBER(4), -- 수량
    SDATE CHAR(8), -- 판매일자
    CONSTRAINT FK_PCODE FOREIGN KEY (PCODE) REFERENCES TBL_GOODS(PCODE)
 -- 제약조건 FK_PCODE(임의의 이름): 반드시 외부 키인 TBL_GOODS 테이블의 PCODE 컬럼을 참조해야 한다
);

INSERT INTO TBL_MONEY VALUES (
    100001,
    20160001,
    'A001',
    5,
    '20160101'
);

SELECT
    *
FROM
    TBL_MONEY;

INSERT INTO TBL_MONEY VALUES (
    100001,
    20160002,
    'A002',
    4,
    '20160101'
);

INSERT INTO TBL_MONEY VALUES (
    100001,
    20160003,
    'A005',
    3,
    '20160101'
);

INSERT INTO TBL_MONEY VALUES (
    100002,
    20160004,
    'A004',
    1,
    '20160102'
);

INSERT INTO TBL_MONEY VALUES (
    100002,
    20160005,
    'A001',
    1,
    '20160103'
);

INSERT INTO TBL_MONEY VALUES (
    100003,
    20160006,
    'A003',
    2,
    '20160103'
);

INSERT INTO TBL_MONEY VALUES (
    100004,
    20160007,
    'A001',
    3,
    '20160104'
);

INSERT INTO TBL_MONEY VALUES (
    100004,
    20160008,
    'A005',
    1,
    '20160104'
);

INSERT INTO TBL_MONEY VALUES (
    100004,
    20160009,
    'A002',
    1,
    '20160104'
);

INSERT INTO TBL_MONEY VALUES (
    100004,
    20160010,
    'A005',
    1,
    '20160101'
);

COMMIT;

DROP TABLE TBL_MONEY;

SELECT
    MO.SALENO,
    ME.CUSTNAME,
    MO.SDATE,
    GO.PNAME,
    MO.AMOUNT,
    GO.PCOST,
    MO.AMOUNT * GO.PCOST AS TOT
FROM
    TBL_MEMBER ME,
    TBL_MONEY  MO,
    TBL_GOODS  GO
WHERE
    MO.CUSTNO = ME.CUSTNO
    AND MO.PCODE = GO.PCODE;

SELECT
    MO.SALENO,
    ME.CUSTNAME,
    MO.SDATE,
    GO.PNAME,
    MO.AMOUNT,
    GO.PCOST,
    MO.AMOUNT * GO.PCOST AS TOT
FROM
    TBL_MEMBER ME
    INNER JOIN TBL_MONEY MO
    ON MO.CUSTNO = ME.CUSTNO
    INNER JOIN TBL_GOODS GO
    ON MO.PCODE = GO.PCODE;

/* Oracle 조인 */
SELECT
    A.CUSTNO,
    A.CUSTNAME,
    A.PHONE,
    A.GRADE,
    SUM(B.AMOUNT * C.PCOST) AS TOT
FROM
    TBL_MEMBER A,
    TBL_MONEY  B,
    TBL_GOODS  C
WHERE
    A.CUSTNO = B.CUSTNO
    AND B.PCODE = C.PCODE
GROUP BY
    A.CUSTNO,
    A.CUSTNAME,
    A.PHONE,
    A.GRADE
ORDER BY
    TOT DESC;

/* ANSI 조인 */
SELECT
    A.CUSTNO,
    A.CUSTNAME,
    A.PHONE,
    A.GRADE,
    SUM(B.AMOUNT * C.PCOST) AS TOT
FROM
    TBL_MEMBER A
    INNER JOIN TBL_MONEY B
    ON A.CUSTNO = B.CUSTNO
    INNER JOIN TBL_GOODS C
    ON B.PCODE = C.PCODE
GROUP BY
    A.CUSTNO,
    A.CUSTNAME,
    A.PHONE,
    A.GRADE
ORDER BY
    TOT DESC;