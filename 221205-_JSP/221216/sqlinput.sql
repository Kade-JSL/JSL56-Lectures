﻿SELECT * FROM NOTICE;
SELECT * FROM NOTICE WHERE BNO = 6;
SELECT CONTENT FROM NOTICE WHERE BNO = 6;

UPDATE NOTICE SET VIEWCOUNT = VIEWCOUNT + 1 WHERE BNO = 6;

SELECT * FROM NOTICE WHERE BNO = 13;
SELECT TITLE FROM NOTICE WHERE BNO = (SELECT MAX(BNO) FROM NOTICE WHERE BNO > 13);
SELECT TITLE FROM NOTICE WHERE BNO = (SELECT MAX(BNO) FROM NOTICE WHERE BNO < 13);