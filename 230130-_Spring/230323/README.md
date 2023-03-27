#

## [230322 ←](../../230130-_Spring/230322/) | [→ 230327](../../230130-_Spring/230327/)

## 이젠 서블릿도 스프링이 해준대

- doGet()이랑 doPost() 대신에 RequestMapping 어노테이션으로 지정해 주면 된다.
- 스프링 프로젝트를 하나 만들면 HomeController 클래스는 자동으로 만들어 준다. 보면 Controller 어노테이션도 있다.
- 또한 스프링에서 빈으로 등록되기 때문에 따로 객체를 생성하지 않아도 된다...만, 사실은 context:component-scan 객체의 base-package 속성에 com.hanulso.controller 패키지가 등록되어 있기 때문에, 자동으로 빈으로 등록되는 것이다.

```java
@Controller
@RequestMapping("/sample/*")
public class SampleController { ...
```

## 각각의 패키지의 역할

- controller: 말 그대로 컨트롤러
- domain: DTO, 내지는 VO가 저장된 곳
- mapper: MyBatis가 SQL 쿼리를 실행하는 곳

## 다 알아서 잘 해준대

- 좀 더 인간의 생각방식대로 자동으로 해 준다.
- RequestParam 어노테이션을 쓰면 요청에서 들어온 패러미터를 자동으로 메서드 안의 패러미터로 넣고, 이 과정에서 형변환도 자동으로 된다.
