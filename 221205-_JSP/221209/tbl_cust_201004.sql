﻿CREATE TABLE TBL_CUST_201004 (
    P_NO CHAR(4) NOT NULL PRIMARY KEY,
    P_NAME VARCHAR2(20),
    P_BIRTH CHAR(8),
    P_GENDER CHAR(1),
    P_TEL1 CHAR(3),
    P_TEL2 CHAR(4),
    P_TEL3 CHAR(4),
    P_CITY CHAR(2)
);

INSERT INTO TBL_CUST_201004 VALUES (
    '1001',
    '김고객',
    '19850301',
    'M',
    '010',
    '2222',
    '0001',
    10
);

INSERT INTO TBL_CUST_201004 VALUES (
    '1002',
    '이고객',
    '19900301',
    'M',
    '010',
    '2222',
    '0002',
    20
);

INSERT INTO TBL_CUST_201004 VALUES (
    '1003',
    '박고객',
    '19770301',
    'F',
    '010',
    '2222',
    '0003',
    30
);

INSERT INTO TBL_CUST_201004 VALUES (
    '1004',
    '조고객',
    '19650301',
    'F',
    '010',
    '2222',
    '0004',
    10
);

INSERT INTO TBL_CUST_201004 VALUES (
    '1005',
    '황고객',
    '19400301',
    'M',
    '010',
    '2222',
    '0005',
    40
);

INSERT INTO TBL_CUST_201004 VALUES (
    '1006',
    '양고객',
    '19440301',
    'M',
    '010',
    '2222',
    '0006',
    40
);

INSERT INTO TBL_CUST_201004 VALUES (
    '1007',
    '허고객',
    '19760301',
    'F',
    '010',
    '2222',
    '0007',
    10
);

CREATE TABLE TBL_ORDER_201004 (
    P_SENO NUMBER(8) NOT NULL,
    P_NO CHAR(4),
    I_CODE CHAR(4),
    P_DATE DATE,
    CONSTRAINT ORDER_FK FOREIGN KEY (P_NO) REFERENCES TBL_CUST_201004(P_NO),
    CONSTRAINT ORDER_PK PRIMARY KEY (P_SENO)
);

INSERT INTO TBL_ORDER_201004 VALUES (
    20200001,
    '1001',
    'A001',
    TO_DATE('20200101', 'YYYYMMDD')
);

INSERT INTO TBL_ORDER_201004 VALUES (
    20200002,
    '1002',
    'A001',
    TO_DATE('20200102', 'YYYYMMDD')
);

INSERT INTO TBL_ORDER_201004 VALUES (
    20200003,
    '1003',
    'A001',
    TO_DATE('20200103', 'YYYYMMDD')
);

INSERT INTO TBL_ORDER_201004 VALUES (
    20200004,
    '1004',
    'A001',
    TO_DATE('20200104', 'YYYYMMDD')
);

INSERT INTO TBL_ORDER_201004 VALUES (
    20200005,
    '1005',
    'A002',
    TO_DATE('20200105', 'YYYYMMDD')
);

INSERT INTO TBL_ORDER_201004 VALUES (
    20200006,
    '1006',
    'A003',
    TO_DATE('20200106', 'YYYYMMDD')
);

INSERT INTO TBL_ORDER_201004 VALUES (
    20200007,
    '1007',
    'A001',
    TO_DATE('20200107', 'YYYYMMDD')
);

INSERT INTO TBL_ORDER_201004 VALUES (
    20200008,
    '1005',
    'A003',
    TO_DATE('20200108', 'YYYYMMDD')
);

INSERT INTO TBL_ORDER_201004 VALUES (
    20200009,
    '1006',
    'A003',
    TO_DATE('20200109', 'YYYYMMDD')
);

INSERT INTO TBL_ORDER_201004 VALUES (
    20200010,
    '1006',
    'A004',
    TO_DATE('20200110', 'YYYYMMDD')
);

INSERT INTO TBL_ORDER_201004 VALUES (
    20200011,
    '1001',
    'A001',
    TO_DATE('20200111', 'YYYYMMDD')
);

SELECT
    *
FROM
    TBL_ORDER_201004;

CREATE TABLE TBL_INJECTION_201004 (
    I_CODE CHAR(4) NOT NULL PRIMARY KEY,
    I_NAME VARCHAR2(20),
    I_AGE VARCHAR2(20)
);

INSERT INTO TBL_INJECTION_201004 VALUES (
    'A001',
    'A형간염',
    '19~39세'
);

INSERT INTO TBL_INJECTION_201004 VALUES (
    'A002',
    'TD백신',
    '40~49세'
);

INSERT INTO TBL_INJECTION_201004 VALUES (
    'A003',
    '인플루엔자',
    '50~64세'
);

INSERT INTO TBL_INJECTION_201004 VALUES (
    'A004',
    '폐렴사슬알균',
    '65세이상'
);

SELECT
    A.P_SENO,
    A.P_NO,
    B.P_NAME,
    A.I_CODE,
    C.I_NAME,
    TO_CHAR(A.P_DATE,
    'YYYY-MM-DD')
FROM
    TBL_ORDER_201004     A
    INNER JOIN TBL_CUST_201004 B
    ON A.P_NO = B.P_NO
    INNER JOIN TBL_INJECTION_201004 C
    ON A.I_CODE = C.I_CODE
ORDER BY
    A.P_NO,
    A.I_CODE;

SELECT
    A.I_CODE,
    C.I_NAME,
    COUNT(A.I_CODE) AS CNT
FROM
    TBL_ORDER_201004     A
    INNER JOIN TBL_INJECTION_201004 C
    ON A.I_CODE = C.I_CODE
GROUP BY
    A.I_CODE,
    C.I_NAME
ORDER BY
    A.I_CODE;