## [230327 ←](/230130-_Spring/230327/) | [→ 230329](/230130-_Spring/230329/)

## 스프링 MVC에서의 컨트롤러

- `@RequestMapping` 내지는 `@GetMapping`, `@PostMapping` 어노테이션을 이용해서 요청이 들어오는 uri에 대한 응답 메서드를 지정한다.
- `@RequestParam` 어노테이션을 이용해 들어오는 패러미터들이 들어갈 곳을 지정한다.
- `String`: 해당 문자열이 지정하는 JSP 파일에 메서드의 결과를 포워딩한다.
- `@ModelAttribute`를 이용해 해당 변수 이름을 가진 특성을 포워딩한다.
- JavaBean 표준에 맞는 객체는 자동으로 그 객체 이름을 가진 특성으로 포워딩된다.
  - 단, 이 객체는 스프링에 빈으로 등록되므로 스프링 빈의 작명 규칙에 따라 첫 글자가 대문자가 아니라 소문자가 된다.(`SampleVO` -> `sampleVO`)
- 리턴 타입 앞의 `@ResponseBody`를 이용하면 그 타입이 JavaBean 표준에 맞다면 스프링이 리턴 객체를 JSON 형태로 직렬화(serialize)하여 응답을 보낸다.

## `org.springframework.http.ResponseEntity`

- 굳이 비교하자면 `HttpServletResponse` 객체와 닮은꼴이라 할까.
- HTTP 응답은 헤더, 메시지(내지는 보내고자 하는 데이터), 응답 상태로 이루어져 있는데, 딱 이번 코드에서 `return new ResponseEntity<>(msg, header, HttpStatus.OK)`라 한 것과 같다.

## 갑자기 분위기 기초 자바문법

```java
int[] a; // 맞음
int a[] // 맞음
int a[2]; // 틀림
int[] a = new int[2]; // 이게 맞음
```

- 인덱스를 적는 것은 대입할 때!

```java
    int a = 0;
    do {
        System.out.println(a++);
    } while (a == 10);
```

- 이 경우 콘솔엔 `0`이 출력되고(`a++`은 1이 더해지기 전에 괄호 밖의 코드를 실행하므로) `a`가 10이 아니므로 반복문을 빠져나온다.
- 즉 콘솔에 `0`만 출력된다.

```java
    int[] a = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12};
    static void method1() {
        try {
            method2();
        } catch (Exception e) {
            System.out.println("method1");
        }
    }
    static void method2() {
        try {
            System.out.println(a[12]);
        } catch (ArithmeticException e) {
            System.out.println("method2");
        }
    }

    public static void main(String[] args) {
        method1();
    }
```

- 이 경우, `a` 배열의 인덱스는 11까지밖에 없기 때문에 `method2()`의 출력문에서 예외가 발생.
- 하지만 발생하는 예외는 `ArrayIndexOutOfBoundsException`이지 `ArithmeticException`이 아니기 때문에(보통 우리가 보는 경우는 0으로 나눌 때밖에 없습니다) 발생한 예외는 아래쪽의 `catch` 문에서 받지 않고 `method2()`가 호출된 곳(呼び出し元)으로 넘어가게 된다.
- `method2()`가 호출되는(呼び出される) 부분인 `method1()`으로 넘어간 예외는 `catch(Exception e)`에서 모든 예외의 상위 클래스(スーパークラス)인 `Exception`을 받기 때문에 아래의 코드인 `System.out.println("method1")`이 실행된다.
- 따라서 이 코드를 실행한 결과는 콘솔(내지는 로거 콘솔의 SYSTEM_OUT)에 `method1`이 출력되는 것으로 끝나게 된다.

## `commons-fileupload`와 `commons-io`

- 알아서 MavenRepo에서 검색해서 추가하자.
  - `commons-fileupload`의 버전 태그는 1.3.3
  - `commons-io`의 버전 태그는 2.6
- servlet-context.xml에 다음과 같이 추가해 준다.

```xml
    <beans:bean id="multipartResolver" class="org.springframework.web.multipart.commons.CommonsMultipartResolver">
        <beans:property name="defaultEncoding" value="UTF-8"></beans:property>
        <beans:property name="maxUploadSize" value="10485760"></beans:property>
        <beans:property name="maxUploadSizePerFile" value="2097152"></beans:property>
        <beans:property name="uploadTempDir" value="file:/C:/Users/cucup/Gogs/spring56/supload"></beans:property>
        <beans:property name="maxInMemorySize" value="1048576"></beans:property>
    </beans:bean>
```

- 자바 설정은 `com.hanulso.config.ServletConfig`에 가서 다음과 같이 해 준다. 당연히 XML 버전과 일치하는 부분이 보일 것이다.

```java
    @Bean(name = "multipartResolver")
    public CommonsMultipartResolver getResolver() throws IOException {
        CommonsMultipartResolver resolver = new CommonsMultipartResolver();
        resolver.setMaxUploadSize(10 * 1024 * 1024);
        resolver.setMaxUploadSizePerFile(2 * 1024 * 1024);
        resolver.setMaxInMemorySize(1024 * 1024);
        resolver.setDefaultEncoding("UTF-8");
        resolver.setUploadTempDir(new FileSystemResource("file:/C:/Users/cucup/Gogs/spring56/supload"));
        return resolver;
    }
```

## 스프링 MVC에서의 예외 처리

- `@ExceptionHandler`, `@ControllerAdvice`, `@ResponseEntity` 어노테이션을 이용한 예외 메세지를 구성할 수 있는데,
- 클래스 위의 `@ControllerAdvice` 어노테이션을 이용하면 예외를 분리하여 처리할 수 있다.
- 그러니까, 예외처리라는 공통된 관심사, 내지는 공통된 관점(aspect)을 중심(oriented)으로 프로그래밍한다 이 말이다. 그러니까 관점 지향 프로그래밍 == Aspect Oriented Programming; AOP가 여기서 적용되게 된다.
- 이 모든 게 작동을 하려면 당연히 스프링이 내 클래스를 인식하도록 해야겠지? 그래서 `component-scan` 속성을 설정 파일에 꼭 추가해 줘야 한다.
- `model.addAttribute()` == `request.setAttribute()`

```java
    @ControllerAdvice
    @Log4j2
    public class CommonExceptionAdvice {

        @ExceptionHandler(Exception.class)
        public String except(Exception ex, Model model) {
            log.error("Exception >>> " + ex.getMessage());
            model.addAttribute("exception", ex);
            log.error(model);
            return "error_page";
        }
    }
```

## 404 Not Found 에러도 처리해 보자

```java
    @ExceptionHandler(NoHandlerFoundException.class)
    @ResponseStatus(HttpStatus.NOT_FOUND)
    public String handler404(NoHandlerFoundException ex) {
        return "custom404";
    }
```
