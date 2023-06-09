﻿#
### [221121 ←](/221011-221202_JAVA_BASICS/22-11/221121) | [→ 221123](/221011-221202_JAVA_BASICS/22-11/221123/)

# 이날 배웠던 것

- [/controller/](/221011-221202_JAVA_BASICS/22-11/221122/javastudy/controller/)
    - [**RegexMain.java**: 정규표현식에 대한 간단한 입문](/221011-221202_JAVA_BASICS/22-11/221122/javastudy/controller/RegexMain.java)
    - [**CalendarMain.java**: 자바 시간 라이브러리에 대한 설명과 실습](/221011-221202_JAVA_BASICS/22-11/221122/javastudy/controller/CalendarMain.java)
    - [**SimpleDateFormatMain.java**: 자바 시간 포매팅에 대한 설명과 실습](/221011-221202_JAVA_BASICS/22-11/221122/javastudy/controller/SimpleDateFormatMain.java)
    - [**CollectionMain.java**: 컬렉션 프레임워크에 대한 이해, `ArrayList` 실습](/221011-221202_JAVA_BASICS/22-11/221122/javastudy/controller/CollectionMain.java)
- [/dao/](/221011-221202_JAVA_BASICS/22-11/221122/javastudy/dao/)
    - [**CalendarDao.java**: `Calendar` 클래스를 이용하여 간단한 달력 출력하기](/221011-221202_JAVA_BASICS/22-11/221122/javastudy/dao/CalendarDao.java)
- [/dto/](/221011-221202_JAVA_BASICS/22-11/221122/javastudy/dto/)
    - [**Student.java**: `ArrayList` 실습에 활용된 클래스 객체](/221011-221202_JAVA_BASICS/22-11/221122/javastudy/dto/Student.java)

---

## 정규표현식; Regular expression; 正規表現

- 또는 정규식
- 텍스트 데이터 중에서 원하는 조건(`java.util.regex.Pattern`)과 일치하는 문자열을 찾아내기 위해 사용하는 것
- DB나 javascript에서 지겹도록 사용하는 문법.
    - *거지같이 어렵습니다. 복잡해지면 진짜 외계어 같아져요.*

## `java.util.Calendar`

- 시간과 날짜 정보를 저장하고 관리하는 클래스
    - 년, 월, 일, 요일, 시간, 분, 초, 밀리초, 오전/오후 등
- `Calendar`는 추상 클래스라 직접 객체를 생성할 수 없다.
    - `getInstance()` 메서드로 객체를 생성할 수 있다.
- `now` 객체는 현재 날짜와 시간정보를 생성하는 객체
- *아마도 제 생각엔 `enum` 같은데 말이죠,* 상수로 여러가지 시간 단위들을 가지고 있다.
    - `MONTH`: 0부터 11까지 있다. 즉 일반적으로 보려면 +1.
    - `WEEK_OF_YEAR`: 당해년도 몇 번째 주인지
    - `WEEK_OF_MONTH`: 당월 몇 번째 주인지
    - `DAY_OF_MONTH`: 당월 1일부터 며칠인지
        - `DATE`도 똑같은 기능을 함
    - `DAY_OF_YEAR`: 당해년도 1월 1일부터 며칠인지
    - `DAY_OF_WEEK`: 일요일 기준으로 1부터 7까지의 숫자로 요일을 표시
        - `DAY_OF_WEEK_IN_MONTH`: 그 요일은 이번 달 몇 번째 요일인지
    - `AM_PM`: 오전이면 0, 오후면 1
    - `HOUR`: 12시간제 시간
        - `HOUR_OF_DAY`: 24시간제 시간
        - `MINUTE`: 분
        - `SECOND`: 초
        - `MILLISECOND`: 밀리초
    - `getActualMaximum(Calendar.DATE)`: 이번 달 마지막 날은 며칠인가

## `java.text.SimpleDateFormat`

- 시간 타입의 객체를 받아 입력된 포맷대로 시간을 출력하는 것이다
    - *`java.util.Date` 클래스는 뭔가 타입만 남아 있고 생성자 자체는 `Deprecated` 처리가 된 느낌입니다.*
- `Calendar` 클래스에서는 `getTime()` 메서드를 사용하면 `Date` 타입으로 날짜가 넘어온다.
- 생성자에 넣는 `String`은 `yyyy`, `MM`, `dd` 같은 걸로 시간 타입의 구성요소를 지정한 다음, 자유롭게 지정할 수 있다.
    
    | 실제 데이터 | `SimpleDateFormat` | `Calendar` |
    |---|---|---|
    | 년 | y | YEAR |
    | 월 | M | MONTH |
    | 주차(년) | w | WEEK_OF_YEAR |
    | 주차(월) | W | WEEK_OF_MONTH |
    | 일자(년) | D | DAY_OF_YEAR |
    | 일자(월) | d | DAY_OF_MONTH 또는 DATE |
    | 해당 일자의 요일의 당월 주차 | F | DAY_OF_WEEK_IN_MONTH |
    | 요일 | E | DAY_OF_WEEK |
    | 오전/오후 | a | AM_PM |
    | 시(24시간제) | H | HOUR_OF_DAY |
    | 시(12시간제) | h | HOUR |
    | 분 | m | MINUTE |
    | 초 | s | SECOND |
    | 밀리초 | S | MILLISECOND |

## 컬렉션 프레임워크; Collection Framework; コレクション・フレームワーク

- 컬렉션(여러 객체)을 다루기 위한 표준화된 프로그래밍 방식
- 컬렉션이란?
    - 여러 객체의 저장소
    - 요소에 따라 크기가 자동으로 조절
    - 고정 크기의 배열을 다루는 어려움이 해소
    - 다양한 객체들의 삽입/삭제/검색 등의 작업을 쉽게 처리할 수 있게 됨
- 컬렉션을 다루기 위한 자바의 인터페이스와 클래스
    - `List`, `Set`, `Map` 인터페이스들이 있음
        
        || `List` | `Set` | `Map` |
        |---|---|---|---|
        | 순서 | 있음 | 있음 | 없음 |
        | 데이터 중복 | 허용 | 허용 안 함 | 허용* |
        | 구현 클래스 | `ArrayList`,<br>`Vector`,<br>`LinkedList`,<br>`Stack` | `HashSet`,<br>`TreeSet` | `HashMap`,<br>`TreeMap`,<br>`HashTable` |

        - *`Map`의 데이터는 키와 값의 쌍으로 배열들이 이루어져 있고, 따라서 키의 순서는 없으며, 키의 중복은 허용하지 않으나 값들의 데이터는 키가 다르다면 중복될 수 있다.
    - `List`와 `Set`의 공통적인 부분을 뽑아 만든 인터페이스가 `Collection`이라는 것

## 제네릭; Generics; ジェネリクス

- 여러 종류의 타입으로 변신할 수 있도록 클래스나 메서드를 일반화시키는 방법
- 모든 종류의 데이터 타입을 다룰 수 있도록 일반화된 타입 매개 변수로 클래스나 메서드를 작성하는 기법
- 작성 방법: `<T>`, `<E>`

### 컬렉션과 제네릭

- 컬렉션은 제네릭 기법으로 구현됨
- 컬렉션의 요소는 객체 타입만 사용 가능하다. 기본형도 사용할 수 있다.
    - 뭘 쓰면? [Wrapper](/221011-221202_JAVA_BASICS/22-11/221121#wrapper-클래스)를 쓰면!

**_저 진짜 거의 연수 시작 즈음에 이 축복받은 객체를 우연히 알게 돼서 잘 썼는데... 저번 주말에 여러분한테 보여주는 코드 쓸 땐 그걸 안 쓰고 객체 배열을 만들려고 하니까 진짜 너무... 너무너무 고통이었어요... 진짜 좋습니다 꼭 쓰세요..._**

## 그럼 진짜로 써 보자.

```java
ArrayList<Integer> arrayList = new ArrayList<Integer>();
```

- ↑ 정수형만 담을 수 있는 가변형 배열
- **`add()`**: 요소 삽입
- **`size()`**: 해당 배열의 길이를 `int`로 돌려줌
- **`get()`**: 인수로 넣는 위치의 배열 요소를 돌려줌