## [230405 ←](/230130-_Spring/230405/) | [→ 230410](/230130-_Spring/230410/)

## MyBatis 동적 SQL

- 조건에 맞게 SQL을 조정할 수 있다
- `if`, `choose`(`when`,`otherwise`)
    - JSTL의 core 태그와 같다.
- `trim`(`where`, `set`)
- `foreach`

    ```xml
    <if test="target == 'T'.toString()">
        title LIKE '%'||#{keyword}||'%'
    </if>
    <if test="target == 'C'.toString()">
        content LIKE '%'||#{keyword}||'%'
    </if>
    <if test="target == 'TC'.toString()">
        title LIKE '%'||#{keyword}||'%' OR content LIKE '%'||#{keyword}||'%'
    </if>
    <if test="target == 'U'.toString()">
        uname LIKE '%'||#{keyword}||'%'
    </if>
    ```

- 위와 같이 구현할 수 있다.

    ```xml
    <choose>
        <when test="target == 'T'.toString()">
            title LIKE '%'||#{keyword}||'%'
        </when>
        <when test="target == 'C'.toString()">
            content LIKE '%'||#{keyword}||'%'
        </when>
        <when test="target == 'U'.toString()">
            uname LIKE '%'||#{keyword}||'%'
        </when>
        <otherwise>
            title LIKE '%'||#{keyword}||'%' OR content LIKE '%'||#{keyword}||'%'
        </otherwise>
    </choose>
    ```

- choose 태그는 JSTL처럼 한 가지 경우만 선택되어 실행된다.

- 아래의 조건을 만족하는 쿼리를 만드려고 한다면, MyBatis를 이용해 이 두 개의 쿼리를 동시에 처리할 수 있는 메서드를 만들 수 있다.

    ```sql
    SELECT * FROM pieces
    SELECT * FROM pieces WHERE pno = 10
    ```

- 그렇다면 아래와 같이 코딩하면 된다.

    ```xml
    SELECT * FROM pieces
    <where>
        <if test="pno != null">
            pno = #{pno}
        </if>
    </where>
    ```

- if가 많아지면 일일이 where 쓰는 게 귀찮으니 태그로 만드는 편이 나을 것이다.
- 그럼 이런 문장은 어떨까?
    - 조건
        1. `pno` 값이 존재할 경우 `SELECT * FROM pieces WHERE pno = 10 and ROWNUM = 1`
        1. `pno` 값이 `null`일 경우 `SELECT * FROM pieces WHERE ROWNUM = 1`

    ```xml
    SELECT * FROM pieces
    <where>
        <if test="pno != null">
            pno = #{pno}
        </if>
        <trim prefixOverrides="AND">
            ROWNUM = 1
        </trim>
    </where>
    ```