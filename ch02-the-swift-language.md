# Chapter 2. The Swift Language

## 스위프트에서의 자료형

스위프트의 세 가지 기본 그룹

- structures(structs)
- classes
- enumerations(eums)

위 세 그룹 모두 아래의 항목을 가질 수 있다.

- 속성(properties): 자료형과 관련된 값
- 이니셜라이저(initializers): 자료형의 인스턴스를 초기화하는 코드
- 인스턴스 메서드(instance methods) - 자료형의 인스턴스를 호출할 수 있는 자료형을 지정하는 함수(functions specific to a type that can be called on an instance of that type)
- 클래스 또는 정적 메서드(class or static methods) - 자료형 스스로가 호출할 수 있는 자료형을 지정하는 함수(functions specific to a type that can be called on the type itself)

````swift
// Structures
struct MyStruct {
  // properties
  // initializers
  // methods
}

// Enumerations
enum MyEnum {
  // properties
  // initializers
  // methods
}

// Classes
class MyClass: SuperClass {
  // properties
  // initializers
  // methods
}
````

스위프트의 원시 자료형("primitive" types)는 스트럭쳐이다.

- Numbers: Int, Float, Double
- Boolean: Bool
- Text: String, Charactor
- Collections: Array<Element>, Dictionary<Key:Hashable, Value>, Set<Element:Hashable>

이들 모두 속성, 이니셜라이저, 메소드를 갖고 있으며 프로토콜을 따르거나 확장할 수 있다.

옵셔널(optionals): 특정 타입의 값 또는 아무것도 없는 값을 저장할 수 있게 해줌

## 표준 자료형 사용하기

숫자와 불린 자료형(Number and Boolean types)

- Int: 특별한 이유가 없다면 Int 자료형을 사용할 것을 권장
- Float: 32비트의 실수
- Double: 64비트의 실수
- Float80: 80비트의 실수
- Bool: 참/거짓을 갖는 수

집합 자료형(Collection types)

- 배열(arrays): 아이템의 자료형이 모두 일치해야 함
- 딕셔너리(dictionaries): 해시가능한 자료형을 키로 사용(Int, Float, Charactor and String), 키-값 쌍의 순서없는 쌍. 아이템 자료형 모두 일치해야 함
- 세트(sets): 세트의 멤버는 해시 가능하고, 유일해야 한다.

리터럴과 서브스크립팅(Literals and subscripting)

- 문자열 리터럴: 큰따옴표 사용
- 숫자 리터럴
- 서브스크립팅: 배열에 접근할 수 있는 단축어
- 배열 밖의 인덱스(an out-of-bounds index) 참조시 trap 발생
- trap: 알 수 없는 상태에 들어가기 전에 프로그램을 중단시키는 런타임 에러

이니셜라이져

## 옵셔널

## Loops and String Interpolation

## Enumerations and the Switch Statement

## 클로저

## 애플 스위프트 공식 문서 찾아보기
