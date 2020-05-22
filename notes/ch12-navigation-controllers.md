# Chapter 12. Navigation Controllers

드릴다운 인터페이스(drill-down interface)

- 정보를 여러개의 연관된 스크린에서 공유하는 경우를 이야기함(예: 환경설정 앱)
- UINavigationController를 이용해 드릴다운 인터페이스를 구현할 것임

## 12.1. UINavigationController

네비게이션컨트롤러(UINavigationController)

- 스택의 연관된 정보를 보여주기 위한 뷰 컨트롤러의 배열을 관리하는 컨트롤러
- UIViewController가 스택의 가장 높은 위치에 있을 때, 그에 해당하는 뷰가 화면에 노출됨

UINavigationController의 인스턴스를 초기화할 때, 그 컨트롤러에 UIViewController를 부여한다. 이 뷰 컨트롤러는 네비게이션 컨트롤러의 뷰 컨트롤러 배열에 추가되고, 네비게이션 컨트롤러의 루트 뷰 컨트롤러가 된다. 루트 뷰 컨트롤러는 항상 스택의 가장 아래에 위치한다(루트 뷰 컨트롤러라고 부르긴 하지만, UINavigationController는 `rootViewController` 프로퍼티를 갖고 있지 않다).

UINavigationController의 `topViewController` 프로퍼티

- 스택의 최상단에 뷰 컨트롤러의 참조를 저장

## 12.2. Navigating with UINavigationController

뷰 컨트롤러가 다음 뷰 컨트롤러를 푸시(push)하는 건 일반적인 패턴이다. 루트 뷰 컨트롤러가 일반적으로 다음 뷰 컨트롤러를 생성하고, 그 뷰 컨트롤러가 그 다음의 뷰 컨트롤러를 생성하는 형태로 이어진다. 어떤 앱은 뷰 컨트롤러가 사용자의 인풋에 따라 각기 다른 뷰 컨트롤러를 보여주기도 한다(예시: 사진앱에서 선택에 따라 사진뷰와 비디오뷰를 선택해서 보여준다).

## 12.3. Appearing and Disappearing Views

- `viewWillDisappear(_:)`: UIViewController가 스택에서 빠져나갈때 호출
- `viewWillAppear(_:)`: UIViewController가 스택의 최상단에 노출될 때 호출

## 12.4. Dismissing the Keyboard

first responder

- 많은 뷰와 컨트롤들은 뷰 계층구조 내에 firts responder가 될 수 있음
- 그러나 한번에 한 개만 가능함
- UIResponder 클래스와 responder chain을 포함하고 있는 코코아 터치 프로그래밍안의 이벤트 핸들링의 폭넓은 주제들 중에 하나임

텍스트필드나 텍스트뷰가 first responder가 되면 키보드 이벤트가 트리거된다.

`resignFirstResponder()`로 키보드 이벤트를 해제할 수 있다.

## 12.5. UINavigationBar

모든 UINavigationController는 UINavigationItem 타입의 navigationItem 프로퍼티를 갖는다. UINavigationBar와 달리, UINavigationItem은 UIView의 서브클래스가 아니다.

아이템 페이지의 UINavigationItem에 타이틀 적용하기

```swift
var item: Item! {
  didSet {
    navigationItem.title = item.name
  }
}
```

UINavigationItem의 수정 가능한 영역

- leftBarButtonItem
- rightBarButtonItem
- titleView

left/rightBarButtonItem은 UIBarButtonItem의 인스턴스의 참조이다. UIBarButtonItem은 UINavigationBar 또는 UIToolbar에서만 출력할 수 있는 버튼을 위한 정보를 담고 있다.

Bar 버튼 아이템은 UIControl의 타겟-액션 메커니즘과 같은 타겟-액션 쌍을 갖는다: 텝이 일어나면, 이 메카니즘은 타겟에게 액션 메시지를 보낸다.
