# Chapter 18. Custom Controls

## 18.1. Creating a Custom Control

접근 제어(access control)

- open: 클래스에 사용. 프레임워크나 서드파티 라이브러리 작성자가 활용. 클래스, 프로퍼티, 메서드 모두에 접근 가능 open 클래스는 서브클래싱이 가능하며, open 메소드는 모듈 밖에서도 오버라이딩 가능
- public: open과 비슷하지만, 퍼블릭 클래스와 퍼블릭 매서드는 모듈 내에서만 서브클래싱/오버라이딩 가능
- internal: 가본 레벨. 이 자료형과 프로퍼티, 메소드에 현재 모듈에 어떤 것이든 접근 가능. 만약 서드파티 라이브러리 내에서 internal을 쓰면 이를 사용하는 앱은 이를 사용할 수 없음
- fileprivate: 동일한 소스 파일 내의 어떤 것이든 이 자료형과 프로퍼티, 메서드를 사용할 수 있음
- private: 닫혀진 스코프 내의 어떤 것이든 이 자료형과 프로퍼티, 메소드에 접근할 수 있음

`sendActions(for:)`

버튼이 클릭됐을 때, 컨트롤은 자신의 값이 변경됐다는 신호를 필요로 한다. 이를 위해 `sendActions(for:)` 메소드를 콘트롤에 붙이고 이벤트가 발생하면 해당 이벤트에 대한 타입을 전달한다.

```swift
@objc private func imageButtonTapped(_ sender: UIButton) {
  guard let buttonIndex = imageButtons.firstIndex(of: sender) else {
    preconditionFailure("The buttons and images are not parallel")
  }

  selectedIndex = buttonIndex
  sendActions(for: .valueChanged)
}
```

## 18.2. Using the Custom Control

코드를 이용해 뷰(ImageSelector)를 작성하고 이를 컨트롤러에 연결하는 내용이다. 이런 방식을 주로 사용하게 될 것 같으니 필요할 때를 대비해 메모해둔다.

## 18.3. Updating the Interface

챕터 18.2와 연결된 내용으로 기존의 스택뷰를 제거하고 커스텀 뷰를 붙이는 과정이다.

## 18.4. Adding the Highlight View

작성할 내용 없음
