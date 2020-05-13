# Chapter 1. A Simple iOS Application

iOS 앱 제작시 두 개의 기본 질문

- 오브젝트를 바르게 생성하고, 구성하려면 어떻게 해야할까?
- 어떻게 하면 앱이 사용자의 인터렉션에 반응하도록 할 수 있을까?

## Model-View-Controller(MVC)

모든 인스턴스는 `model layer`, `view layer` 또는 `controller layer`에 속한다.

모델 레이어

- 데이터를 다루며, 유저 인터페이스(UI)에 대해서는 전혀 모른다.
- Quiz 앱의 모델은 순서가 있는, 질문(questions)과 답변(answers)의 두 개의 목록으로 구성된다.
- 사용자의 세계에서 실제 사물(real things)를 대표한다(예: 보험 회사 앱을 만든다면 모델은 `InsurancePolicy`라는 커스텀 유형을 포함).

뷰 레이어

- 사용자에게 보여줄 오브젝트를 담는다(예: 버튼, 텍스트 필드, 슬라이더).
- 애플리케이션의 UI를 구성한다.
- Quiz 앱의 오브젝트는 질문과 답변을 보여주는 레이블(labels)과, 그 아래의 버튼들이다.

컨트롤러 레이어

- 애플리케이션을 관리하는 레이어.
- 컨트롤러 레이어는 애플리케이션의 매니저들이다.
- 컨트롤러는 사용자가 보는 뷰를 구성하고, 뷰와 모델 오브젝트를 확실하게 동기화하도록 한다.
- 일반적으로 컨트롤러는 "그리고 다음엔?"에 대해 처리한다(예: 사용자가 리스트에서 아이템을 선택하면, 컨트롤러는 사용자가 다음에 볼 무언가를 정의한다).

```txt
/* F.1.6 MVC Pattern */
                          ╭────────────╮
                          │ User Input │
                          ╰────────────╯
                                    ↓    User interacts view object
                          ┌────────────┐
                          │ View       │
                          └────────────┘
Controller updates view with ↑      │    View sends message
changes in model objects     │      ↓    to controller
                          ┌────────────┐
                          │ Controller │
                          └────────────┘
Controller takes data from   ↑       │   Controller updates
model objects that its views │       │   model objects
art interested in            │       ↓
                          ┌────────────┐
                          │ Model      │
                          └────────────┘
```

컨트롤러는 지침을 전달(dispatching instructions)하고 메시지를 수신(receiving messages)하며 모든 것의 중간에 위치한다.

## 인터페이스 빌더(Interface Builder)

- 객체의 인스턴스를 생성하고 속성을 조작 할 수있는 객체 편집기
- 별도의 파일에 포함 된 코드의 그래픽 표현이 아님

오토 레이아웃(Auto Layout)

잘못 작성했을 경우 [cmd] + [z]로 되돌리기 하려하지 말고 오토레이아웃 메뉴 중 가운데에 세모가 그려진 아이콘을 클릭해서 "Clear constraints" 항목을 선택해 리셋해야 한다.

커넥션(Connections)

- 하나의 오브젝트가 메모리상의 또다른 오브젝트를 알게 해서 두 오브젝트가 커뮤니케이션 할 수 있게 함
- 커넥션에는 아울렛(outlets)과 액션(actions)이 있음

아울렛과 액션

- 아울렛: 오브젝트에 대한 참조(a reference to an object)
- 액션: 버튼에 의해, 또는 슬라이더나 픽커와 같은 유저와 상호작용할 수 있는 다른 특정 뷰에 의해 작동하는 메서드

## 애플리케이션 아이콘

| Device             | Applictaion icon sizes                   |
| ------------------ | ---------------------------------------- |
| iPhone             | 180x180pixels(@3x)<br>120x120pixels(@2x) |
| iPad and iPad mini | 152x152pixles(@2x)                       |
| iPad Pro           | 167x167pixels(@2x)                       |

애플리케이션에서 사용하는 두 종류의 파일들

- code: 애플리케이션을 만드는 데 사용하는 파일
- resources: 런타임에서 앱이 사용하는 이미지, 사운드, 인터페이스빌더 파일

## 런치 스크린(Launch Screen)

앱이 로드되기 전에 보여주는 이미지. 앱이 로드되면 런치 스크린은 앱의 배경이미지가 되는 것이 아니라 교체가 된다.
