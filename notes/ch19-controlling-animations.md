# Chapter 19. Controlling Animations

## 19.1. Property Animators

`layoutIfNeeded()`

- 시스템에게 프레임 재계산을 요청
- 버튼 뷰에서 `layoutIfNeeded()` 메소드를 호출하여 클로저에서 수행

```swift
@objc private func imageButtonTapped(_ sender: UIButton) {
  guard let buttonIndex = imageButtons.firstIndex(of: sender) else {
    preconditionFailure("The buttons and images are not parallel")
  }

  let selectionAnimator = UIViewPropertyAnimator(
    duration: 0.3,
    curve: .easeInOut,
    animations: {
      self.selectedIndex = buttonIndex
      self.layoutIfNeeded()
  })
  selectionAnimator.startAnimation()

  sendActions(for: .valueChanged)
}
```

UIViewPropertyAnimator의 이니셜라이저인 `init(duration:controlPoint1:controlPoint2:animations:)`를 참고하면 커스텀 애니메이션 베지어 곡선을 만들 수 있다.

damping ratio

- 스프링 애니메이션. 0.0~1.0 범위

## 19.2. Animating Colors

작성할 내용 없음

## 19.3. Animating a Button

작성할 내용 없음
