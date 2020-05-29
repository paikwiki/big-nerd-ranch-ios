# Chapter 20. Web Services

## 20.1. Starting the Photorama Application

작성할 내용 없음

## 20.2. Building the URL

리퀘스트(requests)

- 애플리케이션과 서버 사이의 상호작용에 대한 정보를 캡슐화한 것
- 도착 URL: 정보의 가장 중요한 조각

query item

- 키-값(key-value) 쌍으로 이루어진 url의 일부

생성할 두 개의 자료형

- FlickrAPI 구조체: 플리커와 관련된 모든 정보를 알고, 조작함. URL 제너레이팅도 담당
- EdnPoint 열거형: 플리커 엔드포인트와 일치하는 원시값(a raw value)을 담음

`static`과 `class` 키워드

- class 프로퍼티와 메서드는 서브클래스에서 오버라이딩 할 수 있음
- static 프로퍼티와 메서드는 서브클래스에서 오버라이딩 할 수 없음

`URLComponents`, `URLQueryItem`

## 20.3. Sending the Request

- `URLSession` API: 서버와 통신할 수 있는 요청을 사용하는 클래스의 집합. 주어진 설정에 맞는 태스크 생성을 담당. `URLSessionTask`의 팩토리로서 행동
- `URLSessionTask`: 서버와 통신을 담당하는 클래스

`URLRequest`의 프로퍼티

- allHTTPHeaderFields: 문자열 인코딩과 서버가 캐시를 조작할 방법을 포함한 HTTP 트랜잭션에 대한 메타데이터 딕셔너리
- allowsCellularAccess: 요청에 셀룰러 데이터를 허용할 것인지를 나타내는 불 값
- cachePolicy: 로컬 캐시를 사용할 것인지에 여부와 그 방법 대해 정의한 프로퍼티
- httpMethod: 요청 메서드. GET이 기본이며 POST, PUT, DELETE 등이 있음
- tiemoutInterval: 서버가 접속을 시도할 최대 기간

- `URLSessionDataTask`: 서버로부터 데이터를 가져와서 이를 메모리에 Data로서 반환헤줌
- `URLSessionDownloadTask`: 서버로부터 데이터를 가져와서 이를 파일시스템에 파일로 저장
- `URLSessionUploadTask`: 서버로 데이터를 전송

`URLSessionDataTask.resume()`

- 웹 서비스 요청을 시작함

## 20.4. Modeling the Photo

`Photo.swift` 코드

```swift
import Foundation

class Photo {
  let title: String
  let remoteURL: URL
  let photoID: String
  let dateTaken: Date
}
```

## 20.5. JSON Data

`JSONDecoder`, `JSONEncoder`

- `Codable` 프로토콜을 따름

웹서비스가 `first_name`이라는 이름의 키를 반환해도,`firstName` 프로퍼티 이름으로 쓰기 위해서는 `CodingKey` 프로토콜을 활용한다.

```swift
struct FlickrResponse: Codable {
  let photosInfo: FlickrPhotosResponse

  enum CodingKeys: String, CodingKey {
    case photosInfo = "photos"
  }
}
struct FlickrPhotosResponse: Codable {
  let photos: [Photo]

  enum CodingKeys: String, CodingKey {
    case photos = "photo"
  }
}
```

## 20.6. Enumerations and Associated Values

열거형에서 연관된 값(associated values) 예시

```swift
enum OvenState {
  case on(Double)
  case off
}

var ovenState = OvenState.on(450)
```

## 20.7. Passing the Photos Around

`Result` 타입

- 스위프트 표준 라이브러리에 정의된 열거형. 처리의 성공/실패 결과를 캡슐화
- `success`와 `failure` 두 가지 케이스가 있음
- `generic` 타입

`@escaping` 어노테이션

- 컴파일러가 클로저가 메서드 내부에서 즉시 호출되지 않을 것임을 알게 함

## 20.8. Downloading and Displaying the Image Data

정리할 내용 없음

## 20.9. The Main Thread

`parallel computing`, `thread`

- 메인쓰레드의 블로킹을 방지하기 위해 `URLSessionDataTask`는 백그라운드 쓰레드에서 실행되고, 완료 핸들러는 이 쓰레드를 호출한다.

`OperationQueue` 클래스: 다른 쓰레드를 사용

`OperationQueue` 관련 코드

```swift
func fetchImage(for photo: Photo, completion: @escaping (Result<UIImage, Error>) -> Void) {
  guard let photoURL = photo.remoteURL else {
    completion(.failure(PhotoError.missingImageURL))
    return
  }
  let request = URLRequest(url: photoURL)

  let task = session.dataTask(with: request) {
    (data, response, error) in

    let result = self.processImageRequest(data: data, error: error)
    OperationQueue.main.addOperation {
        completion(result)
    }
  }
  task.resume()
}
```
