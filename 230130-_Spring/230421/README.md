## [230418 ←](/230130-_Spring/230418/) | [→ 230424](/230130-_Spring/230424/)

# 실기시험 "아씨 그거 뭐였지?" 모음집

## 숫자 자릿수 포매팅하기

1. `java.text`의 `DecimalFormat` 클래스를 scriptlet(`<% %>` 쓰는 그거)에 넣어서 이용하기

    ```jsp
    <%
        DecimalFormat df = new DecimalFormat("###.#");
        df.format(someNumber);
    %>
    ```

    - 숫자는 `#`으로 입력, 패턴은 생성자에 넣음
    - `format()` 메서드로 패턴 변환

1. PL/SQL의 `TO_CHAR()` 함수 이용하기

    ```sql
    ...,
    TO_CHAR(SOME_NUMBER_COLUMN, '999.9') AS SOME_NUM,
    ...
    ```

    - 첫 인수엔 변환할 열을, 다음 인수엔 작은따옴표 안에 숫자를 `9`로 치환하여 패턴을 입력
    - 날짜 패턴(`DATE` 자료형) 변환에도 적용됨

## JSP에 패키지 불러오기

- page, import, 따옴표.

    ```jsp
    <%@ page import="java.sql.*" %>
    <%@ page import="java.text.*" %>
    <%@ page import="java.util.*" %>
    ```

## 내비게이션 바 리스트와 링크 스타일링

- `text-decoration`, `list-style`

    ```css
    a {
        text-decoration: none;
    }
    ul, ol {
        list-style: none;
    }
    ```

## 입력값 유효성 검사

1. 일단 `form`에 `name` 속성 지정
1. `<select>` 태그 안에는 반드시 `value=""`인 `<option>` 넣기

    ```html
    <form name="my" method="POST" action="sub1pro.jsp" onsubmit="return check();">
    ...
        <tr>
            <th>번호</th>
            <td><input type="text" name="sno"/></td>
        </tr>
        <tr>
            <th>성별</th>
            <td>
                <input type="radio" name="gender" value="M"/>남성
                <input type="radio" name="gender" value="F"/>여성
                <!-- <input type="radio" name="gender" value="N"/>지정하지 않음 -->
                <!-- 저는 항상 논바이너리를 선택에 넣어야 한다고 생각하기 때문에(이미 한국, 일본의 많은 사이트가 그러고 있음) 국가 시험에서도 그렇게 됐으면 하는 바람입니다. -->
            </td>
        </tr>
        <tr>
            <th>유형</th>
            <td>
                <select name="type">
                    <option value="">--선택--</option>
                    <option value="01">1유형</option>
                    <option value="02">2유형</option>
                    <option value="03">3유형</option>
                </select>
            </td>
        </tr>
    ...
    ```

1. `<form>` 태그는 기본적으로 DOM에 한 자리를 차지한다. 즉 `Document.querySelector()` 같은 귀찮은 짓 하지 않아도 이미 자바스크립트 객체로 등록된 상태이다.
    - 무슨 말이 하고 싶냐면 유효성 검사 함수 `check()`는(물론 다른 이름이어도 된다) 아래와 같이 시작하면 된다는 것이다.

    ```js
    function check() {
        if (my.sno.value == "") {
            alert("번호가 입력되지 않았습니다!")
            my.sno.focus()
            return false
        }
        ...
    }
    ```

    - DOM 상에서의 `<input>` 태그는 기본적으로 내장된 메서드가 3개가 있고, 그 중에 하나가 `focus()`라는 것이다. 시험지에서 _포커스를 이동시킨다_ 라고 되어 있는 부분이 이 메서드를 쓰는 부분.
    - 경고창은 `Window.alert()` 메서드를 쓴다. 이건 다 알죠?
    - `return false`도 잊지 말자.
    - 그리고 자바스크립트는 문장 끝에 세미콜론 안 붙여도 됩니다. 저는 문장 구분을 세미콜론으로 하는 걸 좋아해서 붙이는 편입니다만, 안 붙이고 싶어졌을 땐 안 붙이는 편이에요. 취향 따라 합시다. 이건 개발자들 사이에서도 의견이 갈리는 부분이라 말이죠.
    - 라디오 버튼의 경우 DOM에선 배열로써 존재한다. 유효성 검사도 배열 요소를 체크하자.
    - `<select>` 태그는 일반적인 `<input>` 태그처럼 취급하면 되지만, 시험지대로 빈 입력값을 만들고 싶으면 반드시 `value=""`을 써야 한다는 걸 기억하자.

    ```js
    ...
        if (!my.gender[0].checked && !my.gender[1].checked /* && !my.gender[2].checked */) {
            alert("성별이 선택되지 않았습니다!")
            my.gender[0].focus()
            return false
        }
        if (my.type.value == "") {
            alert("유형을 선택하지 않았습니다!")
            my.type.focus()
            return false
        }
    ...
    alert("정보가 정상적으로 등록되었습니다.")
    return true
    ```

    - 마지막의 `Window.alert()`와 `return true`도 잊지 말도록 하자.

## 내용을 지우고 처음부터 다시 입력합니다.

- `type="reset"` 버튼을 눌렀을 때 메시지와 함께 포커스가 이동하는 건 다음과 같이 하면 된다.
- 함수 이름은 `reset` 말고 다른 이름으로 하자. 왜냐면 이미 같은 이름의 키워드(예약어)가 존재하기 때문.
- 필자는 `onclick` 이벤트로 함수를 부르는 방식을 선택했는데, 당연히 돌아가는 다른 코드가 있다면 그 코드 쓰면 된다.

    ```html
    ...
    <input type="reset" value="다시 입력" onclick="resetbtn()"/>
    ...
    ```

    ```js
    function resetbtn() {
        alert("내용을 지우고 처음부터 다시 입력합니다.")
        my.sno.focus()
    }
    ```

## `<table>` 태그를 쓸 때

- `<tr>`은 꼭 넣자.
- `<th>`와 `<td>`는 꼭 구별하자.
- 표에 여백이 부족할 땐 적당하게 넣어 주자.
    
    ```css
    th, td {
        border: 1px solid #333;
    }
    td {
        padding: 0 10px;
    }
    ```

## 까먹기 쉬운 SQL

- `INSERT INTO (...) VALUES (...)`, `SELECT ... FROM ...`, `UPDATE ... SET ...`, `DELETE FROM ...`
- `SELECT`, `FROM`, (`INNER JOIN`, `ON`,) `WHERE`, `GROUP BY`, `ORDER BY`
- 쿼리 키워드 사이는 반드시 띄워 두어야 한다. 특히 이런 경우를 조심하자.

    ```java
    String query = "SELECT col1, col2, col3" + 
        "FROM tab1"; // 붙이면 "SELECT col1, col2, col3FROM ~"가 되므로 쿼리가 인식되지 않음
    String query = "SELECT col1, col2, col3 " + // 반드시 이렇게 띄울 것
        "FROM tab1";
    ```

- 컬럼의 별명은 `AS`로 설정, 테이블의 별명은 그냥 띄어써서 설정
- 조인이 이루어지는 쿼리의 경우 반드시 모든 컬럼 앞에 소속 테이블을 명시해야 함(아래의 SQL문 참조)
    - 안 그래도 된다는데 왠지 필자만 하면 맨날 `SQLException`이 뜬다. 왜인지 모르겠다... ㅠㅠ

    ```sql
    SELECT
        a.col1, a.col2, b.col3, b.col4 
    FROM
        tab1 a 
        INNER JOIN tab2 b 
        ON a.col3 = b.col3 
    WHERE 
        a.col1 < 10 
    ORDER BY 
        a.col3 DESC;
    ```

## 그 외 FAQ

- **DB 연결이 안 되는데?**
    1. DB 연결에 필요한 변수는 네 가지입니다.
        1. WebContent/WEB-INF/lib에 있는 DBMS 드라이버 클래스의 위치: `String className = "oracle.jdbc.OracleDriver";`
            - ojdbc6.jar 안에는 `OracleDriver` 클래스가 두 개 있습니다. 하나가 `oracle.jdbc.OracleDriver`고, 하나는 `oracle.jdbc.driver.OracleDriver`입니다. 둘 다 써도 됩니다. 짧은 편이 좋겠죠?
        1. 컴퓨터 상의 Oracle 11g XE의 URL: `String url = "jdbc:oracle:thin:@localhost:1521:xe";`
            - 각각 `드라이버 이름:연결하는 DBMS:드라이버가 쓰인 언어:DB의 IP 주소:DB의 리스너 포트:DB의 서비스 ID`입니다.
                - Java가 아니라 thin인 이유는 이 드라이버가 씬 드라이버라 불리는, 순수하게 자바로만 쓰여 있으며 별도의 설치 과정을 필요로 하지 않기 때문입니다. 저도 여기까지만 알고 정확히는 몰?루
        1. DB 스키마 이름: `String user = "system";`
        1. DB 스키마 접속 비밀번호: `String password = "1234";`
    1. 이 네 가지의 변수들이 제대로 입력되었는가 봅시다.
    1. 테스트용 코드도 유심히 봅시다. 
        1. `Connnection` 객체는 제대로 불러왔나요?
        1. `null`인지 체크는 했나요?
        1. 어떤 메시지를 출력하도록 되어 있나요?

- **데이터가 안 뜨는데?**
    1. 우선은 이클립스 화면 하단부의 Console에 가서 예외 로그가 떴는지 확인합시다.
        1. 똑같은 `SQLException`이어도 DB 연결이 되지 않은 경우, 쿼리문에 오류가 있을 경우, 결과에서 해당 컬럼을 찾을 수 없는 경우 등이 있습니다.
        1. `ClassNotFoundException`은 간단합니다. 이 예외를 던지는 코드는 `Class.forName("oracle.jdbc.OracleDriver");`밖에 없기 때문입니다. 오타가 없는지, 제대로 JDBC 라이브러리는 복사했는지 확인합시다.
        1. 이외의 예외 로그에 대해서도 예외가 발생한 코드를 찾아가서 적절하게 해결해 줍시다.
    1. DAO 객체로 갑니다.
        1. 쿼리 스트링을 제대로 입력했는지 확인합시다. 띄어쓰기는 제대로 했는지, 컬럼 이름은 제대로 입력했는지, 조인 조건은 전부 넣었는지 확인합시다.
        1. `Connection` 말고도 `PreparedStatement`나 `ResultSet` 객체가 제대로 메서드 안에서 작동하는지 확인합시다.
        1. 쿼리 결과를 받을 때 제대로 전부 VO(DTO) 객체에 set시켰는지, set이 끝난 VO 객체를 제대로 List에 넣었는지 확인합시다.
    1. VO(또는 DTO) 객체로 갑니다.
        1. 멤버 변수들이 제대로 전부 존재하는지 확인합시다.
    1. JSP로 갑니다.
        1. 맨 위에의 `import` 부분에서 자바 코드를 제대로 임포트했는지 확인합시다.
        1. 위쪽의 `<%%>` 부분에서 제대로 된 DAO 메서드를 호출했는지 확인합시다.
        1. 테이블 내의 `<%%>` 부분에서 제대로 된 VO 변수를 입력했는지 확인합시다.
        1. `<%%>` 안에 입력한 반복문은 올바른지, 제대로 태그들이 안쪽에 들어가 있는지 확인합시다.

- **페이지가 안 뜨는데?**
    1. 네비바에 있는 `<a>` 태그에 링크를 제대로 걸어 두셨는지 확인합시다.
        - 해당 링크가 가리키는 JSP 파일이 존재하는지도 확인합시다.
    1. 8080 포트는 오라클 DB와 겹치기 때문에, 톰캣의 HTTP 포트를 8080 이외의 다른 포트로 지정해 줄 필요가 있습니다.
    1. 이클립스에서 프로젝트를 만드셨을 때 프로젝트 이름을 `cbq_01`로 하셨다면 메인 페이지의 올바른 주소는 `http://localhost:8081/cbq_01/`입니다. 포트 번호는 위에서 말했다시피 굳이 8081일 필요는 없고, 설정해 주신 포트 번호로 하시면 됩니다.
    1. 안 되면 껐다가 다시 켭시다.
        - 껐다가 다시 켜도 안 되면 지웠다가 다시 깝시다.