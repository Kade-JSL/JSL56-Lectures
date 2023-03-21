#
### [230317 ←](../../230130-_Spring/230317/) | [→ 230321](../../230130-_Spring/230321/)

## HikariCP

- Connection Pool 기법을 쉽게 구현할 수 있도록 만들어진 JDBC 프레임워크
- 다운로드 링크: [https://mvnrepository.com/artifact/com.zaxxer/HikariCP/2.7.4](https://mvnrepository.com/artifact/com.zaxxer/HikariCP/2.7.4)
- /webapp/WEB-INF/root-context.xml에 다음과 같이 추가해 준다.
```xml
<bean id="dataSource" 
    class="com.zaxxer.hikari.HikariDataSource" 
    destroy-method="close"
>
    <constructor-arg ref="hikariConfig"/>
</bean>
    
<bean id="hikariConfig"
    class="com.zaxxer.hikari.HikariConfig"
>
    <property name="driverClassName"
        value="oracle.jdbc.driver.OracleDriver"
    />
    <property name="jdbcUrl"
        value="jdbc:oracle:thin:@localhost:1521:xe"
    />
    <property name="username"
        value="kade01"
    />
    <property name="password"
        value="1234"
    />
</bean>
```

## DataSource란?

- DB와 관련된 연결 정보를 담고 있으며 빈으로 등록하여 인자로 넘겨 주고
- 스프링은 DataSource 빈을 통해 DB와의 연결을 취득한다.
    - DB 서버와의 연결 성립
    - 커넥션 풀링 사용 가능

## DataSource를 스프링에 등록하고 주입하는 법

- Property를 설정해 준다. 위에 쓴 코드처럼.
- 저렇게 되면 DataSource가 스프링 JDBC를 통해서 빈으로 등록이 된다
- 그리고 이렇게 생성된 빈을 스프링 JDBC에 주입해 준다는 것.

## root-context.xml이 아니라 RootConfig.java에서는...

```java
...
public DataSource dataSource() {
    HikariConfig hikariConfig = new HikariConfig();
    
    hikariConfig.setDriverClassName("oracle.jdbc.driver.OracleDriver");
    hikariConfig.setJdbcUrl("jdbc:oracle:thin:@localhost:1521:xe");
    hikariConfig.setUsername("kade01");
    hikariConfig.setPassword("1234");
    
    HikariDataSource dataSource = new HikariDataSource();
    
    return dataSource;
}
...
```

## MyBatis

- 자바에서의 RDBMS 프로그래밍을 좀 더 쉽게 할 수 있게 도와주는 개발 프레임워크
- JDBC를 통해 데이터베이스에 액세스하는 작업을 캡슐화
- SQL 쿼리 및 저장 프로시저, 고급 매핑을 지원
- 모든 JDBC 코드 및 매개변수의 중복작업을 제거
- SQL 쿼리들을 한 구성파일에 구성하여 프로그램 코드와 SQL을 분리할 수 있게 된다
- Connection이든 PreparedStatement이든 ResultSet이든 싹 다 스프링에서 관리해 준다