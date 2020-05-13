# Chapter 4. View Controllers

## 4.1. The view of a View Controller

뷰 컨트롤러(View Controllers)

- "UIViewController의 서브클래스"의 인스턴스
- 뷰의 계층구조를 관리함
- 뷰 컨트롤러의 뷰는 화면에 나타낼 필요가 있을 때까지 생성되지 않음 -> lazy loading

뷰 컨트롤러의 뷰를 생성하는 두 가지 방법

- 스토리보드와 같은 인터페이스 파일을 사용하는 인터페이스 빌더를 통해서
- UIViewController의 메서드인 `loadView()`를 오버라이딩 해서 코드를 이용해서

## 4.2. Setting the Initial View Controller

각각의 스토리보드 파일은 하나의 이니셜 뷰 컨트롤러(initial view controller)를 갖는다.

루트뷰컨트롤러(rootViewController) 속성

- UIWindow는 루트뷰컨트롤러 속성을 갖고 있음
- 뷰 컨트롤러가 윈도우의 루트뷰컨트롤러로 설정되면, 그 뷰 컨트롤러의 뷰는 윈도우의 뷰 계층구조에 추가됨

메인 인터페이스(main interface)

- 각각의 애플리케이션은 스토리보드에 대한 참조인 하나의 메인 인터페이스가 있음
- 엡이 실행되면 메인 인터페이스를 위한 이니셜 뷰 컨트롤러는 윈도우의 루트뷰컨트롤러로서 세팅됨

## 4.3. Tab Bar Controllers

UITabBarController

- 실습 예제에서 두 개의 UIViewController를 변경할 수 있게 해줌
- UIVewController의 서브클래스
- UITabBarController의 뷰는 두가지 주요 서브뷰를 가진 UIView이다: 탭바와 선택된 뷰 컨트롤러의 뷰

## 4.4. Loaded and Apperaring Views

프레임워크(framework)

- 코드와 자원들을 패키지화하고 다양한 애플리케이션에서 공유할 수 있게 해줌

`viewWillAppear(\_:)`

- 뷰 컨트롤러의 뷰를 윈도우에 추가하기 전에 호출됨
- `viewDidLoad()` 다음에 호출됨

## 4.5. Interacting with View Controllers and Their Views

뷰 컨트롤러와 뷰의 라이프사이클에서의 메서드

- `init(coder:)`: 스토리보드로부터 UIViewController가 생성될 때 실행
- `init(nibName:bundle:)`: UIViewController를 위해 설계된 이니셜라이저. 스토리보드 사용없이 뷰 컨트롤러 인스턴스를 생성할 때 한 번 실행. 각각의 뷰 컨트롤러가 생성될 때 한번씩만 호출됨
- `loadView()`:뷰 컨트롤러의 뷰를 코드로 생성할 때 오버라이딩해서 사용 할 수 있음.
- `viewDidLoad()`: 인터페이스 파일 로딩을 통해 뷰를 설정할 때 오버라이딩해서 사용 할 수 있음. 뷰 컨트롤러의 뷰가 생성된 후에 호출됨
- `viewWillAppear(\_:)`: 뷰 컨트롤러의 뷰가 화면에 등장하는 각각의 시점을 오버라이딩해서 사용 할 수 있음. `viewDidAppear(\_:)`도 뷰 컨트롤러가 화면이 등장할 때 매번 호출됨. `viewWillDisappear(\_:)`와 `viewDidDisappear(\_:)`도 화면이 사라질 때 매번 호출됨.

레이지 로딩의 이점을 보존하기 위해 `init(nibName:bundle:)` 또는 `init(coder:)`에 뷰 컨트롤러의 뷰 속성에 접근하지 않아야 한다. 이니셜라이저에서 뷰를 요청하는건 뷰 컨트롤러가 자신의 뷰를 조기에 로드하게하는 원인이 될 수 있다.
