﻿SELECT * FROM (
    SELECT /*+ INDEX_DESC (NOTICE NOTICE_PK) */ 
        ROWNUM RN, BNO, TITLE, CONTENT, WRITER, REGDATE, VIEWCOUNT
    FROM
        NOTICE
    WHERE
        TITLE LIKE '%냥%' OR CONTENT LIKE '%냥%' AND ROWNUM <= 10)
WHERE RN > 0;

SELECT
    *
FROM
    NOTICE
WHERE
    TITLE
    LIKE '%%';

CREATE TABLE QA (
    BNO NUMBER NOT NULL,
    TITLE VARCHAR2(200) NOT NULL,
    CONTENT VARCHAR2(4000) NOT NULL,
    STATUS CHAR(1) DEFAULT 'n',
    REGDATE DATE DEFAULT SYSDATE,
    WRITER VARCHAR2(20) NOT NULL,
    VIEWCOUNT NUMBER DEFAULT 0,
    CONSTRAINT QA_PK PRIMARY KEY (BNO)
);

CREATE TABLE QAREPLY (
    RNO NUMBER NOT NULL,
    BNO NUMBER NOT NULL,
    CONTENT VARCHAR2(4000),
    CONSTRAINT QAREPLY_FK FOREIGN KEY (BNO) REFERENCES QA(BNO)
);

CREATE SEQUENCE QA_SEQ;
CREATE SEQUENCE QAREPLY_SEQ;

INSERT INTO QA (BNO, TITLE, CONTENT, WRITER) VALUES (QA_SEQ.NEXTVAL, '질문입니다', '질문내용입니다', '홍길동');
INSERT INTO QA (BNO, TITLE, CONTENT, WRITER) VALUES (QA_SEQ.NEXTVAL, '질문2입니다', '질문내용2입니다', '이순신');

INSERT INTO QAREPLY VALUES (QAREPLY_SEQ.NEXTVAL, 1, '답변입니다');

COMMIT;

SELECT
    A.BNO,
    A.TITLE,
    A.WRITER,
    A.REGDATE,
    A.VIEWCOUNT,
    A.CONTENT,
    B.CONTENT
FROM
    QA A
    LEFT JOIN QAREPLY B
    ON A.BNO = B.BNO
ORDER BY
    A.BNO DESC;