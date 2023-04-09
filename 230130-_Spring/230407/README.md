## [230405 ←](/230130-_Spring/230405/) | [→ 230410](/230130-_Spring/230410/)

## MyBatis 동적 SQL

- 조건에 맞게 SQL을 조정할 수 있다
- `if`, `choose`(`when`,`otherwise`)
    - JSTL의 core 태그와 같다.
- `trim`(`where`, `set`)
- `foreach`

## `<if>`

- 조건분기문. 특기할 점이라면 글자를 쓴 다음에 `toString()`을 해 줘야 한다는 거. 이유는 몰?루

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

## `<choose>` ~ `<when>`, `<otherwise>`

- 다중 조건분기문. JSTL의 core 태그와 완벽하게 동일한 기능을 한다.

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

## `<where>`

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

## `<trim>`

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

- 위와 같이 쓰면 된다. `trim`은 공백 제거를 하라는 뜻.
- 즉 앞의 조건문이 거짓이라면 `AND`를 붙이지 않고 `WHERE` 조건에 태그 안의 문장을 추가하라는 것.
- 그리고 앞의 조건문이 참이라면 `AND`를 붙이고 태그 안의 문장을 추가하게 될 것이다.
- 그러니까 `prefixOverrides`라는 게 무엇이냐 하면, 조건절의 참/거짓에 따라서 추가로 앞에(prefix는 접미사라는 뜻)붙이게 될 텍스트에 관한 속성인 것이다.
- 그럼 `suffixOverrides` 속성은 뒤에 붙이게 될 텍스트를 써 놓는 속성이란 걸 자동적으로 알 수 있다.

## `<foreach>`

- 이 쿼리를 보자.

    ```xml
    SELECT * FROM pieces
    <trim prefix="WHERE (" suffix=")" prefixOverrides="OR">
        <foreach item="val" index="key" collection="map">
            <if test="key == 'C'.toString()">
                content = #{val}
            </if>
            <if test="key == 'T'.toString()">
                title = #{val}
            </if>
        </foreach>
    </trim>
    ```

- 여기서 `map`이란 건 해당 쿼리 메서드에 인수로써 들어간 맵이란 뜻이다.

    ```java
    Map<String, String> map = new HashMap();
    map.put("T", "aaa");
    map.put("C", "bbb");
    ```

- 그렇다면 지정된 `map`에 `T`와 `C`인 key가 모두 존재할 경우 위의 XML은 다음과 같은 결과를 낳는다.

    ```sql
    SELECT * FROM pieces WHERE (content = #{val} OR title = #{val});
    ```

- MyBatis는 엄격한 자바 규칙을 따르지 않아서 그냥 get뭐뭐뭐라는 메서드만 있으면 그 뭐뭐뭐를 읽는다. 그래서 해당 검색 관련 메서드에서 `getTargetArr` 메서드를 호출할 수 있는 것.

## 머리 터진다

- HTML도 아닌데 태그셉션을 또 봐야 한다. 뭐 조건분기란 그런 것이리라.

    ```xml
    <trim prefixOverrides="OR">
		<foreach item="target" collection="targetArr">
			<trim prefix="OR">
				<choose>
					<when test="target == 'T'.toString()">
						p.title LIKE '%'||#{keyword}||'%'
					</when>
					<when test="target == 'C'.toString()">
						p.content LIKE '%'||#{keyword}||'%'
					</when>
					<when test="target == 'U'.toString()">
						u.uname = #{keyword}
					</when>
				</choose>
			</trim>
		</foreach>
	</trim>
    ```

1. `T`만 들어갔을 때
    - 안쪽 `<trim>`에서는 다음과 같은 문장이 생성된다.
        - `OR p.title LIKE '%||#{keyword}||%'`
    - 바깥쪽 `<trim>`에서 맨 앞 글자(prefix)가 `OR`일 경우 지우기로(Overrides) 했기 때문에, 결국 남는 문장은 다음과 같다.
        - `p.title LIKE '%||#{keyword}||%'`
1. `C`만 들어갔을 때
    - 똑같은 로직으로 `p.content LIKE '%||#{keyword}||%'`만 남을 것이다.
1. `T`와 `C`가 들어갔을 때
    - 안쪽 `<trim>`: `OR p.title LIKE '%||#{keyword}||%' OR p.content LIKE '%||#{keyword}||%'`
    - 바깥쪽 `<trim>`: `p.title LIKE '%||#{keyword}||%' OR p.content LIKE '%||#{keyword}||%'`
1. `U`만 들어갔을 때
    - `u.uname = #{keyword}`
	
## 저의 구현례

- 제 경우에는 검색어가 없는 쿼리문이 다음과 같았습니다.

    ```sql
    SELECT * FROM (
        SELECT ROWNUM rn, pno, uname, title, 
        regdate, viewcount, likecount, tblname FROM (
            SELECT /*+ INDEX_DESC (p1_pieces p1_pieces_pk) +*/ 
            p.pno, u.uname, p.title, p.regdate, 
            p.viewcount, p.likecount, p.tblname 
            FROM p1_pieces p INNER JOIN p1_users u ON p.uno = u.uno 
            WHERE p.tblname = 'pieces' 
            
            /* 여기에 동적 SQL을 집어넣을 겁니다 */
            
            ORDER BY p.regdate DESC
		)
    ) WHERE rn <= #{pagenum} * #{amount} AND rn > (#{pagenum} - 1) * #{amount}
    ```

- `WHERE`절에 들어갈 것을 싹 모아 놨기 때문에, 필수적인 조건인 게시판 이름 다음에 검색어의 유무에 따라 `AND`를 붙일지 말지만 결정하면 됐습니다.
- 그래서 위의 괴상한 코드 앞에 `targetArr`의 유무를 체크하는 조건문을 하나 더 달아 놨죠.

    ```xml
    <if test="targetArr != null">
        AND
    </if>
    ```

- 참고로 블로그 프로젝트 할 때 제가 DAO 메서드에서 저거랑 정확히 똑같은 짓을 자바로 해 봤었는데, MyBatis가 수십 배 편합니다. 여러분은 굳이 굳이 이상적인 검색 구현하겠다고 아까운 시간을 낭비하지 마세요...
