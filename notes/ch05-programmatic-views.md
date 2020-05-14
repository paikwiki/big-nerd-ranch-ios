# Chapter 5. Programmatic Views

## 5.1. Creating a View Programmatically

- MapViewController의 `loadView()`에서 MKMapView의 인스턴스를 생성해서 이 뷰 컨트롤러의 뷰로 활용함
- 뷰 컨트롤러가 생성된 시점의 `view` 속성은 `nil`

> 팁: 클래스를 활용하기 위해 특정 프레임워크/라이브러리가 필요한 경우
>
> 1. Project 화면으로 이동
> 2. "TARGETS"에서 프로젝트를 선택한 후 "Build Phases" 탭으로 이동
> 3. "Link Binary With Libraries" 항목의 `+` 기호 클릭
> 4. 원하는 프레임워크/라이브러리를 검색하여 추가
>
> 아래는 예전에 `WKWEBView`를 사용하기 위해 살펴봤던 자료
>
> - [How to Resolve “Couldn’t instantiate class named WKWebView” Error When Using WebKit](https://www.appcoda.com/wkwebview-error/)

## 5.2. Programmatic Constraints

- 애플은 가능하다면 인터페이스 빌더(Interface Builder)를 이용해 뷰를 생성하기를 권장함
- 코드를 작성해 뷰를 생성한 경우에는 제약(constraint)도 코드로 생성해야 함

UISegmentedControl

- MapViewController의 인터페이스
- 세그먼트 콘트롤은 여러 옵션중에 하나를 사용자가 선택할 수 있게 해줌: standard, hybrid, satellite map

오토리사이징 마스크(autoresizing masks)

- 오래된 시스템에서 사용하는 크기조절 인터페이스
- Auto Layout을 소개하기 전에, iOS 애플리케이션에서는 오토리사이징 마스크를 사용했음
- 실행 시점에 다양한 크기의 스크린에 맞춘 뷰를 제공하기 위해 사용
- iOS는 오토리사이징 마스크에 맞는 제약을 생성하고 이를 뷰에 추가함
- 이는 명시적으로 지정하는 제약과 충돌을 일으킬 있으므로 이 설정을 `false`로 지정할 수 있음

```swift
segmentedControl.translatesAutoresizingMaskIntoConstraints = false
```

앵커(Anchors)

- 제약을 생성하기 위해 사용.
- 다른 뷰의 앵커로 제한하고자 하는 속성(attr)에 해당하는 뷰의 속성(prop)

앵커의 `constraint(equalTo:)` 메서드

- 두 앵커간의 제약을 생성하는 메서드
- NSLayoutAnchor를 사용할 수도 있음

공통 부모요소(Common ancestor)

- 제약조건이 하나의 뷰에 연관돼있다면(가로 길이 제약처럼), 그 뷰는 공통 부모요소로 간주됨
- Anchors의 `isActive()`는 스스로 `addConstraint(_:)`와 `removeConstraint(_:)` 중 적절한 걸 골라서 수행함

```txt
/* F.5.3 Common ancestor */
  ╭─────╮
  │╳╳╳╳╳│
  ╰──┬──╯
  ╭──┴──╮
  │     │
  ╰──┬──╯
     ├────────┐
  ╭──┴──╮  ╭┬┬┼┬┬╮    ╭┬┬┬╮
  │     │  │┼┼┼┼┼│    │┼┼┼│ Items of
  ╰──┬──╯  ╰┴┴┴┴┴╯    ╰┴┴┴╯ constraint
     ├────────┐
  ╭┬┬┼┬┬╮  ╭──┴──╮    ╭───╮
  │┼┼┼┼┼│  │     │    │╳╳╳│ Common
  ╰┴┴┴┴┴╯  ╰─────╯    ╰───╯ ancestor
```

레이아웃 가이드(Layout guides)

- safe area: 인터페이스에서 사각형 형태로 나타낼 수 있는 전체 영역
- 뷰 인스턴스의 속성인 `safeAreaLayoutGuide`로 접근 가능

safe area에 뷰를 위치시키기 위해 코드 수정

```swift
// before
let topConstraint = segmentedControl.topAnchor.constraint(equalTo: view.topAnchor)
// changed
let topConstraint = segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
```

뷰의 layoutMargins 속성

- layoutMargins: UIEdgeInsets 인스턴스의 속성
- layoutMarginGuide: 제약을 추가할 때 사용

NSLayoutConstraint

- 명시적 제약
- NSLayoutConstraint 이니셜라이저는 두 개의 뷰 오브젝트의 두 레이아웃 속성을 사용하는 하나의 제약을 생성

NSLayoutConstraint 클래스의 상수로서 정의된 레이아웃 속성

- NSLayoutAttribute.left
- NSLayoutAttribute.right
- NSLayoutAttribute.leading
- NSLayoutAttribute.trailing
- NSLayoutAttribute.top
- NSLayoutAttribute.bottom
- NSLayoutAttribute.width
- NSLayoutAttribute.height
- NSLayoutAttribute.centerX
- NSLayoutAttribute.centerY
- NSLayoutAttribute.firstBaseline
- NSLayoutAttribute.lastBaseline

NSLayoutAttribute.leadingMargin

- 뷰와 관련해 마진을 조작하는 추가적인 속성

```txt
/* F.5.6 NSLayoutConstraint equation */
                         imageView.width = 1.5 * imageView.height + 0.0
                              ▲      ▲   ▲  ▲        ▲       ▲       ▲
                              │      │   │  │        │       │       │
NSLayoutConstraint(item: imageView   │   │  │        │       │       │
                  attribute: .width──╯   │  │        │       │       │
                  relatedBy: .equal──────╯  │        │       │       │
                  toItem: imageView─────────│────────╯       │       │
                  attribute: .height────────│────────────────╯       │
                  multiplier: 1.5───────────╯                        │
                  constant: 0.0)─────────────────────────────────────╯
```

## 5.3. Programmatic Controls

UISegmentedControl

- UIControl의 서브클래스(Ch01에서 UIButton 클래스도 UIControl의 서브클래스)

UIControl.Event

- UIControl.Event.touchDown: 컨트롤을 터치했을 때
- UIControl.Event.touchUpInside: 컨트롤을 터치한 후 영역 내에서 손을 뗐을 때
- UIControl.Event.valueChanged: 컨트롤 값이 변경의 원인이 되는 터치
- UIControl.Event.editingChanged: UITextField의 변경의 원인이되는 터치
- .touchDown보다는 .touchUpInside를 많이 씀

@objc 어노테이션

- Objective-C 런타임에 메서드를 노출해야할 필요가 있을 때 사용
