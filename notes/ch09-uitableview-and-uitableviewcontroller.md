# Chapter 9. UITableView and UITableViewController

UITableView

- View 오브젝트
- 여러 행의 데이터로 구성된 하나의 칼럼

## 9.1. Beginning the LootLogger Application

새 프로젝트 생성

## 9.2. UITableViewController

MVC 패턴

- 모델(model): 데이터를 갖고 있으며 UI에 대해서는 모름
- 뷰(view): 사용자에게 보여지며, 모델 오브젝트에 대해서는 모름
- 컨트롤러(controller): UI와 모델 오브젝트가 동기화되도록 유지하며, 애플리케이션의 흐름을 조작(controll)함

UITableView는 View 오브젝트이므로 애플리케이션의 로직 또는 데이터를 다루진 않음

UITableView를 사용할 때, 테이블이 잘 동작하도록 하기 위해 고려해야할 것들

- UITableView는 보통 출력할 화면을 조작하기 위해 뷰 컨트롤러가 필요함
- UITableView는 데이터 소스를 필요로 함(출력할 행의 수, 각 행에 출력할 데이터 또는 UITableView를 유용한 UI로 만들기 위한 기타 소스). 데이터가 없다면 테이블 뷰는 빈 컨테이너일 뿐임. UITableView의 데이터소스는 UITableViewDataSource 프로토콜에서 정의하는 어떤 형태의 오브젝트든 가능함
- UITableView는 보통 UITableView에 관련한 이벤트를 다른 오브젝트에 알리기 위한 델리게이트를 필요로 함. 델리게이트는 UITableViewDelegate 프로토콜에서 정한 어떤 오브젝트든 될 수 있음

UITableViewController 클래스의 인스턴스는 3가지 역할을 모두 채워야 함

- 뷰 컨트롤러
- 데이터 소스
- 델리게이트

UITableViewController

- UIViewController의 서브클래스. 따라서 뷰를 가짐
- UITableViewController의 뷰는 항상 UITableView의 인스턴스
- UITableViewController는 UITableView를 준비하고, 출력하는 일을 수행
- UITableViewController가 자신의 뷰를 생성하면, UITableView의 dataSource와 delegate 속성은 자동으로 UITableViewController를 가리킴

```txt
                        ╭┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄╮  ╭┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄╮
                        ┊ UITableViewDataSource ┊  ┊ UITableViewDelegate ┊
                        ╰┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄╯  ╰┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄╯
                                          ▲            ▲
                                          ┊            ┊
                                     conforms to  conforms to
                                          ┊            ┊
  ╭─────────────╮                    ╭────┴────────────┴─────╮
  │ UITableView ├┄┄┄┄┄ dataSource ┄┄▶︎│ UITableViewController │
  ├─────────────┼┄┄┄┄┄┄┄ delegate ┄┄▶︎├───────────────────────┤
  │             │◀︎── view ───────────┤                       │
  │             │◀︎── tableView ──────┤                       │
  ╰─────────────╯                    ╰───────────────────────╯
```

## 9.3. Creating the Item Class

이니셜라이저의 종류

- 설계된 이니셜라이져(designated initializers)
- 편리한 이니셜라이져(conveience initailizers)

Designated initializer

- 클래스의 primary 이니셜라이져
- 클래스의 모든 속성의 값을 입력해야 함
- 모든 값이 입력되면 해당 클래스의 슈퍼클래스의 designated initializer를 호출함

모든 클래스는 설계된 이니셜라이져를 반드시 가져야하지만 컨비니언스 이니셜라이저는 선택적으로 구현할 수 있다.

## 9.4. UITableView's Data Source

Cocoa Touch

- iOS 앱을 빌드하는데 사용하는 프레임워크의 집합

코코아 터치에서 테이블 뷰는 또다른 오브젝트인, 자신의 dataSource에세 출력할 데이터를 요청함(ItemsViewController가 데이터 소스이므로 아이템 데이터를 저장할 방법이 필요함)

```txt
┌┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┐
┆ Views                                                                        ┆
┆      ╭─────────────╮                                                         ┆
┆      │ UITableView │  subviews  ╭──────────╮  ╭─────────────╮                ┆
┆      ├─────────────┼───────────▶︎│ [UIView] ├─▶︎│ UITableView │                ┆
┆      │             │            ╰──────────╯  ├─────────────┼┄┄┄┄┄┄┄╮        ┆
┆      ╰─────────────╯                      ╭──▶︎╰───────────┬─╯       ┆        ┆
┆              ▲                            │     ▲         ┆         ┆        ┆
├┄┄┄┄┄┄┄┄┄┄┄┄┄┄│┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄│┄┄┄┄┄│┄┄┄┄┄┄┄┄┄┆┄┄┄┄┄┄┄┄┄┆┄┄┄┄┄┄┄┄┤
┆ Controllers  │                     tableView  view    dataSource  delegate   ┆
┆             window                        │     ╰─╮    ╭┄┄╯     ╭┄┄┄╯        ┆
┆              │                            ╰──────╮│    ▼        ▼            ┆
┆    ╭─────────┴───╮                           ╭───┴┴────────────────╮         ┆
┆    │ AppDelegate │                           │ ItemsViewController │         ┆
┆    ├─────────────┤                           ├─────────────────────┤         ┆
┆    │             │                           │                     │         ┆
┆    ╰─────────────╯                           ╰─────────────────────╯         ┆
├┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┤
┆ Model                                     ╭─────────────╮                    ┆
┆  ╭─────────────╮                          │  [Item]     │                    ┆
┆  │ ItemStore   ├─────────────────────────▶︎├──╭─────────────╮                 ┆
┆  ├─────────────┤        allItems          ╰──│╭─────────────╮                ┆
┆  ╰─────────────╯                             ├│╭─────────────╮               ┆
┆                                              ╰├│  Item       │               ┆
┆                                               ╰├─────────────┤               ┆
┆                                                ╰─────────────╯               ┆
└┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┘
```

ItemStore라는 또다른 객체를 만들어서 Item 인스턴스를 담고있는 배열을 추상화

@discardableResult 어노테이션

- 이 함수의 호출자(caller)는 이 함수 호출의 결과를 자유롭게 무시할 수 있음을 의미

예시

```swift
// This is OK
let newItem = itemStore.createItem()

// This is also OK; the result is not assigned to a variable
itemStore.createItem()
```

SceneDelegate

- SceneDelegate.swift에 선언
- 애플리케이션의 화면들을 위한 델리게이트를 제공

"Scene"

- 인터페이스 빌더에서 사용하는 용어
- 사용자들은 앱의 UI 인스턴스를 "Windows"라고 부르지만 UIWindow의 인스턴스가 아님
- 혼란을 방지하기 위해 인터페이스 빌더와 iOS SDK는 애플리케이션의 UI를 "scenes"라고 부름
- scene은 UIScene(보통은 UIScene의 서브클래스인 UIWindowScene)의 인스턴스

의존성 역전 원칙(the dependency inversion principle)

1. 하이레벨(High-level) 오브젝트는 로우레벨(low-level) 오브젝트에 의존하지 않는다.
2. 추상화(Abstrations)는 세부(details)에 의존하지 않는다. 세부는 추상화에 의존한다.

의존성 주입(the dependency injection)

## 9.5. UITableViewCells

UITableViewCells

- 테이블 각 행의 뷰의 인스턴스는 UITableViewCells의 인스턴스
- 컨텐츠 뷰(content view)와 악세사리 뷰(accessory view)를 가짐

Reusing UITableViewCells

- 모든 셀은 String 자료형의 `reuseIdentifier` 속성을 가짐
- 기본적으로 reuse identifier는 셀 클래스의 이름을 보통 사용함

`dequeueReusableCell(withIdentifier:for:)`

- reuse identifier 체크. reusable cell이 있을 경우 가져옴("dequeue"). 없을 경우에는 새로운 셀을 생성해서 반환함

## 9.6. Editing Table Views

UITableView는 편집 속성을 갖고 있어서 true로 설정된 경우, 편집 모드로 들어갈 수 있다.

헤더 뷰(header view)

- UIView의 인스턴스
- 테이블 상단에 보이며, 섹션 또는 테이블 넓이의 타이틀과 콘트롤(버튼)을 추가할 수 있음
- 테이블의 헤더 또는 섹션의 헤더일 수 있음

셀 삭제시: UITableView의 row와 ItemStore의 Item 두 가지를 삭제해야함

## 9.7. Design Patterns

디자인패턴

- 일반적인 소프트웨어 설계 문제를 해결함
- 추상적인 아이디어 또는 앱에서 사용할 수 있는 접근 방법

지금까지 사용한 디자인 패턴

- 델리게이션(Delegataion): 하나의 오브젝트가 또다른 오브젝트에게 특정 책임을 위임한다. 텍스트 필드의 콘텐츠가 바뀐 것을 알려주기 위해 UITextField에 위임(delegation)을 사용할 수 있다.
- 데이터 소스(Data source): 데이터 소스는 델리게이트와 비슷하지만, 다른 오브젝트에 반응하는 대신 다른 오브젝트에게 데이터를 전달한다. 테이블 뷰에서 데이터 소스 패턴을 사용한다. 각 테이블 뷰는 적어도 출력해야할 행의 수와, 각 index path에 출력해야할 셀에 대한 데이터 소스를 가지고 있다.
- 모델-뷰-컨트롤러(Model-View-Controller): 각 오브젝트는 세가지 역할 중 하나를 만족해야한다. 모델 오브젝트는 데이터이다. 뷰는 UI를 출력한다. 컨트롤러는 모델과 뷰를 함께 묶어주는 접착제를 제공한다.
- 타겟-액션 페어(Target-action pairs): 특정 이벤트가 발생했을 때, 하나의 오브젝트는 또다른 오브젝트의 매서드를 호출한다. 타겟은 호출하는 매서드를 갖고 있는 오브젝트이고, 액션은 호출된 메서드이다.
