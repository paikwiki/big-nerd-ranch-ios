# Chapter 22. Core Data

로컬에 데이터를 저장할 때 선택지

- 아카이빙(Archiving): 데이터에 접근하려면 전체를 역질렬화해야하고, 다시 저장하려면 전체를 직렬화해야 함
- 코어 데이터(Core Data): 저장된 오브젝트의 서브셋을 가져올 수(fetch) 있음

## 22.1. Object Graphs

Core Data

- 사용자의 모델 오브젝트가 무엇이고, 서로 어떻게 연관되는지 표현해주는 프레임워크
- 오브젝트 그래프(object graph): 모델 오브젝트의 집합
- 저장/불러오기시, 코어데이터는 모든 것이 일관성있게 유지되도록 해줌
- 오브젝트 그래프를 SQLite 데이터베이스에 저장하기 때문에 SQL을 다뤄본 개발자는 오브젝트 관계매핑 시스템처럼 코어데이터를 다루고자 하는데 이렇게 하면 혼란이 있을 수 있음
- ORM과 다르게 코어 데이터는 스토리지에 대한 완전한 조작을 할 수 있음(외래키, 스키마와 같은 서술이 필요 없음)
- "무엇을" 저장할 것인지, 그리고 파일 시스템에서 그것이 "어떻게" 재현될지만 알려주면 됨
- 코어 데이터는 스토리지 메커니즘에 대한 세부를 알지 않아도 관계형 대이터베이스에 데이터를 저장하고 가져올 수 있게 해줌

## 22.2. Entities

관계형 데이터베이스와 스위프트

- 테이블 == 스위프트 자료형
- 열 == 타입의 프로퍼티
- 행 == 타입의 인스턴스

코어 데이터의 "옵셔널(optional)"

- 스위프트 옵셔널과 약간 다름
- 코어 데이터에서 옵셔널 속성이 아닌 경우엔 저장시 반드시 값이 있어야 함
- 하지만 저장하기 전에는 값이 없어도 됨
- `photoID`가 `String`이라면 코드에서는 `String?`으로 표현됨

`NSManagesdObject`

- `NSObject`의 서브셋
- 다른 코어 데이터와 상호조작하는 법을 알고 있는 오브젝트
- 딕셔너리처럼 동작함

## 22.3. NSPersistentContainer

`NSPersistentContainer`

- 코어 데이터는 코어 데이터 스택(Core Data Stack)이라고 언급되는 클래스의 집합으로 표현됨
- 이 클래스의 콜렉션은 `NSPersistentContainer` 클래스를 통해 추상화됨

## 22.4. Updating Items

`viewContext`

- `NSManagedObjectContext`의 인스턴스
- 매니지드 오브젝트 컨텍스트는 일종의 영리한 스크래치 패드

코어데이터는 "쓰레드"대신 "큐(queue)"라는 단어를 사용한다.

`NSManagedObjectContext`의 메서드

- perform(\_:): 비동기
- performAndWait(\_:): 동기

## 22.5. Updating the Data Source

`fetch request`

- `NSManagedObjectContext`로부터 오브젝트를 가져왔으면 `NSFetchRequest`를 준비하고 실행해야 함
- `sort descriptors`: 배열 안의 오브젝트의 순서, `NSSortDescriptor`
