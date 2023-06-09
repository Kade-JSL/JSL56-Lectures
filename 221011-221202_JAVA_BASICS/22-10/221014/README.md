# 이날 배웠던 것

- `ALTER TABLE`문, `SELECT`문, `WHERE`문을 배웠습니다.
- 배운 내용을 이용해 예제 테이블을 만들어 보았습니다.

---

## 어제 배웠던 것에서 연결하기

- **데이터 정의어**(DDL; Data Definition Language): 스키마 객체 생성, 변경, 제거 역할
- **데이터 조작어**(DML; Data Manipulation Language): 데이터에 대한 삽입 및 갱신, 삭제 등의 역할(M은 Management라고 선생님은 말씀하심)
    - 보통 이것을 Query문이라 한다.
- **데이터 제어어**(DCL; Data Control Language): 데이터 보안, 무결성 유지, 데이터 회복, 병행 수행 제어 등의 역할

---

## 검색으로 하루를 시작

- `오라클 테이블 컬럼 수정`으로 구글 검색
- [https://jwklife.tistory.com/5](https://jwklife.tistory.com/5)로 들어가도록 한다.
    - 이하의 내용이 그 블로그에서 퍼온 내용 되겠다.

## ALTER TABLE문

- 테이블에 컬럼 추가하기
    ```sql
    ALTER TABLE [테이블 이름] ADD([컬럼 이름] [컬럼 자료형]);
    ```
- 테이블의 컬럼 수정하기
    ```sql
    ALTER TABLE [테이블 이름] MODIFY([컬럼 이름] [컬럼 자료형]);
    ```
- 테이블의 컬럼 삭제하기
    ```sql
    ALTER TABLE [테이블 이름] DROP COLUMN [컬럼 이름];
    ```
- 컬럼 이름 수정하기
    ```sql
    ALTER TABLE [테이블 이름] RENAME COLUMN [원래 컬럼 이름] TO [수정 컬럼 이름];
    ```

## WHERE문

- `SELECT`문을 사용하나 특정 조건을 만족하는 레코드만 검색하고 싶을 때
    ```sql
    SELECT * FROM [테이블 이름] WHERE [컬럼 이름과 관련된 논리 식]
    ```
    - 예컨대 `kor` 컬럼의 값이 90 이상인 레코드를 표시하고 싶다면 부등호를 이용하여 조건을 표시한다.
        ```sql
        SELECT * FROM test WHERE kor>=80;
        ```

### LIKE문

(출처: [https://gent.tistory.com/401](https://gent.tistory.com/401))
- 일반적인 문법
    ```sql
    SELECT [컬럼 이름],... FROM [테이블 이름] WHERE [컬럼 이름] LIKE [관계성 연산자];
    ```
- 구체적인 문법
    - `%`는 와일드카드 문자로서 임의의 길이의 임의의 문자를 말한다. 즉 `%A%M%`라 하면 앞에 임의의 길이의 아무 문자들 다음에 `A`가 나온 다음, 또 다시 임의의 길이의 문자들이 있고, 그 다음에 `M`, 그리고 임의의 문자들이 나온다는 뜻이다.
    ```sql
        SQL> SELECT * FROM test WHERE name LIKE 'a%'

               BNO NAME                            KOR        ENG        MAT        TOT
        ---------- ------------------------ ---------- ---------- ---------- ----------
               AVG
        ----------
                 1 ariel                           100        100        100

    ```
    - `LOWER()`문은 괄호 안에 넣은 컬럼의 데이터를 전부 소문자로 생각한다는 뜻이다.

### IS (NOT) NULL

- 컬럼에서 `NULL`인 레코드가 있는지 없는지를 가지고 검색 조건에 넣게 된다.
    ```sql
    WHERE [컬럼명] IS NULL
    WHERE [컬럼명] IS NOT NULL
    ```

### 논리 연산자

- `WHERE`에서는 `AND`, `OR`, `NOT`과 같은 논리 연산자를 써서 검색을 하는 것도 가능하다.
    ```sql
    SQL> SELECT * FROM test WHERE kor=100 OR eng=100 OR mat=100;   
    
           BNO NAME                            KOR        ENG        MAT        TOT
    ---------- ------------------------ ---------- ---------- ---------- ----------
           AVG
    ----------
             1 ariel                           100        100        100


             4 dan                             100         90         70


    ```

## 연습 문제

- `***REMOVED***` 계정에 `notice` 테이블을 하나 만들어 보기로 한다.
    - 이 테이블의 역할은 한 사이트의 공지사항 게시판의 DB 역할이다.
    - JSL인재개발원 홈페이지를 기준으로 설계를 해 보자면...

    | | 번호 | 제목 | 이름 | 날짜 | 조회수 | 추천수 |
    |---|---|---|---|---|---|---|
    | 컬럼 | `bno` | `title` | `name` | `regdate` | `readcount` | `likecount` |
    | 자료형 |  `NUMBER` | `VARCHAR2` | `VARCHAR2` | `DATE` | `NUMBER` | `NUMBER` |
    | 데이터 크기 | 4 | 200 | 12 | - | - | - |
    | NULL? | `NOT NULL` | `NOT NULL` | `NOT NULL ` | | | |

    - 이 설계에 맞는 쿼리는 다음과 같다.

    ```sql
    CREATE TABLE notice (
    bno NUMBER(4) NOT NULL,
    title VARCHAR2(200) NOT NULL,
    name VARCHAR2(12) NOT NULL,
    regdate DATE,
    readcount NUMBER DEFAULT 0,
    likecount NUMBER DEFAULT 0
    );
    ```
    - 쿼리를 쓸 때의 주의사항:
        - 컬럼 정의 마지막에는 `,`를 쓰지 않음에 주의
        - 일부 컬럼 이름들은 특수한 명령어이기 때문에 사용할 수 없음에 주의
    - `NUMBER` 자료형의 경우 길이를 특정하지 않으면 기본적인 길이(22바이트)로 들어간다.
    - 테이블에 레코드 하나를 추가해 본다.
    - `SELECT`문을 이용해 추가한 레코드를 확인한다.

## 뱀발 - SQL*Plus에서 데이터가 이쁘게 나오지 않을 때

- SQL*Plus CLI에서는 한 줄에 몇 바이트 폭까지 표시할지를 정하는 `LINESIZE`라는 옵션이 있습니다.
- `SHOW LINESIZE` 명령어를 이용하면 이 표시 바이트 수(col이라 불립니다만, DB 용어인 컬럼과 혼동되어서 이렇게 썼습니다)가 나옵니다. 기본값은 저한텐 `80`이었습니다.
- `SET LINESIZE` 명령어로 한 줄에 표시할 바이트 수를 바꿀 수 있습니다.
- 또 `COL [컬럼 이름] FORMAT A30` 명령어로 한 컬럼의 표시 폭을 변경할 수도 있습니다.

    ```sql
    SET LINESIZE 200
    COL title FORMAT A30
    COL name FORMAT A10
    ```

- 연습문제에서 만든 테이블에 위와 같이 설정을 진행하고 다시 `SELECT`를 실행하면 다음과 같이 예쁘게 선택결과를 볼 수 있습니다.

    ```sql
    SQL> SELECT * FROM notice;

           BNO TITLE                          NAME       REGDATE  READCOUNT  LIKECOUNT
    ---------- ------------------------------ ---------- -------- ---------- ----------
             1 It's Morbin' time!             Michael    22/10/14          0         0
             2 I'm not an imposter            Red        22/10/14          0         0
             3 DING DING DING DING DING       Blue       22/10/14          0         0
             4 頑張りましょう！               如月千早   22/10/14          0         0
             5 저 좀 쩌는듯                   ㅇㅇ       22/10/14          0         0
    ```

- ...아래쪽에 약간 줄이 밀린 건 폰트 탓으로 합시다. 할튼 컬럼 제목들이 한 줄에 깔끔하게 나온다 그 말입니다.
- 지금으로써는 `COMMIT` 문으로는 SQL*Plus 터미널에서의 표시 설정을 바꿀 수 없는 것처럼 보입니다. 그냥 그때그때 불편하면 바꿔 줍시다.
- 이렇게 하기엔 불편하기 짝이 없으니 다음 시간부터는 뭔가 더 편한 걸 쓴댑니다.
