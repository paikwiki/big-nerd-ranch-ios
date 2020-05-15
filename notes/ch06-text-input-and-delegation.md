# Chapter 6. Text Input and Delegation

## 6.1. Text Editing

UITextField

- iOS 시뮬레이터는 개발하고 있는 맥의 키보드를 시뮬레이터가 띄운 가상아이폰에 블루투스로 연결된 키보드로 인식함.
- 이를 해결하기 위해서 `UITextInputTraits`를 호출해 Keybard Type를 Decimal Pad로 변경해야함.
- `UITextInputTraits`는 UITextField의 속성이므로 스토리보드에서 UITextField의 속성창에서 수정할 수 있음

기본 액션

- 버튼의 기본 이벤트는 `.touchUpInside`
- 세그먼티드 콘트롤(segmented control, 탭바를 의미하는 듯)의 기본 이벤트는 `.valueChanged`
- 텍스트 필드의 기본 이벤트는 `.editingDidBegin`

조건문의 && 연산

- 콤마(,)로 연결하면 `&&` 연산으로 수행함

```swift
if let text = textField.text, !text.isEmpty {
    celsiusLabel.text = text
} else {
    celsiusLabel.text = "???"
}
```

텍스트 필드를 탭하는 동작 관련

- `becomeFirstResponder()`: 텍스트 필드를 탭하면 호출되는 메서드, 키보드가 노출됨
- `resignFirstResponder()`: 키보드를 감추는 역할을 하는 메서드

UITapGestureRecognizer

- 사용자가 백그라운드 뷰를 선택하는 이벤트를 감지하기 위해 WorldTrotter 앱에서 사용할 제스처 감지(recognizer)

속성 감시자(a property observer)

- 속성의 값이 변했을 때 호출할 코드
- 속성 감시자는 속성을 선언한 바로 뒤에 중괄호({})와 함께 선언한다.
- `didSet`과 `willSet` 사용 가능

```swift
var fahrenheitValue: Measurement<UnitTemperature>? {
    didSet {
        updateCelsiusLabel()
    }
}
```

> 궁금해요! 왜 `didSet`과 `willSet`에는 중괄호({})를 쓰는 걸까?

## 6.2. Implementing the Temperature Conversion

## 6.3. Delegation
