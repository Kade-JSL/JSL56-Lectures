#

## [230329 ←](../../230130-_Spring/230329/) | [→ 230331](../../230130-_Spring/230331/)

## 다시 한 번 짚어보는 스프링 MVC의 흐름

1. 요청이 오면 controller에서 받음
1. controller에 들어온 요청에 따라 service에서 데이터 가공 등을 함
1. service는 mapper를 통해 MyBatis와 연동된 데이터베이스의 CRUD 작업을 한다
1. mapper는 결과를 service에 돌려준다
    - 당연히 그럼 service에는 mapper의 객체가 주입되어 있어야 한다.
1. service는 결과를 controller에 돌려준다
    - 당연히 그럼 controller에는 service의 객체가 주입되어 있어야 한다.
1. controller는 결과를 JSP로 출력한다

## 그럼 이 패키지들을 실제로 구현해 보자

- service와 mapper 모두 인터페이스의 가상 메서드 형식으로 작업에 대한 정의를 만들어 둔다.
- MyBatis 기억한다면 알겠지만 mapper에 가상 메서드를 만들어 주고 어노테이션으로 적절하게 처리만 해 주면 알아서 메서드가 실행이 된다.
- resource 폴더 안에 같은 경로로 폴더를 만든 다음 인터페이스와 같은 이름으로 XML 파일을 만든다.
  - 이 때 이클립스 설정에서 DTD 파일을 이용하여 XML을 만들기로 한 다음, MyBatis의 DTD Mapper를 지정해 준다. 예전에 설정헤 뒀었다.
  - `mapper` 태그의 `namespace` 속성에 이렇게 만든 인터페이스의 경로를 지정해 준다.
- 설정이 제대로 되었다면, service에서 해당 메서드를 호출했을 때 XML 매퍼 파일 안에 있는 `id` 속성의 값이 그 메서드의 이름인 `insert` 태그가 실행된다.
  - 어... 그러니까 `INSERT` 명령어를 실행할 경우에 말이다.

## 사용례

- `com.kadeportfolio.mapper.PiecesMapper`

    ```java
    public void insertPiece(PiecesVO vo);
    ```

- `PiecesMapper.xml`

    ```xml
    <mapper namespace="com.kadeportfolio.mapper.PiecesMapper">
        <insert id="insertPiece">
            <selectKey keyProperty="pno" order="BEFORE" resultType="int">
                SELECT pno_seq.nextval FROM dual
            </selectKey>
            INSERT INTO p1_pieces (pno, uno, title, content, tblname) 
            VALUES (#{pno}, #{uno}, #{title}, #{content}, #{tblname})
        </insert>
    </mapper>
    ```

  - `selectKey`: INSERT 명령어를 실행하기 전에(`order="BEFORE"`) `SELECT ...`를 실행하고, 이 값을 `resultType`에서 지정한 형태로 저장하여 `keyProperty`에서 지정한 필드에 넣는다.

- `c.k.domain.PiecesVO`

    ```java
    @Data
    public class PiecesVO {
      
        int pno;
        int uno; 
        String title;
        String content;
        String regdate;
        int viewcount;
        int likecount;
        String tblname;
      
    }
    ```

- 보듯이 기존에 우리가 POJO로 진행하던 conn, pstmt, pstmt.get뭐뭐 같은 걸 한 톨만큼도 하지 않는다. 정말 그냥 스프링이 다 알아서 해 주는 거다.

## 그럼 service 패키지로 옮겨가면

- 똑같이 인터페이스와 가상 메서드 형태로 코딩한다. 하지만 메서드 이름 컨벤션은 약간 다를 필요가 있다. 왜냐면 관점이 다르니까.
- 예컨대 INSERT 명령어를 하게 만드는 메서드라면 직접 DB에 이 메서드가 접근하는 게 아니기 때문에, 약간의 구별을 짓기 위해서 insert...가 아니라 register... 같은 이름을 짓는 것이다.
- 그리고 같은 패키지에 ...Impl이라는 실제 클래스를 만들어 주고, 메서드를 오버라이딩해 주면 된다.
- mapper와 controller 사이에 있다는 걸 스프링에게 알려 줘야 하기 때문에 `@Service` 어노테이션을 붙여 준다.
- mapper의 객체가 필요하다면 주입해 준다. 신기한 mapper에 있는 건 인터페이스뿐인데도 불구하고 그냥 스프링이 알아서 뭐 구현을 했던지 뭐 했던지 해서 주입시켜 준다.
- 돌려줄 값이 없다면 그냥 호출된 곳으로 돌아갈 뿐. 이건 POJO에서도 마찬가지인 이야기이다.

## controller

- 서블릿의 `response.sendRedirect()`는 스프링MVC에선 리턴 값 문자열 앞에 `redirect:`를 붙여 준다.
- `@AllArgsConstructor`: 주입된 모든 객체의 생성자를 실행시킨다.
- VO 객체만 인수로 받아 주면 요청에서 알아서 찾아서 삽입해 준다.
- 어때요, 참 쉽죠?
