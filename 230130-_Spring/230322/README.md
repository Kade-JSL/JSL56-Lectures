#
### [230321 ←](../../230130-_Spring/230321/) | [→ 230323](../../230130-_Spring/230323/)

## 스프링 MVC

1. controller 패키지로 요청이 보내지면
1. service 패키지에서 요청을 mapper로 보낸다
1. mapper는 DB 결과를 service로 보낸다
1. service는 결과를 domain의 VO 형태로 controller로 보낸다
1. controller가 최종적으로 결과를 JSP에 보낸다

## /webapp/WEB-INF/spring/appServlet/servlet-context.xml

- 또는 ServletConfig 같은 이름을 만들어서 AbstractAnnotationConfigDispatcherServletInitializer의 getServletConfigClasses() 메서드에 WebMvcConfigurer 타입을 돌려주면 된다.
- WebMvcConfigurer 안에서 이제 servlet-context.xml에 있는 것과 같은 설정을 해 주면 된다.
```java
@EnableWebMvc // 스프링이 WebMvc와 관련된 클래스라고 인식한다
@ComponentScan(basePackages = {"com.hanulso.controller"})
public class ServletConfig implements WebMvcConfigurer {
	
	@Override
	public void configureViewResolvers(ViewResolverRegistry registry) {
		InternalResourceViewResolver bean = new InternalResourceViewResolver();
		
		bean.setViewClass(JstlView.class);
		bean.setPrefix("/WEB-INF/views");
		bean.setSuffix(".jsp");
		registry.viewResolver(bean);
	}
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");
	}
}
```

## SpringMVC의 흐름

1. 서블릿에게 URL로 접근하여 해당 정보를 요청
1. DispatcherServlet이 HandlerMapping에 해당 요청을 매핑한 Controller가 있는지 검색 요청
1. Controller가 클라이언트의 요청을 처리하고 결과를 보여줄 View의 이름을 DispatcherServlet에 리턴함
    - 이 과정에서 Model 등을 통해서 DB와 통신하지만 이건 SpringMVC와는 관계 없음
1. DispatcherServlet은 받은 View 이름을 ViewResolver에 보내서 View를 검색하게 함
1. ViewResolver가 검색 결과를 View에 보냄
1. View의 처리결과를 DispatcherServlet에 보냄
1. DispatcherServlet이 최종 결과를 출력
- 요약하자면 web.xml -> root-context -> servlet-context 순서로 설정이 불린다 그 말이다.