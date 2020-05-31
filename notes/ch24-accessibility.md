# Chapter 24. Accessibility

## 24.1. VoiceOver

`UIAccessibility` 프로토콜

- 모든 표준 UIKit 뷰와 컨트롤러에 구현된 비공식 프로토콜(`informal protocol`)
- 비공식 프로토콜은 공식 프로토콜에 비해 느슨한 계약

`UIAccessibility` 프로토콜의 유용한 프로퍼티

- accessibilityLabel: 엘리먼트에 대한 짧은 설명글
- accessibilityHint: 관련된 엘리먼트의 인터렉션 결과에 대한 짧은 설명글
- accessibilityFrame: 엑세서빌리티 엘리먼트의 프레임
- accessibilityTraits: 엘리먼트의 특징에 대한 설명
- accessibliltyValue: 엘리먼트의 값에 대한 설명
