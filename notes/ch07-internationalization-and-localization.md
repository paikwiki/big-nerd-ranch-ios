# Chapter 7. Internationalization and Localization

internationalization and localization

- internationalization: 개발자가 속한 문화 기반의 정보(your native cultural information)을 앱에 하드코딩하지 않아야 함
- internationalization 대상: 언어(language), 통화(currency), 날짜 형식(date format), 숫자 형식(number format) emdemd
- localization: 사용자의 언어와 지역 설정에 기반해 적절한 데이터를 제공해줌

i18n, L10n

- internationalization과 localization은 긴 단어이므로 소프트웨어 개발 세계에서는 i18n과 L10n으로 줄여서 부름

## 7.1. Internationalization

스페인으로 로케일을 설정한 후 에뮬레이터를 실행하면 에러 발생하고 키보드가 출력되지 않는다. 아래는 에뮬레이터를 실행한 후 키보드를 활성화하기 위해 텍스트필드를 선택한 직후까지 콘솔에 출력된 에러 메시지이다.

```txt
2020-05-17 18:57:15.389831+0900 WorldTrotter[30228:446156] Metal API Validation Enabled
MapViewController loaded its view.
2020-05-17 18:57:15.536292+0900 WorldTrotter[30228:446156] libMobileGestalt MobileGestalt.c:1647: Could not retrieve region info
ConversionViewController loaded its view.
2020-05-17 18:57:34.812300+0900 WorldTrotter[30228:446156] Can't find keyplane that supports type 8 for keyboard iPhone-PortraitChoco-DecimalPad; using 25793_PortraitChoco_iPhone-Simple-Pad_Default
2020-05-17 18:57:34.834750+0900 WorldTrotter[30228:446156] Can't find keyplane that supports type 8 for keyboard iPhone-PortraitChoco-DecimalPad; using 25793_PortraitChoco_iPhone-Simple-Pad_Default

```

- 관련 링크: [The Decimal Pad error. Help](https://forums.bignerdranch.com/t/the-decimal-pad-error-help/11628/3)

현재 로케일 가져오기

```swift
let currentLocale = Locale.current
```

NumberFormatter 인스턴스의 `number(from:)` 메서드

- 문자열을 숫자로 변경해주는 메서드. number formatter가 로케일을 알고 있으므로 이에 맞춰 변환이 가능함

텍스트뿐만 아니라 이미지, 사운드, 인터페이스 파일 등 다양한 요소를 로컬라이징하기 위해서는 iOS 앱이 지역화 리소스(localized resources)를 다루는 방법을 알아야 한다.

lproj 디렉토리

- 이 디렉토리 각각에는 lproj가 뒤에 붙어있음
- 예: en_US -> en_US.lproj

지역화의 한 가지 방법은 각각 분리된 스토리보드를 만드는 것이다. 하지만 이는 좋지 못한 방법이다.

다른 방법은 base internationalization 기능을 사용하는 것이다.

Localizable.strings 파일

제약 속성 인스펙터에 대한 메모

- Which element is the First Item and which the Second Item is only important when the constraint involves either a multiplier(such as when one item sholud be half the width of the other, which you will see an example of in Chapter 17) or a constant (such as when ont iem should be exactly 20 points wider than the other).

불평등 제약(inequality constraints)

- 예시: 관계(Relation)를 Greater Than or Equal로 설정

레이블의 줄수(Lines)를 0으로 하면 여러 줄로 출력할 수 있음

## 7.2. Localization
