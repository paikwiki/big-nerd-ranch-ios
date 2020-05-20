# Chapter 10. Subclassing UITableViewCell

UITableViewCell 오브젝트

- UITableView는 UITableViewCell의 목록을 출력함
- UITalbeViewCell의 요소: textLabel, detailTextLabel, imageView
- 좀더 세부적이고 레이아웃이 다른 셀이 필요하다면 UITableViewCell의 서브클래스를 사용해야 함

셀에 컨텐츠를 바로 삽입하지 않고 contentView의 서브뷰로 넣어야 하는 이유

- 셀은 특정한 시점(또는 특정한 배율? at certain times)로 컨텐트뷰의 크기를 조정하기 때문

## 10.1. Creating ItemCell

@IBOutlet 세팅하기

- ItemsViewController가 tableView(\_:cellForRowAt:) 내부의 ItemCell의 컨텐츠를 설정하기 위해, 셀은 반드시 세가지 레이블을 출력하는(expose) 속성을 가져야 함

## 10.2. Using ItemCell

```swift
let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
```

> 궁금해요! `as! ItemCell`은 어떤 의미일까?

## 10.3. Dynamic Cell Heights

셀의 높이를 동적으로 변화시키기 위해 `automationDimension`을 사용할 수 있음

예시

```swift
override func viewDidLoad() {
  super.viewDidLoad()

  tableView.rowHeight = UITableView.automaticDimension
  tableView.estimatedRowHeight = 65
}
```

## 10.4. Dynamic Type

- 신뢰할 수 있도록 최적화된, 특별히 설계한 text styles를 제공하여 인터페이스를 만들 수 있게 해주는 기술
- 사용자는 7개의 텍스트 사이즈(접근성 섹션에서 몇 가지 더 선택 가능)를 선택할 수 있음
- 다이나믹 타입 시스템은 서체의 스타일에 포커스를 둔 시스템
