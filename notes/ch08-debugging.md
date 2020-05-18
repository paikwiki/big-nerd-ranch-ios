# Chapter 8. Debugging

## 8.1. A Buggy Project

콘솔을 사용하여 디버깅하기

- 콘솔에 제공된 정보를 통해 코드 오류를 살펴보고, 프로그램의 종료(zero)를 알 수 있음

## 8.2. Debugging Basics

콘솔의 오류 메시지 예시

```sh
2020-05-18 15:10:22.552439+0900 Buggy[12764:221060] -[Buggy.ViewController buttonTapped:]: unrecognized selector sent to instance 0x7fc8cee0a610
2020-05-18 15:10:22.732638+0900 Buggy[12764:221060] *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '-[Buggy.ViewController buttonTapped:]: unrecognized selector sent to instance 0x7fc8cee0a610'
```

- `-[Buggy.ViewController buttonTapped:]`는 오브젝티브C 코드의 형태임
- 오브젝티브c의 메시지는 [receiver selector]의 형태로 대괄호([])를 사용함
- receiver: 메시지를 보낸 클래스 또는 인스턴스
- `-`는 전송자(receiver)가 ViewController의 인스턴스임을 가리킴
- `+`라면 클래스 자신임
- 다음 라인은 앱이 `uncaught exception`으로 종료됐으며, NSInvalidArgumentException으로서 예외의 유형을 지정함

Caveman debugging

- 콘솔에 메소드의 결과를 찍고 눈으로 직접 중요한 데이터를 확인하는 방법

Table 8.1 Literal expressions usefull for debugging

| Literal   | Type   | Value                                                  |
| --------- | ------ | ------------------------------------------------------ |
| #file     | String | The name of the file where the expression appears.     |
| #line     | Int    | The line number the expression appears on.             |
| #function | String | The name of the declaration the expression appears in. |

```swift
@IBAction func buttonTapped(_ sender: UIButton) {
    print("Called buttonTapped(_:)")
    print("Method: \(#function) is file: \(#file) line: \(#line) called.")
}
```

## 8.3. The Xcode Debugger: LLDB

NSRangeException

배열의 잘못된 인덱스를 참조할 때 발생

```sh
2020-05-18 16:21:00.792018+0900 Buggy[14500:277854] *** Terminating app due to uncaught exception 'NSRangeException', reason: '*** -[__NSArrayM removeObjectsInRange:]: range {0, 1} extends beyond bounds for empty array'
```

예외 중단점(exception breakpoint)

- 코드에 중단점을 설정하는 것이 아니라 중단점 내비게이터(breakpoint navigator)를 이용해 예외가 발생할 경우를 breakpoint로 설정할 수 있음
- 많은 개발자가 개발할 때 이 기능을 켜놓음

심볼릭 중단점(symbolic breakpoint)

- 심볼이 실행됐을 때를 breakpoint로 설정
- 심볼은 코드에 있든 프레임워크에 있든 상관없이 심볼이 호출되는 시점이 중단점
- 직접 작성한 코드보다는 `loadView()`처럼 애플 프레임워크 중 하나 안의 메서드를 중단할 때 주로 쓰임

LLDB

- 중단점이 활성화 됐을 때, 콘솔에 `(lldb)` 프롬프트에 명령어를 입력해 디버깅 가능
- `po` : print-object
- `p`: print
- `expr`: expression
