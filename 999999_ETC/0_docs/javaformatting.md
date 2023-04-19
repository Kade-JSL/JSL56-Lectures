# 자바 코딩 맞춤법

- 2020년대 코딩의 키워드는 **협업**입니다.
    - 지나치게 단축하거나 제대로 된 맞춤법(컨벤션)을 지키지 않은 코드는 가독성이 떨어지고,
    - 가독성이 떨어지는 코드는 코드를 보는 동료 프로그래머의 일 능률을 저하시킵니다.
    - 협업 애플리케이션의 발전과 재택근무 트렌드 등으로 협업의 가치는 점점 더 증가하고 있습니다.
    - 이 때문에 맞춤법을 지켜서 코딩하는 것 역시 매우 중요하다고 할 수 있습니다.
- 이러한 맞춤법을 지키면서 코딩하는 행위를 **클린 코딩**이라고 합니다.
- 우리 모두 클린 코딩 수칙을 지켜서 읽기 좋은 코드를 만들어서 좋은 코드 리뷰를 받아보도록 합시다.

# 띄어쓰기

- `<`, `>`와 같은 부등호, 그리고 등호(`=`)의 앞뒤는 띄어 씁니다.
    
    ```java
    while (foo < bar) {
        int a = 0;
    } // good

    while(foo<bar){
    int a=0;
    } // bad
    ```

- `,`, `;` 뒤에는 띄어 씁니다.

    ```java
    int a, b; // good
    for (int i = 0; i < 10; i++) // good

    int a,b; // bad
    int a ,b; // bad
    for(int i = 0;i < 10;i++) // bad
    ```

- `()`이나 `[]`, `{}`과 같은 괄호가 같은 줄에 있을 때에는 붙여 씁니다.
    - `int[] arr = {1, 2, 3};`: good
        - `int[] arr = { 1, 2, 3 };`: bad
    - `for (int i = 0; i < 5; i++)`: good
        - `for ( int i = 0; i < 5; i++ )`: bad

# 중괄호(braces)

- 중괄호는 선언문과 같은 줄에서 열리고, 독립된 줄에서 닫힙니다.

    ```java
    for (int i = 0; i < foo; i++) {
        BarBar bar = new BarBar(baz, qux);
    } // good

    for (int i = 0; i < foo; i++)
    {
        BarBar bar new BarBar(baz, qux);}
    // bad
    ```

    ```java
    if (!foo) {
        bar = baz1;
    } else {
        bar = baz2;
    } // good

    if (!foo)
    { bar = baz1; }
    else
    { 
        bar = baz2;
    } // bad
    ```

# 들여쓰기(indentation)

- 중괄호 안쪽의 코드는 중괄호 바깥쪽 코드보다 한 탭 들여씁니다.

    ```java
    public class FooFoo {
        public static void main(String[] args) {
            System.out.print("barbar?");
        }
    } // good

    public class FooFoo {
        public static void main(String[] args) {
        System.out.pring("barbar?");
            }
    } // bad
    ```

- 개인적으로 가장 제가 보면서 신경쓰였던 류의 코딩이었습니다.

# 케이스

- 메서드 이름의 첫 글자는 반드시 소문자여야 합니다.
    - 이름이 단어 두 개 이상으로 이루어져 있다면, 두 개째의 단어부터는 단어의 첫 글자를 반드시 대문자로 써야 합니다.
    - 이는 변수에도 마찬가지로 적용됩니다.

        ```java
        public class FooFoo {
            public static int[] barBar() {
                int[] bazBaz = new int[1337];
                ...
            }
        }
        ```

    - 반면에 위와 같이 클래스의 이름은 첫 글자가 대문자, 두 번째 단어도 대문자죠.
    - 이와 같이 단어 첫 글자만 대문자인 케이스를 파스칼 케이스(`PascalCase`), 첫 단어는 전부 소문자면서 이후의 단어들의 첫 글자가 대문자인 케이스를 카멜 케이스(`camelCase`)라고 부릅니다.

# 적당하게 줄 띄우기(line break)

- 줄이 너무 빽빽해서 가독성이 떨어질 것 같을 때는 적당하게 빈 줄을 넣어 둡시다.

    ```java
    private String foo;
    private String bar;
    public void baz(int a) {
        MyClass myClass = new MyClass();
        OtherClass[] otherClassArr = myClass.doSomething(a);
        for (OtherClass o : otherClassArr) {
            o.setSomething(myClass.doAnother(o.getAnother()));
        }
    } // bad
    ```

    ```java
    private String foo;
    private String bar;

    public void baz(int a) {
        
        MyClass myClass = new MyClass();

        OtherClass[] otherClassArr = myClass.doSomething(a);

        for (OtherClass o : otherClassArr) {
            o.setSomething(myClass.doAnother(o.getAnother()));
        }

    } // good
    ```

- 줄이 너무 길어서 가독성이 떨어질 것 같을 때도 적당하게 줄을 띄워 줍시다.

    ```java
    MyClass myClass = MyClass.ofSomeFactoryMethod(new OtherClass(AnotherClassBuilder.setFoo(foo).setBar(bar).setBaz(baz).build()), parameterOne, parameterTwo, parameterThree);
    // bad
    ```

    ```java
    MyClass myClass = MyClass.ofSomeFactoryMethod(
        new OtherClass(AnotherClassBuilder
            .setFoo(foo)
            .setBar(bar)
            .setBaz(baz)
            .build()),
        parameterOne,
        parameterTwo,
        parameterThree    
    ); // good
    ```

- 상기와 같이 메서드의 인수끼리 같은 탭에, 체인되는 메서드들끼리 같은 탭에 정렬하는 것이 일반적입니다.

<!--
---

## Getting Started

Welcome to the VS Code Java world. Here is a guideline to help you get started to write Java code in Visual Studio Code.

## Folder Structure

The workspace contains two folders by default, where:

- `src`: the folder to maintain sources
- `lib`: the folder to maintain dependencies

Meanwhile, the compiled output files will be generated in the `bin` folder by default.

> If you want to customize the folder structure, open `.vscode/settings.json` and update the related settings there.

## Dependency Management

The `JAVA PROJECTS` view allows you to manage your dependencies. More details can be found [here](https://github.com/microsoft/vscode-java-dependency#manage-dependencies).
-->
