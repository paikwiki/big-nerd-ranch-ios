# Chapter 17. Extensions and Container View Controllers

## 17.1. Starting Mandala

지금까지 만들었던 모든 자료형(types)은 클래스였고, 거의 다 코코아 터치 서브클래스(Cocoa Touch subclasses)였다.

Custom types

- struct를 이용해 커스텀 자료형을 사용해볼 것임

## 17.2. Extensions

코드를 작성하는 방법으로 에셋에 접근하면 버그가 발생하기 쉽다. 리소스를 구별하기 위해 문자열 대신 정적 변수(static variable)을 사용하면 실수를 방지할 수 있다.

익스텐션(extension)

- 논리적 단위(logical unit)안으로 기능을 그룹지을 수 있게 함
- 시스템이나 다른 프레임워크로부터 공급받은 자료형 뿐만 아니라 개발자가 작성한 클래스, 구조체, 열거형에 기능을 추가할 수 있게 해줌
- 가독성을 높일 수 있으며 관련 기능을 그룹화하여 코드 베이스를 장기간 유지보수할 수 있게 해줌

```swift
let fourteen = 7.doubled // The value of fourteen is '14'

extension Int {
  var doubled: Int {
    return self * 2
  }
}
```

`UIColor+Mandala.swift`

- 확장하고자 하는 자료형(`UIColor`) 뒤에 `+` 부호를 붙이고 익스텐션에 대한 설명을 붙이면 해당 자료형에 대한 익스텐션을 만들 수 있다.

```swift
// UIColor+Mandala.swift
import UIKit

extension UIColor {

  static let angry = UIColor(named: "angryRed")!
  static let confused = UIColor(named: "confusedPurple")!
  static let crying = UIColor(named: "cryingLightBlue")!
  static let goofy = UIColor(named: "goofyOrange")!
  static let happy = UIColor(named: "happyTurquoise")!
  static let meh = UIColor(named: "mehGray")!
  static let sad = UIColor(named: "sadBlue")!
  static let sleepy = UIColor(named: "sleepyLightRed")!

}
```

## 17.3. Creating a custom container view controller

컨테이너 뷰 컨트롤러(Container view controllers)

- 앱의 기능을 더 작은 단위로 분할할 수 있어서 코드베이스 유지보수의 용이성과 유연함을 얻을 수 있음
- UITabBarController와 UINavigationController도 컨테이너 뷰 컨트롤러

Visual Effect View with Blur

- 아래에 있는 뷰가 블러 효과가 적용된 것처럼 비쳐서 보이는 뷰

Property observer

- 앱에서 무드(moods)가 설정됐을 때 버튼에 각각의 무드에 해당하는 텍스트를 출력하기 위해 사용

```swift
var moods: [Mood] = [] {
  didSet {
    moodButtons = moods.map { mood in
      moodButton.setImage(mood.image, for: .normal)
      moodButton.imageView?.contentMode = .scaleAspectFit
      moodButton.adjustsImageWhenHighlighted = false
      return moodButton
    }
  }
}

var moodButton: [UIButton] = [] {
  didSet {
    oldValue.forEach { $0.removeFromSuperview() }
    moodButtons.forEach { stackView.addArrangedSubview($0) }
  }
}
```

클로저 내부의 `$0`은 클로저의 인자에 접근하는 축약 표현
