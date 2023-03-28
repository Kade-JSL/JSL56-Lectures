#

## [230323 ←](../../230130-_Spring/230323/) | [→ 230328](../../230130-_Spring/230328/)

## 딥웹 어딘가에 스프링 실습 프로젝트 리포지토리를 만들었습니다

- [http://oeuiuapk8ruwdv1pu8ye.duckdns.org:10880/kade-jsl/hanulso-spring](http://oeuiuapk8ruwdv1pu8ye.duckdns.org:10880/kade-jsl/hanulso-spring)

## Model 객체

- 스프링에선 `request.setAttribute()` 대신에 `Model`이라는 전달자를 사용하게 된다.

```java
@GetMapping("/ex05")
public String ex05(SampleVO vo, @ModelAttribute("page") int page) {
  log.info("SampleVO: " + vo);
  log.info("Page: " + page);
  return "/sample/ex05";
}
```

- 이 짧은 코드에서 스프링이 해 주는 일을 알아보자.
  1. 일단 uri 매핑을 해 준다.(`@ServletMapping`)
  1. GET 요청으로 온 변수들을 알아서 VO 객체에 넣어 준다.(`request.getParameter()`)
  1. 물론 다른 패러미터도 마찬가지다.
  1. 리턴값에 있는 JSP 파일에 포워딩도 시켜준다.(`SampleVO`, `request.setAttribute()`)
  1. 자동으로 포워딩해 줄 Attribute 이름도 어노테이션으로 지정해 주면 된다.
- Controller에서의 리턴 타입
  - String이라면 views 폴더 밑에 있는 jsp 파일을 찾아가라는 것이다.
  - void라면 호출하는 URL과 동일한 이름의 jsp를 실행함. 즉 /sample/ex06으로 호출했다면 /views/sample/ex06.jsp를 실행한단 이야기이다.
  - `@Controller`에서만 그렇다 이런 얘기다!
- 아니 근데, VO 객체는 그럼 왜 자동으로 포워딩되는겨?
  - 스프링MVC 컨트롤러는 기본적으로 Java의 규칙의 맞는 객체는 jsp로 포워딩하도록 설정되어 있어서 그렇댄다.
  - 이 규칙을 JavaBean 규칙이라고 한다.
    - 매개변수가 없는 생성자가 존재한다.
    - 멤버 변수에 setter와 getter 메서드가 존재한다.
