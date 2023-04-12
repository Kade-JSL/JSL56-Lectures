## [230407 ←](/230130-_Spring/230407/) | [→ 230412](/230130-_Spring/230412/)

## JSON 데이터 받기

- Jackson Core 프레임워크만 사용하면 `@ResponseBody` 어노테이션 하나만으로 JavaBean 표준을 지키는 모든 객체를 싹 다 JSON으로 응답을 변환할 수 있습니다.
- `$.ajax()` 함수로 이 데이터를 받는다 치면 응답 객체 자체가 JSON 객체기 때문에, 매우 직관적으로 데이터를 파싱하는 것이 가능합니다.

    ```javascript
    const request = () => {
        $.ajax({
            url: "/sample/request",
            type: "post",
            dataType: "json",
            success: data => { // 우리 샘플 코드에선 JSONArray 타입의 응답이 돌아옴
                data.forEach(row => {
                    $("#something").append(data.name + ", " 
                        + data.age + ", " 
                        + data.job + "<br>"); // JSON 객체의 key 값을 바로 언급하면 됨
                    }
                );
            }
        });
    }
    ```

## 콜백 함수와 비동기 처리

- 마치 해리포터 책 이름 같다. 아래와 같은 코드가 있다고 생각해 보자.
    
    ```js
    const getData = () => {
        var tableData;
        $.get("url/products/1", response => {
            tableData = response;
        });
        return tableData;
    };

    console.log(getData());
    ```

- 기존의 사고방식대로 생각한다면 그냥 순서대로 실행이 돼서...
    1. `getData()` 함수가 선언문을 넘어 호출되고, 
    1. `tableData` 변수가 생성되고, 
    1. `$.get()` 함수가 호출되고,
    1. HTTP GET 응답으로 돌아온 `response`가 `tableData`에 들어가고, 
    1. 결과값으로 리턴이 되고,
    1. 그럼 함수의 처리가 완료되어 콘솔창에 데이터가 표시되어야 할 것이다.
- 하지만 현실은 다르다.
    1. `getData()`가 호출되는 건 같다.
    1. `tableData` 변수도 똑같이 생성된다.
    1. `$.get()`이 불러지긴 하지만, 이 함수가 비동기 함수라서 요청의 응답을 기다리지 않은 채로 그냥 다음 줄로 넘어가 버린다.
    1. `undefined`인 채로 `tableData`는 호출된 자리로 리턴된다.
    1. 결국에 콘솔에 출력되는 것은 `undefined`이다.
- 그러니까 비동기 함수라는 건, 호출만 해 놓고 실행 완료를 기다리지 않은 채(안쪽의 함수가 실행되기를 기다리지 않은 채) 다음 코드를 그대로 실행해 버리는 함수다 그 말이다.
- 이것을 방지하기 위해 콜백 함수가 존재한다. 

    ```js
    function getData(callbackFn) {
        $.get("url/products/1", function(response) {
            callbackFn(response);
        });
    };

    getData(function(tableData) {
        console.log(tableData);
    });
    ```

- 아까 전의 코드에서는 `$.get()`으로 `tableData`가 변한 '다음에' 리턴이 될 것으로 예상을 했지만, 이번 코드에서는 AJAX 요청이 비동기 요청인 것을 알기 때문에, 안쪽의 코드에서 콜백 함수가 실행되게 하였다.
- 이전과는 다르게 안쪽에서 실행된 콜백 함수는 반드시 함수에 넣을 인수가 들어갔을 때에만 실행됨을 알 수 있다. 즉 안쪽 함수의 실행 여부는 비동기 코드가 실행된 여부에 종속된다.


## REST 방식 요청

- URI에다가 처리 방식 + 처리하고자 하는 데이터를 담아서 보내는 것.
    - `GET`과 `POST` 외에도 `PUT`과 `DELETE` 방식이 있다.
    - `PUT`과 `DELETE`는 REST에서만 사용한다.
        - `POST`은 등록(Create)
        - `GET`은 조회(Read)
        - `PUT`은 수정(Update)
        - `DELETE`는 삭제(Delete)
- 그러니까 `[URL]?name=aaa&age=100`이렇게 담는 게 아니라, 