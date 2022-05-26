# UnsplashMVVMC

## 빌드 관련

첫 빌드 시 빌드가 되지 않을 것입니다. Unsplash 오픈 API를 사용했으며, 가입 후 API 사용을 위한 ClientID를 받은 후 사용할 수 있습니다. 프로젝트 내 Data 폴더의 하위 폴더인 Network에서 APIEndpointForMoya, APIEndpoint 파일(이 프로젝트에는 Moya 라이브러리와 URLSession을 사용한 두 가지 경우의 수가 담겨 있습니다.)의 ClientID 값을, 부여받은 ClientID로 변경한 후에 빌드하시기 바랍니다. 

## 두 가지 네트워크

Presentation, ImageListView, ViewModel 폴더 순으로 접근하면 `didFetchUsingMoya()` 및 `didFetch()` 메소드가 정의되어 있습니다. 같은 계층의 폴더인 Controller 폴더의 `ImageSourcesViewController` 파일에서 `viewDidLoad()`에 있는 `self.imageSourcesViewModel.didFetchUsingMoya()` 부분을 앞서 살펴본 두 가지 메소드 중 한 가지로 바꿔서 사용할 수 있습니다.

## 사용한 것들

- MVVM-C
- Dependency Injection (DI Container)

- SnapKit(스토리보드가 없습니다.)
- Moya
- Realm
