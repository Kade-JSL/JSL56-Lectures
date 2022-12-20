﻿CREATE TABLE FAQ1 (
    BNO NUMBER,
    TITLE VARCHAR2(200) NOT NULL,
    CONSTRAINT PK_FAQ1 PRIMARY KEY (BNO)
);

CREATE TABLE FAQ2 (
    BNO NUMBER,
    QNO NUMBER NOT NULL,
    CONTENT VARCHAR2(4000),
    CONSTRAINT PK_FAQ2 PRIMARY KEY (BNO),
    CONSTRAINT FK_FAQ2 FOREIGN KEY (QNO) REFERENCES FAQ1(BNO)
);

CREATE SEQUENCE FAQ1_SEQ;

CREATE SEQUENCE FAQ2_SEQ;

INSERT INTO FAQ1 VALUES (FAQ1_SEQ.NEXTVAL, '질문2입니다');

SELECT * FROM FAQ1;

INSERT INTO FAQ2 VALUES (FAQ2_SEQ.NEXTVAL, 2, '질문2에대한답변입니다');
SELECT * FROM FAQ2;

SELECT
    A.BNO,
    A.TITLE,
    B.CONTENT
FROM
    FAQ1 A
    LEFT JOIN FAQ2 B
    ON A.BNO = B.QNO
ORDER BY
    A.BNO DESC;

SELECT
    A.BNO,
    A.TITLE,
    B.CONTENT
FROM
    FAQ1 A,
    FAQ2 B
WHERE
    A.BNO = B.QNO(+)
ORDER BY
    A.BNO;

COMMIT;