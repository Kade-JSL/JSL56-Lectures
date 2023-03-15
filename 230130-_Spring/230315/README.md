#

### [230213 ←](../../230130-_Spring/230213/) | [→ 230316](../../230130-_Spring/230316/)

# 이날 배웠던 것

---

## Spring Framework 이전에는...

- DB 작업을 할 때 뭐 하나 할 때마다 새로운 DAO 메서드를 새로 써야 하는 거 굉장히 불편하다...
- Model 1로 이제 한 코드에 DB연결과 DB작업을 다 하는 것도 있었고
- Model 2로 이걸 Model, View, Controller로 나눠 봤다.
- Spring Framework는 Model에서의 DB 작업을 프레임워크로 편하게 해 놓은 것이다.

## Spring?

- 일단은 당연히 Java를 사용한 프레임워크
- 동적인 웹 사이트를 개발하기 위한 여러 가지 서비스를 제공하고 있고
- 우리나라의 경우 전자정부 표준 프레임워크의 기반 기술로써 쓰이고 있음
- POJO를 기반으로 AOP, PSA, IoC/DI 특징이 있다는데...

## Spring의 특징

- Plain Old Java Object(POJO; 그냥 자바 객체)
    - 프레임워크 없이도 돌아가는 순수한 자바 객체
    - 특정 기술에 종속되지 않는 순수한 자바 객체
        - 결합력이 줄어들어 객체지향의 장점이 사라지는 문제 해결
- Aspect Oriented Programming(AOP; 관점 지향 프로그래밍)
    - 공통 관심사랑은 코드가 중복되는데 중복되는 코드를 로직과 분리시켜 놓는다
- Inversion of Control(IoC; 제어의 역전)
    - 코드의 제어권을 Spring이 가지고 있다.
    - 개발자가 직접 제어하는 부분을 프레임워크가 대신 제어하게 된다.
- Dependency Injection(DI; 의존성 주입)
    - 의존: A 클래스에서 B 클래스에 있는 기능을 사용한다면 B 클래스의 객체를 생성해야 한다.
        - 즉 A 클래스는 B 클래스에 의존한다.
    - 근데 그냥 B 클래스에서 A 클래스를 사용한다고만(`private A;`) 하면 알아서 프레임워크가 주입시켜 준다.
- **즉 로직과 관련된 것만 우리가 개발하고 나머지는 Spring에게 맡긴다는 것!**

## Spring Tools Suite

- Eclipse 대신에 사용하는 개발 툴
- JetBrains IntelliJ를 많이 쓰기도 한다
- 하지만 역시 Eclipse도 많이 쓴다