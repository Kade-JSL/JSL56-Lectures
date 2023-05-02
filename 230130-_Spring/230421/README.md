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
    - 날짜 패턴 변환에도 적용됨

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
    - 무슨 말이 하고 싶냐면 유효성 검사 함수 `check()`는(물론 다른 이름이어도 된다) 이렇게 시작하면 된다는 것이다.
    - DOM 상에서의 `<input>` 태그는 기본적으로 내장된 메서드가 3개가 있고, 그 중에 하나가 `focus()`라는 것이다. 시험지에서 _포커스를 이동시킨다_ 라고 되어 있는 부분이 이 메서드를 쓰는 부분.
    - 경고창은 `Window.alert()` 메서드를 쓴다. 이건 다 알죠?
    - `return false`도 잊지 말자.
    - 그리고 자바스크립트는 문장 끝에 세미콜론 안 붙여도 됩니다. 저는 문장 구분을 세미콜론으로 하는 걸 좋아해서 붙이는 편입니다만, 안 붙이고 싶어졌을 땐 안 붙이는 편이에요. 취향 따라 합시다. 이건 개발자들 사이에서도 의견이 갈리는 부분이라 말이죠.

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

    - 라디오 버튼의 경우 DOM에선 배열로써 존재한다. 유효성 검사도 배열 요소를 체크하자.
    - `<select>` 태그는 일반적인 `<input>` 태그처럼 취급하면 되지만, 시험지대로 빈 칸을 만들고 싶으면 반드시 `value=""`을 써야 한다는 걸 기억하자.

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

1. `type="reset"` 버튼을 눌렀을 때 메시지와 함께 포커스가 이동하는 건 다음과 같이 하면 된다.
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

## HTML을 할 때

- `<tr>`은 꼭 넣자.
- `<th>`와 `<td>`는 꼭 구별하자.
- 표에 여백이 부족할 땐 적당하게 넣어 주자.

## SQL 조건문

- `CASE WHEN` ~ `THEN` ... ~ `END`로 이루어져 있다.
- 23-05-02일에 실시한 모의실기시험의 경우:

    ```sql
    ...
    case when oiltype = '1' then '휘발유' 
    when oiltype = '2' then '고급휘발유' 
    when oiltype = '3' then '경유'
    when oiltype = '4' then '등유'
    end as otype
    ...
    order by oildate, otype
    ...
    ```

- 해당 시험에서는 `otype`이 나타내는 텍스트에 따라서 정렬을 해야 했기 때문에 SQL문에서 텍스트 대체가 일어날 필요가 있었습니다.

## 그 외 FAQ

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