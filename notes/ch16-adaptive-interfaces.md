# Chapter 16. Adaptive Interfaces

Auto Layout과 safe area가 다양한 스크린 사이즈와 디바이스 종류에 대응할 수 있게 해준다.

## 16.1. Size Classes

사이즈 클래스(Size Classes)

- 가로 세로 각 면의 사이즈는 컴팩트(compact)와 레귤러(ragular)로 구분된다.

4개의 사이즈 종류

- Compact Width | Compact Height: 가로 방향의 4, 4.7, 5.8인치 화면
- Compact Width | Regular Height: 세로 방향의 모든 아이폰 화면
- Regular Width | Compact Height: 가로 방향의 5.5, 6.1, 6.5인치 화면
- Regualr Width | Regular Height: 모든 방향의 모든 사이즈의 아이패드

특정 사이즈 클래스 조합을 위한 인터페이스를 수정할 때 변경할 수 있는 요소

- 많은 뷰의 프로퍼티
- 특정 서브뷰의 설치 여부(whether a specific subview is intalled)
- 특정 제약의 설치 여부
- 제약의 상수(the constant of a constraint)
- 텍스트를 출력하는 서브뷰의 폰트

## 16.2. Adapting to Dark Mode

다이내믹 컬러(dynamic colors)

- 현재의 `trait collection`에 의존함
- userInterfaceIdiom: 실행하는 디바이스의 종류
- userInterfaceStyle: 라이트/다크 모드
- userInterfaceLevel: 베이스(풀스크린), 엘레베이트(elevated, 모달, 팝오버, 스플릿 뷰 등) 레벨

다이내믹 컬러의 세 가지 종류의 배경색

- primary: 풀스크린 배경
- secondary: 풀스크린이 아닌(elevated) 배경
- tertiary:엘레베이트 다음 배경

Asset Catalog에 색상을 등록해서 사용할 수 있다.
