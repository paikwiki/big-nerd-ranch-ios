# Chapter 15. Camera

UIImagePickerController

- 사용자가 각각의 아이템에 대해 사진을 찍고 저장할 수 있도록 하는데 사용할 것임
- 이미지는 용량이 크므로 다른 데이터로부터 분리해서 저장함(ImageStore)

## 15.1. Displaying Images and UIImageView

UIImageView를 활용해 이미지를 출력한다.

UIImageView

- 이미지 뷰의 `contentMode` 프로퍼티에 따라 이미지를 출력함
- `contentMode`: 위치와, 이미지 뷰 프래임 내에서 어떻게 사이지를 조절할 것인지 정의함
- `contentMode`에는 aspect fit과 aspect fill 이 있다.

## 15.2. Taking Pictures and UIImagePickerController

UIImagePickerController의 인스턴스를 생성후

- `sourceType` 프로퍼티를 설정
- 델리게이트를 등록

UIImagePickerController의 열거형 값

- `.camera`: 촬영
- `.photoLibrary`: 앨범에서 선택
- `.savedPhotoAlbum`: 최근 촬영한 사진으로부터 선택

사용 전에 권한 승인이 필요한 것들

- photos
- microphone
- calendar
- location
- HealthKit data
- reminders

이걸 사용하려면 앱이 접근하고 싶은 범위와 정보에 대한 특정한 이유를 정의한 usage description을 제공해야 한다.

이미지를 선택하고 나면 이미지를 제어할 이미지컨트롤러가 필요하다.

```swift
func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

  // Get picked image from info dictionary
  let image = info[.originalImage] as! UIImage

  // Put that image on the screen in the image view
  imageView.image = image

  // Take image picker off the screen - you must call this dismiss method
  dismiss(animated: true, completion: nil)
}
```

`UIImagePickerController.InfoKey`

- `.originalImage`
- `.editedImage`
- `.cropRect`

용량이 큰 이미지를 저장하기 위해 ImageStore 클래스를 만들어야 한다.

## 15.3. Creating ImageStore

`NSCache`

- 딕셔너리처럼 동작하지만, 시스템의 메모리가 모자르면 오브젝트를 자동으로 삭제함
- `NSCache`의 구현으로 인해 문자열을 사용할 때는 `NSString`을 이용해야 함

```swift
import UIKit

class ImageStore {

    let cache = NSCache<NSString,UIImage>()

    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }

    func image(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }

}
```

## 15.4. Giving View Controllers Access to the Image Store

내용 없음

## 15.5. Creating and Using Keys

이미지를 스토어에 저장할 때 유일한 키(a unique key)와 함께 캐시에 저장해야 한다. 연관된 아이템 오브젝트도 이 키를 받게 된다.

예제에서는 UUIDs(universally unique identifiers)를 사용한다.

## 15.6. Persisting Images to Disk

Item 인스턴스의 이미지는 Documents 디렉토리에 저장해야 한다.

`guard` 키워드

- `if`와 비슷하지만 주요 차이점이 있음
- `if`와 달리 `guard`는 반드시 `else`가 필요함
- `guard`는 조건이 false일 때 else를 실행함

## 15.7. Loading Images from the ImageStore
