# Chapter 13. Saving, Loading and Scene States

## 13.1. Codable

모든 iOS앱은 사용자가 데이터를 조작할수 있도록 인터페이스를 제공하는 역할을 한다.

- 모델 오브젝트: 사용자가 조작하는 데이터를 저장하는 책임을 갖고 있음
- 뷰 오브젝트: 데이터를 반영함
- 콘트롤러: 뷰와 모델 오브젝트 간의 동기화를 유지하는 책임을 갖고 있음

"데이터"를 저장하고 불러온다는 건 모델 오브젝트를 저장하고 불러온다는 것을 의미한다.

LootLogger 앱의 Item을 codable 타입으로 만들어 디스크로부터 인스턴스를 저장하고 불러올 수 있도록 한다.

Codable types

- Encodable 프로토콜과 Decodable 프로토콜이 필요함
- 이를 위해 `encode(to:)`와 `init(from:)` 메소드가 필요함
- codable type을 준수하는 모든 Codable은 자동적으로 프로토콜을 확정함(직접 메소드를 작성하지 않아도 됨)

coder

- 타입을 외부 표현방식으로 인코딩하는 역할을 함
- 내장된 coders: PropertyListEncoder(프로퍼티 목록 형식으로 데이터를 저장), JSONEncoder(JSON 형식으로 데이터를 저장)

## 13.2. Property Lists

프로퍼티 목록

- 디스크에 저장하고 다시 불러올 수 있는 데이터
- 데이터 계층 구조를 드러내므로 가벼운 오브젝트 그래프를 저장/로드하는데 유용함
- 배열(Array), 불(Bool), 데이터(Data), 날짜(Date), 딕셔너리(Dictionary), 실수(Float), 정수(Int), 문자열(String)을 담을 수 있음

`encode(_:)`는 재귀적으로 동작함

## 13.3. Error Handling

에러가 날 수 있음을 표시하는 방법

- 옵셔널 오브젝트를 이용
- 컴파일러의 풍부한(rich) 에러처리 기능을 활용

encode(\_:)의 함수 정의

```swift
func encode(_ value: Encodable) throws -> Data
```

```swift
func saveChanges() -> Bool {

  do {
    let encoder = PropertyListEncoder()
    let data = try encoder.encode(allItems)
  } catch let encodingError {
    print("Error encoding allItems: \(encodingError)")
  }

  return false
}
```

## 13.4. Application Sandbox

애플리케이션 샌드박스

- iOS 앱은 각각 앱 샌드박스를 갖고 있음
- 다른 파일시스템으로부터 격리된 디렉토리

앱 샌드박스의 구조

- `Documents/`: 런타임시 데이터를 쓰는 장소. iCloud나 Finder에 파일 저장
- `Library/Caches/`: 런타임시 데이터를 쓰는 장소. 파일을 iCloud나 Finder 싱크는 하지 않음. 데이터는 웹서버와 같은 다른 곳에 저장되며 필요할 경우 다시 다운. 시스템이 디스크 공간 확보를 위해 이 폴더를 지울 수 있음
- `Library/Preferences/`: 설정을 저장. UserDefaults 클래스를 자동으로 생성하고 이를 iCloud나 Finder에 동기화함
- `tmp/`: 런타임시 임시로 데이터를 저장함. iCloud나 Finder에 싱크되지 않음

## 13.5. Scene States and Transitions

Scene

- 아이폰은 오직 하나의 Scene이 있으며 앱 UI상의 하나의 인스턴스만 있음
- 아이패드는 여러 scenes이 있을 수 있음
- 사용자에 의해 열리기도 하고 닫히기도 한다.

```txt
// Figure 13.5 States of a typical scene

  Scene created in response to
  user interaction or a remote event
         ┆
         ▼
╭─────────────────────╮      ╭─────────────╮
│     Unattached      │ ◀︎──▶︎ │  Suspended  │
╰────────┬────────────╯      ╰─────────────╯
         │                      ▲     ▲
         │           ╭──────────╯     │
         ▼           ▼                ▼
╭─────────────────────╮      ╭─────────────╮
│ Foreground Inactive │ ◀︎──▶︎ │ Background  │
╰─────────────────────╯      ╰─────────────╯
         ▲
         │
         ▼
╭─────────────────────╮
│  Foreground Active  │
╰─────────────────────╯
```

Scene state

- 일시적으로 중단(시리, 통화 등): Foreground Inactive
- 앱 전환: background state
- background에서 suspended state 전환시에는 약 10초 정도 대기 시간이 있음

| State               | Visible | Receives Events | Executes Code |
| ------------------- | ------- | --------------- | ------------- |
| Unattached          | no      | no              | no            |
| Foreground Active   | yes     | yes             | yes           |
| Foreground Inactive | mostly  | no              | yes           |
| Background          | no      | no              | yes           |
| Suspended           | no      | no              | no            |

## 13.6. Persisting the Items

Data 인스턴스의 `write(to:options:)` 메서드

- 파일시스템에 데이터를 저장할 때 사용

변경된 `saveChanges()` 메서드

```swift
func saveChanges() -> Bool {

  print("Saving items to: \(itemArchiveURL)")

  do {
    let encoder = PropertyListEncoder()
    let data = try encoder.encode(allItems)
    try data.write(to: itemArchiveURL, options: [.atomic])
    print("Saved all of the items")

    return true
  } catch let encodingError {
    print("Error encoding allItems: \(encodingError)")

    return false
  }

}
```

알림 센터(Notification center)

- 모든 앱은 NotificationCenter의 인스턴스를 가짐
- 똑똑한 게시판(smart bulletin board)
- 알림을 등록된 옵저버들에게 전달함

```txt
// Figure 13.7 NotificationCenter
╭────────╮
│ Object │
├────────┤
╰────┬───╯
     ┆               ╭──────────────────╮
     ┆               │ Notification     │
postNotification(_:) ├──────────────────┤
     ┆               │ name = "LostDog" │
     ┆               ╰──────────────────╯
     ▼
╭────────────────────╮              ╭───────╮
│ NotificationCenter │ ─Observers──▶︎│ Array │
├────────────────────┤ of "LostDog" ├───────┤
╰─────────┬──────────╯              ╰───┬───╯
          ┆                             ┆
          ┆                             ▼
          ┆                      ╭──────────╮
          ╰┄┄retrieveDog(_:)┄┄┄┄▶︎│ Observer │
                                 ├──────────┤
                                 ╰──────────╯

```

알림 예시

```swift
let notificationCenter = NOtificationCenter.default
notificationCenter.addObserver(self,
                              selector: #selector(retrieveDog(_:)),
                              name: Notification.Name(rewValue: "LostDog"),
                              object: nil)
```

Scene 상태 변화를 알려주는 알림 목록

- UIScene.willConnectionNotification
- UIScene.didDisconnectNotification
- UIScene.willEnterForegroundNotification
- UIScene.didActivateNotifiction
- UIScene.willDeactivateNotification
- UIScene.didEnterBackgroundNotification

저장된 데이터를 불러오고, 저장할 수 있도록 `init()` 추가

```swift
init() {

  do {
    let data = try Data(contentsOf: itemArchiveURL)
    let unarchiver = PropertyListDecoder()
    let items = try unarchiver.decode([Item].self, from: data)
    allItems = items
  } catch {
    print("Error reading in saved items: \(error)")
  }

  let notificationCenter = NotificationCenter.default
  notificationCenter.addObserver(self,
                                selector: #selector(saveChanges),
                                name: UIScene.didEnterBackgroundNotification,
                                object: nil)
}
```
