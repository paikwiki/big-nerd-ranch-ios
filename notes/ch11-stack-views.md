# Chapter 11. Stack Views

- 쉽게 배치할 수 있는 수직 또는 수평의 레이아웃을 제공
- 개발자가 통상적으로 직접 해야만 했던 제약 생성을 대부분 관리해줌
- 스택 뷰 안에 스택 뷰를 또 배치할 수 있음.

## 11.1. Using UIStackView

묵시적 제약(implicit constraints)

- 컨텐츠 끌어안기 우선순위(content hugging priorities)와 압축 저항 우선순위(compression resistance priorities)로부터 크기를 가져옴

뷰의 각 축에 대한 아래의 우선 순위 중 하나를 가짐

- 수평 컨텐츠 끌어안기 우선순위(horizontal content hugging priority)
- 수직 컨텐츠 끌어안기 우선순위(vertical content hugging priority)
- 수평 컨텐츠 압축 저항 우선순위(horizontal content compression resistance priority)
- 수직 컨텐츠 압축 저항 우선순위(vertical content compression resistance priority)

Content hugging priorities

- 뷰를 둘러싸고 있는 고무줄 같은 것
- 이 고무줄은 뷰가 본래의 컨텐츠 크기보다 커지는 것을 방지함
- 각 우선순위는 0~1000 범위임
- "1000"은 뷰가 해당 축(dimension)의 원래 컨텐츠보다 커질수 없음을 의미함

Content compression resistance priorities

- 뷰가 본래의 컨텐츠보다 얼마나 작아질 수 있는지를 정의함
- 더 큰 content compression resistance priority를 가진 뷰가 압축에 저항할 것이므로 해당 텍스트는 줄어들지 않음

스택 뷰 디스트리뷰션(Stack view distribution)

- 스택뷰의 디스트리뷰션 속성을 이용해 뷰를 배치할 수 있음
- fill(뷰의 본래 사이즈를 기준으로), fill equally(동일한 크기로)

## 11.2. Segues

세그(Segues)

- 코드를 작성하지 않고 스토리보드에서 컨트롤러 전환을 할 수 있음
- UIStroyboardSegue의 인스턴스
- 각 세그는 style, action item, identifier를 가짐
- action item: 버튼, 테이블 뷰 셀, UIControl처럼 세그를 작동시키는 스토리보드 상의 뷰 오브젝트
- identifier는 코드를 통해 세그에 접근할 때 사용. 폰 흔들기 또는 다른 인터페이스 요소 등 액션아이템이 아닌 다른 요소로부터 세그를 동작시킬 때 유용함

## 11.3. Hooking Up the Content

뷰가 등장하는 시점에 3개의 필드와 1개의 레이블로부터 데이터를 전달받도록 하는 코드. `viewWillAppear(_:)` 메서드 사용

```swift
import UIKit

class DetailViewController: UIViewController {
  @IBOutlet var nameField: UITextField!
  @IBOutlet var serialNameField: UITextField!
  @IBOutlet var valueField: UITextField!
  @IBOutlet var dateLabel: UILabel!

  var item: Item!

  let numberFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.minimumFractionDigits = 2
    formatter.maximumFractionDigits = 2
    return formatter
  }()

  let dateFormatter: DateFormatter = {
    let formmater = DateFormatter()
    formmater.dateStyle = .medium
    formmater.timeStyle = .none
    return formmater
  }()

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    nameField.text = item.name
    serialNameField.text = item.serialNumber
    valueField.text = numberFormatter.string(from: NSNumber(value: item.valueInDollars))
    dateLabel.text = dateFormatter.string(from: item.dateCreated)
  }
}
```

## 11.4. Passing Data Around

세그의 동작이 시작되면(triggered) `prepare(for:sender:)` 메서드가 호출됨

prepare(for:sender:)의 매개변수

- UIStoryboardSegue
- sender: 세그를 동작시킨 오브젝트(UITableViewCell, UIButton 등)

UIStoryboardSegue가 전달하는 세 가지 정보

- 소스 뷰 컨트롤러(세그의 시작)
- 도착 뷰 컨트롤러(세그의 끝)
- 세그의 식별자(the identifier of the segue)

세그 식별자 할당을 위한 switch 문 안의 `preconditionFailure(_:)`

- 예상치못한 세그 식별자를 캐치하고 앱을 종료함
- 개발자가 세그 식별자를 깜빡했거나, 세그 식별자에 오타가 있을 경우에 해당
