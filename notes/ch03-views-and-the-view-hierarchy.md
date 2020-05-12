# Chapter 3. Views and the View Hierarchy

## 3.1. View

뷰의 특징

- UIView의 인스턴스 또는 그것의 서브클래스 중 하나
- 스스로 어떻게 그려야하는지 알고 있음
- 애플리케이션이 창인 뷰의 계층 구조 내에 있음

## 3.2. The View Hierarchy

모든 애플리케이션은 애플리케이션의 모든 뷰를 위한 컨테이너로서 제공되는 UIWindow의 단일 인스턴스를 가진다.

UIWindow

- UIView의 서브클래스로, 윈도우도 하나의 뷰다.
- 윈도우는 애플리케이션이 실행되는 시점에 생성됨
- 윈도우가 생성된 후에 다른 뷰들이 그 위에 추가됨

서브뷰(subview)

- 윈도우에 추가된 뷰
- 윈도우에 추가된 서브뷰 역시 다른 서브뷰를 가질 수 있음
- 따라서 윈도우를 루트로 하는 뷰 오브젝트의 계층구조가 생성됨

````txt
/* F.3.2 An example view hierarchy and the interface that it creates */
  ╭────────────╮
  │ UIWindow   │
  ├────────────┤
  │ frame      │
  ╰─────┬──────╯
        │  subviews
  ╭─────┴──────╮
  │ [UIView]   │
  ╰─────┬──────╯
        ├────────────────┬──────────────┐
  ╭─────┴───────╮  ╭─────┴─────╮  ╭─────┴─────╮
  │ UISearchBar │  │ WKWebView │  │ UIToolbar │
  ├─────────────┤  ├───────────┤  ├───────────┤
  ╰─────┬───────╯  ╰─────┬─────╯  ╰─────┬─────╯
        │ subviews       │ subviews     │ subviews
  ╭─────┴──────╮   ╭─────┴──────╮ ╭─────┴──────╮
  │ [UIView]   │   │ [UIView]   │ │ [UIView]   │
  ╰─────┬──────╯   ╰─────┬──────╯ ╰─────┬──────╯
        │                │              └─────────────────┐
        │                └─────────────────────┐          │
      ┌─┴─────────┬────────────────┐           │          │
╭─────┴────╮ ╭────┴────────╮ ╭─────┴────╮ ╭────┴────────╮ │
│ UIButton │ │ UITextField │ │ UIButton │ │ UITextField │ │
├──────────┤ ├─────────────┤ ├──────────┤ ├─────────────┤ │
╰──────────╯ ╰─────────────╯ ╰──────────╯ ╰─────────────╯ │
            ┌────────────┬────────────┬────────────┬──────┴─────┐
      ╭─────┴────╮ ╭─────┴────╮ ╭─────┴────╮ ╭─────┴────╮ ╭─────┴────╮
      │ UIButton │ │ UIButton │ │ UIButton │ │ UIButton │ │ UIButton │
      ├──────────┤ ├──────────┤ ├──────────┤ ├──────────┤ ├──────────┤
      ╰──────────╯ ╰──────────╯ ╰──────────╯ ╰──────────╯ ╰──────────╯
````

뷰의 계층 구조를 생성하고 나면 화면에 그려지는 과정은 두 단계로 나눌 수 있음

1. 윈도우를 포함해 계층 구조 내의 각각의 뷰는 일종의 비트맵 이미지처럼 생각할 수 있는 "레이어(layer)"로서 스스로 그려짐(레이어는 CALayer의 인스턴스)
2. 모든 뷰의 레이어는 화면상에 함께 구성됨

## 3.3. Creating a New Project

Xcode 실습

## 3.4. Views and Frames

뷰의 init(frame:) 메서드

- init()은 CGRect를 인자로 받음
- CGrect UIView의 속성인 frame에 대입됨

뷰의 프레임(View's frame)

- 뷰의 사이즈와, 슈퍼뷰에 연관된 위치를 지정함
- 뷰의 크기는 그것의 frame으로 지정되기 때문에, 뷰는 항상 사각형임

뷰콘트롤러(ViewController)

- 앱이 실행됐을 때 루트 레벨의 윈도우에 추가되는 뷰 콘트롤러
- `ViewController.swift`에 클래스를 정의함

프레임워크(Framework)

- 연관성 있는 클래스와 리소스의 모음
- UIKit framework: 사용자가 보는 다양한 UI 엘리먼트를 정의함

viewDidLoad() 메서드

- 뷰 콘트롤러의 뷰가 메모리에 로드되면 호출하는 메서드
- 이 메서드를 이용해 뷰 계층 구조를 커스터마이징할 수 있음

CGRect에 전달하는 인자

- `origin`과 `size`
- `origin.x`, `origin.y`, `size.width`, `size.height`

포인트(Point)

- 상대값의(relative) 측정 단위
- 디스플레이가 얼마나 많은 픽셀을 갖고 있느냐에 따라 포인트당 픽셀의 수는 바뀔 수 있다.
- 사이즈, 위치, 라인과 커브는 화면 해상도의 차이들을 수용하기 위해 항상 포인트로 묘사한다.

## 3.5. The Auto Layout System

오토레이아웃 시스템(Auto Layout system)

- 정렬 사각형(alignment rectangle)에 기초함

사각형을 정의하는 다양한 레이아웃 속성(layout attributes)

- Width, Height
- Top, Bottom,
- Left, Right
- CenterX, CenterY
- FirstBaseline, LastBaseline: 여러줄의 텍스트 레이블에서는 각각 첫번째 줄이나 마지막 줄을 의미하지만 보통은 둘은 같다.
- Leading, Trailing: 방향에 따라 앞선 쪽이 Leading, 뒤따르는 쪽이 Trailing
- 일반적으로 frame과 alignment rectangle은 동일함. 하지만 정렬을 위해 다르게 지정하는 것도 가능

제약(Constraints)

- constraint: 하나 혹은 여러개의 뷰에 대해 레이아웃 속성을 정의하기 위해 사용할 수 있는 뷰 계층구조 내부에 정의해준 관계를 의미함
- 애플은 가급적 인터페이스 빌더를 이용해 제약을 추가하기를 권함

가까이 있는 이웃 뷰(Nearest neighbor)

- 특정 방향에서 가장 근접한 이웃 뷰
- 지정한 방향이 없을 경우 슈퍼뷰가 nearest neighbor가 된다.

오토레이아웃 이슈 지시자(Auto Layout issue indicator)

- 인터페이스와 관련한 잠재적 이슈를 알려줌

오토레이아웃 이슈의 예시

- Localization Issues: 뷰에 아직 제약이 없는 문제
- Missing Constraints: 제약 조건이 빠졌음을 알려줌
- Misplaced views: 오토레이아웃으로 계산한 뷰와 인터페이스 빌더상의프래임의 위치가 다른 상태의 뷰를 의미함

고유 콘텐츠 사이즈(intrinsic content size)

- 콘텐츠에 따라 뷰의 크기가 정의됨

## 3.6. Challenges

## 3.7. Bronze Challenge: More Auto Layout Practice

constraints 모두 초기화하고 다시 작성해보기

## 3.8. Silver Challenge: Adding a Gradient Layer

배경에 그라디언트 추가해보기

````swift
//
//  ViewController.swift
//  WorldTrotter
//
//  Created by Changhyun Baek on 2020/05/12.
//  Copyright © 2020 paikwiki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewWillLayoutSubviews() {
        let gradient = CAGradientLayer()

        gradient.frame = view.bounds
        gradient.colors = [UIColor.purple.cgColor, UIColor.blue.cgColor, UIColor.green.cgColor, UIColor.yellow.cgColor, UIColor.red.cgColor, UIColor.red.cgColor]
        view.layer.insertSublayer(gradient, at: 0)
    }

}
````

## 3.9 Gold Challenge: Spacing Out the Labels

## 3.10 For the More Curios: Retina Display
