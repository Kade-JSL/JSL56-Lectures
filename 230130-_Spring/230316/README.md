#
### [230315 ←](../../230130-_Spring/230315/) | [→ 230317](../../230130-_Spring/230317/)

# 이날 배웠던 것

---

## Spring에선...

- Servlet이 DispatcherServlet이 되어서 새로 서브클래스를 만들 필요가 없다. doGet()이나 doPost()를 오버라이드해서 작성하지 않아도 된다.
- 그니깐 진짜로 로직에만 신경써도 된대두.

## XML로 설정할 수도 있지만...

- Java로 웹 앱의 설정을 바꿀 수도 있다.
```xml
...
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-war-plugin</artifactId>
    <version>3.2.0</version>
    <configuration>
        <failOnMissingWebXml>false</failOnMissingWebXml>
    </configuration>
</plugin>
...
```
- 다음과 같이 설정해서 web.xml이 없어도 war를 빌드할 수 있도록 한다.
- 클래스를 만든 다음 어노테이션(지금의 경우엔 `@Configuration`)을 붙여서 프레임워크가 어떤 역할의 클래스인지 알아보도록 한다.
- web.xml을 대신하는 클래스는 이렇게 만든다.
```java
package com.hanulso.config;

import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

// web.xml을 대신하는 클래스
public class WebConfig extends AbstractAnnotationConfigDispatcherServletInitializer {

	@Override
	protected Class<?>[] getRootConfigClasses() {
		return null;
	}

	@Override
	protected Class<?>[] getServletConfigClasses() {
		return null;
	}

	@Override
	protected String[] getServletMappings() {
		return null;
	}
	
}
```
- 정말 클래스 이름 한 번 드럽게 길다.

## Bean이란?

- Spring에서 관리하는 객체를 Bean이라 한다.
- 원...래는 조금 더 복잡한 정의가 있는데, 저는 Java판 JSON 표준 같은 느낌으루다가 이해하고 있습니다.

## 의존성 주입(DI; Dependency Injection)

- A라는 클래스에서 B, C, D... 같은 클래스들을 사용하고 싶다고 생각해 보자.
- 그러면 우리는 이렇게 써야 한다.
```java
class A {
    B b = new B();
    // 이러고 나서야 B의 멤버변수들과 메서드에 접근할 수 있게 됨
}
```
- 근데 스프링에서는 걍 이렇게만 해 줘도 된다!
```java
class A {
    B b;
}
```
- 그럼 스프링이 알아서 생성해서 주입시켜 준댄다.

## lombok?

- 멤버 변수에 값을 저장하고 읽으려면 getter랑 setter가 필요했다.
- 그리고 toString()이라는 메서드도 만들어 줘야 했다.
- 이걸 자동으로 만들어 주는 라이브러리가 lombok이라는 것이다.
- org.projectlombok.lombok으로 불러온다.
- Gradle 방식으로 dependency 불러오기: 스프링부트에서 된다.

## log4j 2버전 이하는 매우 심각한 보안 결함이 있습니다.

- 얼마나 심각하냐면 로깅으로 낑겨들어가서 웹 사용자들의 정보까지 캐낼 수 있는 정도의 심각한 결함이에요.
- 하지만 우리는 프로덕션 환경에 웹페이지를 놓진 않습니다. 로컬호스트에 놓을 뿐이죠... 아직은요.
- 저같이 셀프 호스팅을 하는 경우엔 이런 결함은 최대한 피하고 싶어서 조금 더 최신 버전을 썼습니다.

## jUnit

- 클래스 간의 결합성이라 하는 게 다른 게 아니라...
- 예컨대 DB에서 가져온 데이터를 View로 쏴주는 클래스가 있다고 하자.
- 만일 View에서 데이터가 제대로 표시되는지 보고 싶어졌을 때 화면구현이 제대로 안 되어 있다고 하면 어떻게 할 것인가?
- 여기서 단위 테스트(Unit test; 単体テスト)가 등장하는 것이다.
- 해당 클래스에서 입출력이 될 거라고 기대되는 값들을 예상하고, 입력에는 미리 준비된 가짜 입력을, 출력부에는 잘 정리된 출력을 준비하는 식으로 테스트 코드를 작성할 수 있다. 이것을 지원하는 라이브러리가 jUnit이라는 것.