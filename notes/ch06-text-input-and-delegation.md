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

## 6.2. Implementing the Temperature Conversion

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

숫자 형식자(a number formatter)

- NumberFormatter의 인스턴스
- 날짜(dates), 에너지(energy), 질량(mass), 길이(length), 측정단위(measurements) 등

```swift
let numberFormatter: NumberFormatter = {
    let nf = NumberFormatter()
    nf.numberStyle = .decimal
    nf.minimumFractionDigits = 0
    nf.maximumFractionDigits = 1
    return nf
}()
```

> 궁금해요! 마지막의 `()`는 자바스크립트의 즉시실행과는 관련이 없는 듯?

## 6.3. Delegation

위임 패턴(the delegation pattern)

- 미리 정의된 이벤트가 아닌 이벤트를 제어할 때
- 리스닝하고 있는 오브젝트에 커스텀 메시지를 보내기 위한 컨트롤러를 만들기 위해 위임 패턴 사용
- 콜백(callbacks)을 이용하는(콜백에 대한?) 객체지향 접근방식 (Delegation is an object-oriented approach to __callbacks__.)

콜백(callbacks)

- 이벤트에 전달되는 함수로 이벤트가 발생할 때마다 호출됨
- 예시: 텍스트필드는 사용자가 텍스트를 입력하고 엔터를 입력했을 "때" 콜백이 필요함
- 둘 혹은 그 이상의 협력하고 정보를 공유하는 콜백 함수를 위해 내장된 방법(built-in way)이 없음
- 위 문제를 해결하기 위해 델리게이트가 필요

델리게이트(위임) 객체(delegate object)

- 특정 오브젝트를 위해 모든 이벤트와 연결된 콜백을 받기 위한 단일 델리게이트 객체(a single delegate)를 공급해야 한다.
- 이 위임 객체는 저장(store), 조작(manipulate), 실행(act on), 필요한 경우에는 콜백으로부터 정보 전달(relay the information from the callbacks)을 할 수 있음

모든 델리게이트 역할(delegate role)을 위해, 그 델리게이트에서 오브젝트를 호출할 수 있는 메서드를 선언하는 해당 프로토콜(corresponding protocol)이 있다.

프로토콜의 인스턴스는 생성할 수 없으며, 메서드와 속성 요구사항에 대한 목록이 있다. 요구사항의 구현은 프로토콜을 따르는 각 타입을 따른다. 또한 모든 프로토콜이 델리게이트 역할을 위한 건 아니다.

델리게이트 프로토콜(delegate protocols)

- 위임에 사용하는 프로토콜
- 네이밍 컨벤션: 위임하려는 클래스의 이름 + Delegate

델리게이트 프로토콜 예시

```swift
protocol UITextFieldDelegate: NSObjectProtocol {
  optional func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
  optional func textFieldDidBeginEditing(_ textField: UITextField)
  optional func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
  optional func textFieldDidEndEditing(_ textField: UITextField)
  optional func textField(_ textField: UITextField,
                      shouldChangeCharactersIn range: NSRange,
                      replacementString string: String) -> Bool
  optional func textFieldShouldClear(_ textField: UITextField) -> Bool
  optional func textFieldShouldReturn( _ textField: UITextField) -> Bool
}
```

- 프로토콜에서 선언된 메서드는 구현돼야만 함
- 프로토콜 작성자는 메서드를 위해 기본 구현을 옵셔널로 제공함
- UITextFieldDelegate는 모든 메서드가 옵셔널이여서 어떤 메서드 구현도 없이 사용할 수 있음. 이는 델리게이트 프로토콜의 전형적인 모습임
- 클래스 선언에서, 클래스가 따르는 프로토콜은 (있는 경우에는) 슈퍼 클래스 다음에 쉼표로 구분한 목록에 있음

프로토콜 선언 예시

```swift
class ConversionViewController: UIViewController, UITextFieldDelegate {
  ...
}
```

UITextFieldDelegate의 메서드 예시

- textFieldDidBeginEditing(_:): 텍스트필드를 사용자가 터치할 경우
- textField(_:shouldChangeCharactersIn:replacementString:): 변화를 수락/거절할 것인지에 대해 물어보는 델리게이트의 메서드를 호출. 반환값은 Bool

