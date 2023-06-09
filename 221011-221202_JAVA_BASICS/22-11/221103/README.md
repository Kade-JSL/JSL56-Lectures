﻿#
### [221102 ←](/221011-221202_JAVA_BASICS/22-11/221102/) | [→ 221104](/221011-221202_JAVA_BASICS/22-11/221104/)

# 이날 배웠던 것

- 오늘은 왠지 마크다운으로 필기를 하고 싶은 기분이었습니다.
- [메서드 만들기, 호출하기 연습문제 "100배"](/221011-221202_JAVA_BASICS/22-11/221103/javastudy56/javastudy/src/javastudy/Object08.java): Object08.java
- [배열을 메서드 인수로 집어넣기](/221011-221202_JAVA_BASICS/22-11/221103/javastudy56/javastudy/src/javastudy/Object09.java): Object09.java

---

## 클래스와 메소드

- 자바의 모든 코드는 클래스 안에 들어 있다.
    - *꽤나 극단적인 객체지향이 되겠습니다. 덕분에 정말 객체지향 하면 자바라는 명성을 갖게 되었죠.*
- JRE에 있는 자바 기본 라이브러리를 보면 패키지만 수백 개, 그 안에 클래스도 수백 개, 그 안에 메서드도 수백 개다.
    - 이 중에 0.01%만 이해하고 있어도 대단한 자바 전문가라고 할 수 있다.
    - 다 이해하지 못하더라도 0.01%를 끌어올 수만 있어도 또 대단한 자바 전문가이다.
- 클래스는 설계도.
    - 라이브러리에 무지하게 많은 설계도들 중에 하나를 뽑아서 쓰는 격.
    - JRE 기본 라이브러리에는 잘 만들어진 설계도 말고는 없다.
        - *굳이 말하자면 사람이 만든 거니까 어딘가에 결함이 있을지도 모르겠습니다만, 보통은 우리가 생각할 필요도 없을 만큼 사소합니다.*

## `Scanner sc = new Scanner(System.in);`

- 다른 모든 기본형 타입처럼 클래스형도 반드시 그 클래스의 형을 맞추어야 한다.
- `java.util.Scanner` 클래스를 가져오는 이유는 코드 안에서 우리가 `nextInt()`를 사용하기 위함이다.
- `new Scanner(System.in)`이라고 하는 거는, 내부 메서드를 사용하기 전에 `new`라는 생성자를 이용해서 `Scanner()`라는 컨스트럭터 안에 매개변수로써 `System.in`을 넣는다는 뜻이다.
    - *저도 정확하겐 모릅니다. 그냥 제 머릿속에선 이렇게 기억하고 있습니다.*

## 예컨대 내가 점프를 하고 싶다 하면...
        
1. 많고 많은 클래스들 중에 점프 메서드가 있는 클래스를 찾은 다음에,
2. 만일 `Car` 클래스 안에 `jump()` 메서드가 있다 치면
    - *비유를 위해 가상으로 만든 클래스입니다. 실제로 자바 라이브러리엔 이런 클래스가 없습니다.*
3. `Car myCar = new Car();`로 일단 자동차 객체를 만들어서,
    - *그러니까 자동차를 하나 뽑는 거죠.*
4. `myCar.jump()`를 써서 실제로 점프를 시키면 된다.
5. `Car` 클래스는 설계도기 때문에 굳이 이름이 `myCar`가 아니더라도 뭐 `yourCar`라던지 `baKar`라던지 `kuruma`라던지 하여튼 몇십 개든 몇백 개든 `Car`형의 클래스를 생성할 수 있다. 실제 세상이 아니라 컴퓨터 세상이니까 마음껏 얼마든지 할 수 있는 것.

## 뽑을 때 뽑더라도 조건이 필요하다.

- `new Scanner(System.in)`이 그러하다는 거다.
- 클래스에 따라 새로운 클래스 객체를 만들 때의 생성자 입력은 천차만별이다.
- `Car` 객체를 만든다 치면 뭐 `new Car("White")`일 수도 있는 거고 `new Car(100)`일 수도 있단 얘기.
    - *`100`을 입력받는다면 뭔가 100마력짜리 자동차인 걸까요?*

## `static` 떡밥 회수

- 그래서 만일 `new Car()` 없이 그냥 쓸 수 있는 클래스 메서드가 있다면
- 바로 그 메서드가 정적(`static`) 메서드이기 때문에 바로 쓸 수 있는 것이다.

## 로직은 중대 문제다

- 잔머리를 많이 굴리자.
- 조건문도 많이 써보면 잔머리가 늘어서 로직도 짤 수 있게 된다.
- **'나는 왜 이런 생각을 못 했지?'**: 많이 하면 는다는 이야기.