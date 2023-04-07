## [230316 ←](/230130-_Spring/230316/) | [→ 230320](/230130-_Spring/230320/)

---

## 실제로 객체를 주입해 보자

- 정말 그냥 멤버 변수로 선언만 하면, lombok이 관련 getter와 setter를 만들어 주고, Spring이 아무 객체 생성 없이 이 객체를 사용할 수 있게 해 준다.
- `@Setter(onMethod_ = @Autowired)` 어노테이션으로 더 확실하게 사용할 수 있다

## 클래스가 한 20개쯤 한 패키지에 있다 치자

- 스프링에서 이것들을 관리하도록 객체를 만들어 줘야 주입을 하든 말든 할 거 아닌가.
- 어제도 말했듯이 이렇게 관리되는 객체들을 빈(Bean)이라 부른다.
- 이 녀석들은 따로 객체를 생성하지 않아도 스프링에서 객체를 주입해 준다.
- 빈들은 /WEB-INF/spring/root-context.xml에서 관리한다.
  - XML로 설정할 경우에 그렇다.
- STS에서 root-context.xml에 제공하는 Namespaces 탭에서 추가할 기능도 선택할 수 있다.

```xml
<context:component-scan base-package="com.hanulso.sample"/>
```

- 위와 같이 하면 이제 저 패키지 안에 있는 모든 클래스들은 스프링에서 스캔한 뒤에 빈으로써 객체화하여 관리하게 된다. (@Component 어노테이션을 전부 넣는 것과 같음)

## 의존성이 주입되었는지 테스트해 보자

- 테스트 폴더는 /src/test/java이다.
- `@RunWith(SpringJUnit4ClassRunner.class)`로 불러와 준다.
- `@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")`을 이용해서 빈이 있는 경로가 있는 파일을 지정해 준다.
  - == 그 파일에 있는 패키지 경로에 있는 클래스들을 테스트 대상으로 두겠다
