﻿INSERT INTO "***REMOVED***"."TBL_DEPT" (
    SYEAR, SCLASS, TNAME
) VALUES (
    '1', '01', '김교사'
);
INSERT INTO "***REMOVED***"."TBL_DEPT" (
    SYEAR, SCLASS, TNAME
) VALUES (
    '1', '02', '이교사'
);
INSERT INTO "***REMOVED***"."TBL_DEPT" (
    SYEAR, SCLASS, TNAME
) VALUES (
    '1', '03', '박교사'
);

COMMIT;

SELECT * FROM TBL_DEPT ORDER BY SCLASS;