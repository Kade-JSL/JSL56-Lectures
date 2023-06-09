﻿#
### [221110 ←](/221011-221202_JAVA_BASICS/22-11/221110) | [→ 221115](/221011-221202_JAVA_BASICS/22-11/221115/)

# 이날 배웠던 것

- [소스 코드 폴더](/221011-221202_JAVA_BASICS/22-11/221114/javastudy/src)
    - controller
        - Main.java
    - dao
        - StudentDao.java
    - dto
        - Student.java
    - javastudy
        - Main.java
        - PackageAccess.java
    - service
    - utility


---

## ~~근데 있죠 왜 윈도우 탐색기가 탐색기인지 알아요?~~

- ~~옛날에 빌게이츠가 사업을 할 때 토머스라고 아주 성가신 친구가 있었대요~~
- ~~근데 이제 친구니까 토머스라고 안 하고 미국식 발음으로 탐이라고 했거든요?~~
- ~~기분나쁘니까 탐 새끼, 탐새끼, 탐샊이, 탐색기 이러다 보니까 탐색기가 됐대요!~~
- ~~깔깔깔깔~~
- ~~재밌으셨다면 구독이랑 좋아요 그리고 알림설정 부탁드릴게여~~

## 패키지(パッケージ)란?

- 자바에서 제공하는 여러 클래스 또는 인터페이스들의 특성을 고려하여 분류해 놓은 것
- 다른 언어에서는 라이브러리라 부르기도 한다
- JDK에 기본적으로 제공되는 패키지와 사용자가 작성한 클래스들을 관리하기 쉽도록 분류한 패키지가 있다.
- 장점
    - 같은 이름의 클래스나 같은 이름의 메서드들은 충돌이 일어나지만 패키지 단위로 구분해서 작성하면 충돌이 일어나지 않는다.
    - 패키지 단위로 클래스, 메서드, 변수 등의 접근 제한(=정보 은닉)(=캡슐화)을 할 수 있다.
- 다른 패키지의 클래스나 메서드를 사용하고 싶으면 그 패키지를 `import`해 와야 한다.

## 항상 자바 프로젝트엔 들어가는 `controller`, `dao`, `dto`, `utility` 패키지

- `controller`: 말 그대로 제어 패키지
- `dao`: Database Access Object, 데이터베이스와 연동을 하는 기능들을 담당하는 메서드와 클래스들을 넣어 두는 패키지
    - `INSERT`(등록), `MODIFY`(수정), `DELETE`(삭제), `SELECT`(목록)문 같은 DML 명령어들을 사용한다
    - Create, Read, Update, Delete를 모아서 CRUD 작업이라고도 한다.
- `dto`: Database Transfer Object, 데이터베이스에 뭔가를 등록할 멤버 변수와 그것들에 대한 변수를 넣어 두는 패키지
- `service`: 실제로 데이터베이스에 명령어를 넣는 메서드들
- `utility`: 기타 잡다한 메서드들

## 접근 제한자(アクセス修飾子; Access Modifier)

- == 정보은닉, == 캡슐화
- 클래스, 멤버 변수, 메서드에 각각 접근제한자를 설정할 수 있다.
- 자바의 가장 큰 특징 중 하나.

| 예약어 | 설명 |
|---|---|
| `private` | 같은 클래스 내에서만 접근 가능 |
| (없음) | 같은 패키지 내에서만 접근 가능 |
| `protected` | 같은 패키지 내, 또는 다른 패키지에서 이 클래스를 상속받은 클래스 내에서 접근 가능 |
| `public` | 접근 제한이 없음 |

- `private` < `(default)` < `protected` < `public`
- `private`의 경우 앞으로는 기본적으로 일단 붙이고 생각할 것이다.
- 접근이 제한된 멤버 변수는 특정 메서드에 의해서만 변경할 수 있다.

## `get`과 `set` 메서드

- 멤버 변수 값을 가져옴: getter 메서드
- 멤버 변수 값을 설정함: setter 메서드
- 사실 이름은 아무래도 상관없지만 컨벤션을 잘 지켜서 즐거운 개발!