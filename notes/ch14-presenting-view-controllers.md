# Chapter 14. Presenting View Controllers

iOS 애플리케이션은 종종 사용자가 반드시 선택해야만 하는 경우가 있다(Ex: modal).

## 14.1. Adding a Camera Button

UIToolbar를 생성한다. UIToolbar는 생성하면 내부에 Bar Button Item이 함께 생성된다. Bar Button Item을 카메라로 설정한 후, @IBAction을 생성(`choosePhotoSource`)해준다.

## 14.2. Alert Controllers

사용자가 사진을 선택할 수 있게 하기 위해서 가능한 선택지를 보여주는 alert를 띄워야 한다.

UIAlertController의 인스턴스를 생성해야 하며 아래의 두 가지 스타일을 사용할 수 있다.

- UIAlertControllerStyle.actionSheet: 선택한 것으로부터 가능한 액션의 목록을 보여줌
- UIAlertControllerStyle.alert: 중요한(critical) 정보를 보여주며 사용자가 진행할 것인지를 결정하도록 요구

사용자가 결정을 바꿀 수 있거나, 중요한 액션이 아니라면 `.actionSheet`가 낫다.

```swift
@IBAction func choosePhotoSource(_ sender: UIBarButtonItem) {
  let alertController = UIAlertController(title: nil,
                                          message: nil,
                                          preferredStyle: .actionSheet)

  let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
    print("Present camera")
  }
  alertController.addAction(cameraAction)

  let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { _ in
    print("Present photo library")
  }
  alertController.addAction(photoLibraryAction)

  let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
  alertController.addAction(cancelAction)

  present(alertController, animated: true, completion: nil)
}
```

UIAlertAction의 스타일

- `.default`
- `.cancel`
- `.destructive`

## 14.3. Presentation Styles

Presentation Styles 종류

- `.automatic`: 시스템이 선택한 스타일을 사용함(일반적으로 `.formSheet`)
- `.formSheet`: 콘텐츠의 상단 중앙에 노출함
- `.fullScreen`: 모든 앱을 덮으며 노출함
- `.overFullScreen`: `.fullScreen`과 비슷하지만, 뷰 컨트롤러가 보이는 상태라는 점이 다름. 뷰 컨트롤러가 투명한 상태로 보여서 사용자가 그 아래에 있는 컨트롤러를 볼 수 있음
- `.popover`: 아이패드의 팝 오버 뷰로 노출함(아이폰에서는 `.formSheet`로 폴백됨)
