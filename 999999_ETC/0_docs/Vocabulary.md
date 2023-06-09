﻿# 한국어-일본어(-후리가나) 코딩 용어 비교표

<details><summary><b>주의사항(클릭)</b></summary>

1. 전혀 정렬되어 있지 않습니다. 원하는 단어는 `Ctrl`+`F`로 찾아 주세요.
2. 일본도 사람 사는 곳이라 결국은 화면에 보이는 글자대로 읽게 됩니다. 하지만 구두로만 말했을 때 용어를 알아들을 수 있게 하려면 용어가 중요하겠죠.
    1. 한국도 일본도 코드 보고 얘기하다 보면 결국은 반쯤 영어 반쯤 모국어가 됩니다. 프로그래밍이라는 분야의 특성 상 무언가의 정의가 애매하면 꽤나 커뮤니케이션이 힘들기 떄문입니다.
    2. 일반적으로 일본의 코딩 교재 등에서 사용되는 표준 용어를 기준으로 했습니다만, 실무에서 쓸 일이 적은 용어도 존재할 수 있다는 겁니다.
3. 한국어와 일본어에서 쓰는 한자가 똑같은 용어의 경우 적지 않았을 수도 있습니다.
4. 각주도 눈여겨 보셨으면 좋겠...습니다?

</details>

| 한국어 | 일본어 | 후리가나 |
|---|---|---|
| 객체 | オブジェクト |～|
| 객체 지향 | オブジェクト指向 | おぶじぇくとしこう |
| 생성자 | コンストラクタ | ～ |
| 리턴 값 | 戻り値[^1] | もどりち |
| 메서드 | メソッド[^2] | ～ |
| 자료형 | データ型 | でーたかた |
| 접근 제한자 | アクセス修飾子[^3] | あくせすしゅうしょくし |
| 패키지 | パッケージ | ～ |
| 캡슐화 | カプセル化 | ～ |
| 예약어[^4] | 予約語 | よやくご |
| 매개변수 | 引数[^5] | ひきすう |
| 호출하다 | 呼び出す[^5] | よびだす |
| 변수 | 変数[^5] | へんすう |
| 전역 변수 | グローバル変数 | ぐろーばるへんすう |
| 인스턴스 변수[^6] | インスタンス変数 | いんすたんすへんすう |
| 지역 변수 | ローカル変数 | ろーかるへんすう |
| 멤버 변수 | メンバ変数[^10] | めんばへんすう |
| 상속 | 継承 | けいしょう |
| 부모 클래스[^7] | スーパークラス[^7]、親クラス | ～、おやくらす |
| 자식 클래스[^7] | サブクラス[^7]、子クラス | ～、こくらす |
| 오버로딩 | オーバーロード | ～ |
| 오버라이드 | オーバーライド | ～ |
| 추상 클래스 | 抽象クラス[^5] | ちゅうしょうくらす |
| 내부 클래스 | インナークラス[^8] | ～ |
| 인터페이스 | インターフェース | ～ |
| (인터페이스의)구현[^9] | 実装 | じっそう |
| 열거형[^5] | 列挙型 | れっきょがた |
| 정규표현식 | 正規表現 | せいきひょうげん |
| (대입문 또는 논리연산자의) 좌변, 우변 | 左辺、右辺 | さへん、うへん |
| <、> | 小なり、大なり | しょうなり、だいなり |
| 불리언, 진리값 | ブーリアン、真偽値 | ～、しんぎち |
| 구문 | 構文 | こうぶん |
| 중첩 구문 | 入れ子、ネスト | いれこ、～ |
| (배열의)인덱스 | 添え字 | そえじ |

[^1]: 返り値(かえりち)라고도 부름.
[^2]: 메, 솟, 도 이렇다. 메소-도 같은 게 아님에 주의. *Java 이외의 언어들에서는 함수(関数; かんすう)라는 말도 사용합니다. 구별하는 데엔 이유가 있는 모양인데 이해가 되진 않았습니다.*
[^3]: 액세스(접근) 수식자라는 뜻.
[^4]: 키워드(keyword; キーワード)라고도 한다.
[^5]: 한글 독음과 한자가 같음.
[^6]: 클래스 안에서 아무런 서술 없이 자료형만(`int speed`와 같은) 붙여서 정의하여, 클래스 객체가 생성되었을 때 같이 생성되는 변수. 전역 변수가 되려면 `public`이라는 접두어가 더 붙어야 한다.
[^7]: 어원이 되는 영어 단어는 각각 superclass, subclass. 이로 인해 한국어 자바에서도 상위 클래스/하위 클래스라 부르는 경우도 있다.
[^8]: 영어 표현인 inner class에서 그대로 음차.
[^9]: 영어로는 implication. 자바의 예약어는 `implicates`. *아직까진 이 단어를 광의적으로 実装라고 하는지 잘 모르겠어서 이렇게 표기했습니다.*
[^10]: 장음이 없음에 주의. *필드와의 차이는 몰?루*