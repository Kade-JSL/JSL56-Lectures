﻿#
### [221213 ←](/../221205-230127_JSP/22-12/221213/) | [→ 221215](/../221205-230127_JSP/22-12/221215/)

# 이날 배웠던 것

- [**다음날 할 내부평가 시험 문제 필기**](#제4회내부평가시험과목프로그래밍언어응용)
- [프로젝트 파일 폴더](/999999_ETC/3_project/jslhrdServlet/)
    - [**/src**](/999999_ETC/3_project/jslhrdServlet/src/): 이런저런 자바 소스
    - [**/WebContent**](/999999_ETC/3_project/jslhrdServlet/WebContent/): 이런저런 JSP 소스, HTML의 잔해들

---

## 프로젝트 웹페이지 기본 틀

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

<%@ include file="../footer.jsp"%>
```

##

# 제4회내부평가시험과목<프로그래밍언어응용>

## 실행 및 구현 방식에 따른 분류 체계

- 명령형 언어
- 함수형 언어
- 논리형 언어
- 객체지향형 언어
    - 상속, 캡슐화, 다형성, 추상화 등의 특징을 가지고 있다.

## 빌드 방식에 따른 분류 체계

- 컴파일 언어
- 인터프리터 언어
- 바이트코드 언어
- _어셈블리 언어는 없네?!_

## 컴파일 언어

- FORTRAN
- PASCAL
- C, C++
- _Python은 없네?!_

## 객체지향의 구성요소

- 객체
- 클래스
- 메시지
- _메서드는 없네?!_

## 프로그래밍 언어별 사용 용도

- AI/빅데이터 분석에 사용되는 언어
    - Python
    - R
        - _C 계열 언어이며 주로 통계에 사용됩니다._

## 코드 리뷰 기법

- **동료 검토**
    - 별도의 절차 없이 비공식적으로 계획 없이 임의적으로 실시되며, 개발자가 동료와 코드 및 산출물의 결함을 식별하는 기법
- **워크스루**
    - 개발자와 리뷰의 주제와 시간을 정해서 발표를 하고 동료들로부터 의견이나 아이디어를 듣는 시간을 가질 수 있으며, 사례에 대한 정보 공유나 아이디어 수집을 위해서 사용될 수 있다.
- **Inspection**
    - 역할과 절차, 체크리스트를 기준으로 결함을 식별하는 공식적인 리뷰 기법

## 리팩터링(Refactoring)

- SW의 **원래 기능은 유지**하면서 소스코드의 내부 구조를 수정 및 보완하여 **가독성, 성능 향상 및 로직을 개선**하는 방법

## 언어별 변수 선언 방식

- 일단 둘 다 _하이픈(`-`)은 사용할 수 없음_
- Java
    1. `_`(언더바) 또는 `$`, 또는 영문자로 시작
    1. 자바 예약어(자료형, 제어문, 반복문 등) 사용 불가
    1. 길이에 제한이 없고 자료형을 지정해 줘야 함
        - _요런 걸 강타입(strictly typed)이라고 합니다._
- Python
    1. 언더바 혹은 영문자로 시작
    1. 특수문자 및 공백 사용 불가
    1. 파이썬 예약어(제어문, 반복문 등) 사용 불가
    1. 자료형 생략 가능
        - _요런 걸 약타입(loosely typed)이라고 합니다._

## 반복문 적용 방법

```python
for i in range(3) :
    print(i)
# 0, 1, 2를 출력한다
```

```python
i = 0
while i <= 2 :
    print(i)
    i = i + 1
# 이것도 0, 1, 2를 출력한다
```

## Python 조건문

```python
if (x < 100) :
    print(x) # 들여쓰기는 반드시 할 것
```

## 싱글톤 패턴

- 설정 파일의 특정한 값과 같이 동일한 인스턴스를 참조할 때 하나의 인스턴스만 행성하여 처리함으로써 **자원을 효율적으로 사용할 수 있다**는 장점이 있다. 소스코드를 참조하여 **하나의 인스턴스로 처리가 가능한 경우**에는 싱글톤 패턴을 적용한다.
    - _하나면 하나지 둘이겠느냐_

## 스트래티지 패턴

- 사용자가 자신에게 맞는 전략(strategy)을 취사선택하여 로직을 수행할 수 있는 방법이다. 향후 확장성에 대한 고려가 필요한 경우 소스코드를 참조하여 스트래티지 패턴을 적용한다.

## 라이브러리의 구성

- 도움말
- 설치 파일
- 예시 코드(샘플 코드)
- _실행 파일은 없네?!_

## 자바 대표 외부 라이브러리

- Apache Commons
    - 자바로 구현된 라이브러리를 모은 프로젝트로 Codec, Compress, Collection, CSV, IO, Lang, Logging 등의 컴포넌트 제공

## 파이썬 대표 외부 라이브러리

- Pandas
    - 데이터 분석(Data analysis) 시 데이터의 수집, 조작, 분석을 위해 사용되는 라이브러리

## PyPI(Python Package Index) 모듈과 패키지 비교

- `pip install <package name>`: 패키지를 설치한다.

## 빌드 도구

- **빌드**: 소스 코드 파일을 컴퓨터에서 실행하는 독립 소프트웨어 가공물로 변환하는 과정
- **빌드 도구**: 프로젝트의 생성과 빌드, 배포 등의 작업을 위한 도구 

## 빌드 도구 비교

- Ant
    - XML 기반의 빌드 스크립트 작성, 자유롭게 빌드 단위 지정
    - 간단하고 사용하기 쉬우나 큰 프로젝트의 경우 스크립트 관리나 빌드 과정이 복잡
    - 생명주기(라이프사이클)를 갖지 않아서 각각의 결과물에 대한 의존관계 등을 정의
- Maven
    - XML 기반으로 작성되며 생명주기와 POM(Project Object Model) 도입
    - `pom.xml` 파일을 이용해 dependancy(의존성)를 추가하고 삭제하여 라이브러리를 관리
- Gradle
    - Ant와 Maven의 장점을 모아 작성되었으며 의존성 관리를 위한 다양한 방법 제공
    - 빌드 스크립트를 XML이 아닌 JVM에서 실행되는 스크립트 언어인 그루비(Groovy) 사용

## 파이썬 표준 라이브러리 적용 및 사용 코드 예시

- `from os import *`: os 모듈 전체를 불러오는 것은 동일하나 코드는 변수/함수만 사용