# Chapter 23. Core Data Relationships

코어 데이터는 여러 엔터티 간의 관게(relationshps)를 관리한다.

## 23.1. Relationships

- to-one: 엔터티의 각 인스턴스는 다른 엔터티 인스턴스와 단일한 참조
- to-many: 엔터티의 각 인스턴스는 집합(Set)을 참조로 가짐

`code generation`이라는 기능을 이용해 서브클래스를 자동으로 생성할 수 있다.

엔터티 설정

- Manual/None: Xcode가 엔터티에 대해 아무런 코드도 생성하지 않은 설정
- Category/Extension: 속성과 관계를 정의하는 익스텐션을 생성하는 동안 커스텀 비헤이비어와 함께 `NSManagedObject`의 서브클래스를 정의할 수 있음

`inverse relationship`

## 23.2. Adding Tags to the Interface

정리할 내용 없음

## 23.3. Background Tasks

`processPhotoRequest(data:error:)`

- 백그라운드 태스크를 사용
- 비동기 작업으로, 메서드에서 동기적으로 반화하지 않고 완료 핸들러를 비동기로 호출하도록 전달
