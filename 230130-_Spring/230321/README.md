## [230320 ←](/230130-_Spring/230320/) | [→ 230322](/230130-_Spring/230322/)

## 설정이라곤 하지만 사실 메타프로그래밍 같은 겁니다

- pom.xml로 필요한 라이브러리 다운받기
- HikariCP로 커넥션 풀 설정
  - root-context.xml에서 설정한 내용이 DBManager 클래스를 만드는 것과 같다고 생각할 수 있다
- 그리고 이제 MyBatis를 이용해서 DB를 직접 조작해 볼 것이다

## MyBatis에 대한 더 긴 정의

- 개발자가 지정한 SQL, 저장 프로시저, 그리고 몇 가지 고급 매핑을 지원하는 퍼시스턴스 프레임워크
  - Persistence framework: MVC 모델의 M에 해당하는 레이어를 지원하는 프레임워크
  - V와 C는 이 패턴에서 Presentation layer라는 이름을 가지고 있다
- JDBC로 처리하는 상당부분의 코드와 파라미터 설정 및 결과 매핑을 대신해 줌
- 빠르게 SQL을 실행할 수 있고 JDBC로 이루어지는 지루한 코딩 작업을 줄일 수 있다

## MyBatis 사용하기: SqlSession

- SQL을 쓰려면 Connection이 필요하다.
- SQL을 처리하려면 그걸 전달해 줘야 한다.
- 그리고 그 결과를 return받을 수도 있어야 한다.
- 이러한 값들을 기억하고 처리하는 게 SqlSession이라는 클래스.
- DAO를 만들 필요 없이 스프링이 자동으로 만들어 준다.

## Mapping

- SQL을 어떻게 처리할 것인지 별도의 설정을 분리해 주고, 자동으로 처리하는 방식
- Mapper는 매핑을 할 때 쓰는 클래스를 의미
  - 요걸 만드는 방법엔 xml, 인터페이스+어노테이션을 이용하는 두 가지 방법이 있다.
  - 스프링 설정하는 방법이랑 비슷하지 그지?
- com.hanulso.mapper.TimeMapper

    ```java
    @Select("SELECT sysdate FROM dual") // 잘 안 쓰는 방식이긴 함
    public String getTime();
    ```

- xml 방식

```xml
<mybatis-spring:scan base-package="com.hanulso.mapper"/>
```

- 인터페이스+어노테이션 방식
  - RootConfig.java

    ```java
    @MapperScan(basePackages = {"com.hanulso.mapper"})
    public class RootConfig {
    ```

## Test

```java
@Autowired
private TimeMapper timeMapper;

@Test
public void getTimeTest() {
    System.out.println(timeMapper.getTime());
}
```

- 어머나 세상에, 추상 메서드를 불렀을 뿐인데 SQL문이 실행되어 버렸다!
- 어노테이션을 읽은 MyBatis가 알아서 SQL문 구현부를 작성해 주기 때문이다
- 하지만 문법으로만 있는 어노테이션이고, 저렇게 직접 @Select로 쿼리를 집어넣을 뿐이라면 MyBatis를 쓰는 이유가 없을 것이다.
- 그래서 xml 매퍼와 같이 사용하는 것이 나을 것이라 판단된다

## resources/com/hanulso/mapper

- 인터페이스에 같이 저장해도 되지만, resources 폴더에 패키지 구조에 맞게 XML 파일을 만들어 줘도 매핑이 된단다.
- XML에서는 태그 이름이 객체 이름인 셈이고, 그 안에 있는 속성들이 변수 역할을 한다. 이 때, 각각의 객체와 속성들이 어떤 역할을 하는지에 대한 설정이 필요하며, 이 때 사용하는 설정이 XML 스키마, 또는 DTD이다.
- MyBatis 매퍼의 경우에 XML 파일 머리에 다음과 같이 적어준다:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd" >
```
