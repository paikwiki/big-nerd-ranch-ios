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
- 서브스크립팅: 배열에 접근할 수 있는 단축어. 딕셔너리에도 사용할 수 있음
- 배열 밖의 인덱스(an out-of-bounds index) 참조시 trap 발생
- trap: 알 수 없는 상태에 들어가기 전에 프로그램을 중단시키는 런타임 에러

이니셜라이져(Initializers)

- 인스턴스(instance): 자료형의 특정 형태(a particular embodiment of a type). 역사적으로 인스턴스라는 용어는 클래스와 함께 쓰였으나 스위프트는 스트럭쳐나 이뉴머레이션에도 사용함
- 이니셜라이저의 동작이 끝나면 인스턴스는 동작(action)할 준비 완료
- 실수에 대해 타입추론을 할 경우 기본 자료형은 더블

속성(Properties)

- 속성: 자료형의 인스턴스와 관련한 값

인스턴스 메서드(Instance methods)

- 인스턴스 메서드: 특정 자료형에 한정된 함수로 해당 자료형의 인스턴스에서 호출할 수 있음

## 옵셔널

- 자료형 뒤에 `?`를 붙여서 옵셔널을 지정할 수 있다.
- 변수가 어떤 값도 저장하지 않을 수 있는 가능성이 있음을 나타냄
- 옵셔널은 지정한 자료형의 인스턴스이거나 nil 일수 있음
- 옵셔널로 지정한 변수는 반드시 언래핑해서 사용해야 함(변수명 뒤에 `!`를 붙임)

옵셔널 바인딩

- 옵셔널로 지정한 변수에 값이 없는데 언래핑을 시도할 경우 nil이 반환됨. 이는 trap의 원인이 됨.
- 트랩을 방지하기 위해 옵셔널 바인이(optional binding) 활용

딕셔너리 서브스크립팅

배열에서 out-of-bounds 인덱스를 사용하면 트랩이 발생하는 것과 달리 딕셔너리는 옵셔널을 반환함

## 반목문과 문자열 보간(Loops and String Interpolation)

````swift
for (i, string) in countingUp.enumerated() {
    print(i, string)
}
````

위의 코드에서 `enumerated()`는 튜플(tuples)을 반환한다.

- 튜플: 배열과 유사한, 순서가 있는 값의 그룹
- 배열과 비교했을 때, 각 멤버가 구별되는 자료형을 갖고 있다는 차별점이 있음

문자열 보간

- 문자열(`""`) 내에서 `\(변수)` 형태로 문자열에 변수의 값을 넣을 수 있음

## 열거형과 스위치 구문(Enumerations and the Switch Statement)

- 열거형: 종류가 각기 다른 값으로 구성된 세트 형태의 자료형(a type with a discrete set of values)
- 스위치: 스위치 구문의 케이스 구문은 철저해야 한다. 스위치 구문에서 발생할 수 있는 모든 값은 케이스에 포함돼야 하며, 그렇지 않으면 default 케이스를 작성해야 함
- 스위치 구문은 해당하는 케이스 이후의 구문을 실행하지 않는다(not fall through).
- fallthrough 키워드로 이후 구문을 실행할 수 있음
- 열거형은 반환 자료형을 지정하면 rawValue를 지정할 수 있음
- rawValue가 정수형일 때, 하나의 케이스에 rawValue를 지정하면 다른 케이스에는 저절로 rawValue가 값의 순서대로 대입됨

## 클로저(Closures)

- 기능을 자체 내장한 블록(a self-contained block of functionality)
- 클로저와 함수들의 차이점: 클로저는 더 컴팩트하고 가벼운 문법을 갖고 있음
- 이름이나 완전한 함수 선언 없이 "함수-같은" 구조를 사용할 수 있음

예시

````swift
let compareAscending = { (i: Int, j: Int) -> Bool in
    return i < j
}
````
