## [230418 ←](/230130-_Spring/230418/) | [→ 230424](/230130-_Spring/230424/)

# 실기시험 "아씨 그거 뭐였지?" 모음집

## 숫자 자릿수 표기하기

1. `java.text`의 `DecimalFormat` 클래스 이용하기

    ```java
    DecimalFormat df = new DecimalFormat("###.#");
    df.format(someNumber);
    ```

    - 숫자는 `#`으로 입력, 패턴은 생성자에 넣음
    - `format()` 메서드로 패턴 변환

1. PL/SQL의 `TO_CHAR()` 함수 이용하기

    ```sql
    ...,
    TO_CHAR(SOME_NUMBER_COLUMN, '999.9') AS SOME,
    ...
    ```

    - 첫 인수엔 변환할 열을, 다음 인수엔 작은따옴표 안에 숫자를 `9`로 치환하여 패턴을 입력
    - 날짜 패턴 변환에도 적용됨

## JSP에 패키지 불러오기

- page, import, 따옴표.

    ```jsp
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
        <td><input type="text" name="sno"/></td>
        <td>
            <input type="radio" name="gender" value="M"/>남성
            <input type="radio" name="gender" value="F"/>여성
            <input type="radio" name="gender" value="N"/>지정하지 않음
        </td>  
        <td>
            <>
        </td>

    ```

