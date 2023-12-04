# my_run_club
올해 초중반쯤, JavaScript 를 이용한 러닝기록 웹 사이트를 프로젝트로 구현한 적이 있다.
그리고 중후반쯤, TypeScript 로 리팩토링을 진행했었다.
그리고 Vue 와 Flutter 앱 언어를 공부를 해보다가 앱용으로 다시 한 번 프로젝트로 해보고 싶은 욕심에 진행하게 되었다.

</br>
</br>


## 주요 화면
1. 시작화면

<img src="https://velog.velcdn.com/images/jeongjwon/post/289d7255-17a9-443c-9334-e19fb2f3d3d6/image.png" width="200" >

2. 홈 화면 

| 주 | 월 | 년 | 리스트 |
|:--:|:--:|:--:|:--:|
|<img src="https://velog.velcdn.com/images/jeongjwon/post/144ed21c-494c-484a-acbf-b49569c63cdd/image.png" width="200" >|<img src="https://velog.velcdn.com/images/jeongjwon/post/ec238c79-780d-48f9-b56b-e2d8bd0867fd/image.png" width="200" >|<img src="https://velog.velcdn.com/images/jeongjwon/post/c41bfeab-2a34-471b-9274-b7d78b58daaf/image.png" width="200" >|<img src="https://velog.velcdn.com/images/jeongjwon/post/759a4eaf-07e5-42b2-9b93-370cb5b4d5a5/image.png" width="200" >|

3. 러닝 추가 화면

|기본|날짜|날짜 선택|시각 선택|
|:--:|:--:|:--:|:--:|
|<img src="https://velog.velcdn.com/images/jeongjwon/post/f0c5c849-e005-4e98-9965-ed7769910c06/image.png" width="200" >|<img src="https://velog.velcdn.com/images/jeongjwon/post/0c2c8b2b-a9e8-4fab-8a05-9219c324546f/image.png" width="200" >|<img src="https://velog.velcdn.com/images/jeongjwon/post/043c46eb-e8c9-46e2-957b-fbf8f8bf0a77/image.png" width="200" >|<img src="https://velog.velcdn.com/images/jeongjwon/post/c8ff42ce-74af-429c-94ad-e7f598c067d7/image.png" width="200" >|

|거리|운동 시간| 페이스|실내 선택 후 저장 전|
|:--:|:--:|:--:|:--:|
|<img src="https://velog.velcdn.com/images/jeongjwon/post/7e732d30-f6c8-4ae0-9b15-bd2fc951e790/image.png" width="200" >|<img src="https://velog.velcdn.com/images/jeongjwon/post/33d9568b-3baf-4737-b9e6-f7917ed8bac3/image.png" width="200" >|<img src="https://velog.velcdn.com/images/jeongjwon/post/b99e7d55-55bb-4cd3-95ca-1668ee74523f/image.png" width="200" >|<img src="https://velog.velcdn.com/images/jeongjwon/post/b26c318f-a396-4e42-a392-9bf295556597/image.png" width="200" >|

3. 상세 화면

|기본|러닝강도 선택 | 러닝 장소 선택 | 메모 |
|:--:|:--:|:--:|:--:|
|<img src="https://velog.velcdn.com/images/jeongjwon/post/cd60a2a6-a093-4b94-9beb-b4ecbaa8bc9a/image.png" width="200" >|<img src="https://velog.velcdn.com/images/jeongjwon/post/7461ac1f-47bf-4230-ad19-04562a71b494/image.png" width="200" >|<img src="https://velog.velcdn.com/images/jeongjwon/post/3fbafc5c-aa8a-4208-a3ca-8aa73c8dd090/image.png" width="200" >|<img src="https://velog.velcdn.com/images/jeongjwon/post/0df1ade1-7a23-41ca-b2df-487e3a851c40/image.png" width="200">|

|모든 섹션 저장|삭제|
|:--:|:--:|
|<img src="https://velog.velcdn.com/images/jeongjwon/post/f79b4064-849f-4c22-b5ff-0190cee8b9a3/image.png" width="200">|<img src="https://velog.velcdn.com/images/jeongjwon/post/f00d9258-5c95-4b28-8042-9b9d68149a65/image.png" width="200" >|





</br>
</br>

## 주요 기능
### 1. 러닝 기록 CRUD 기능
- **러닝 활동 추가** : 홈 화면 우측 상단의 '+' 버튼을 클릭시 활동 추가 화면으로 이동한다. 활동 추가 화면에서 정보 (날짜, 거리, 운동시간, 페이스)를 사용자의 입력을 통해 저장을 하면 러닝 활동이 생성이 된다.
- **러닝 활동 읽기** : 홈 화면 하단에는 추가된 러닝 활동 리스트를 볼 수 있다. 
- **러닝 활동 변경** : 홈 화면의 러닝 활동 리스트 중 각각의 러닝 활동을 클릭시 상세 화면으로 이동한다. 상세 화면에서 간단히 입력한 정보를 볼 수 있고, 추가적으로 러닝 활동에 대한 러닝 강도, 러닝 장소, 메모를 추가적으로 정보를 입력할 수 있다.
- **러닝 활동 삭제** : 러닝 활동 상세 화면에서 제목 우측의 쓰레기통 아이콘 클릭시 작은 하단 모달 스크린을 통해 삭제 확인을 통해 삭제를 확정하거나 취소할 수 있다.


</br>

### 2. 러닝 기록 요약
- **주, 월, 년 주기로 기록 요약** : 추가된 러닝 활동들을 상단 탭을 활용해  주, 월, 년 주기로  평균치의 기록을 요약하여 볼 수 있도록 했다.(*추가적으로 전체 탭이 있지만 아직 구현하지 못했다.*)
- **바 차트 정리** : 주기 기준으로 글, 숫자로 요약된 위젯 아래, 주(월 ~ 일), 월(1일 ~ 30/31일), 년(1월 ~ 12월)을 분리하여 기록된 활동이 있다면 기록을 기준으로 바차트로 파랗게 표시할 수 있도록 했다. 바차트를 클릭시 해당 달린 거리를 표시할 수 있다.

</br>

### 3. 러닝 기록 DB 
- **Firebase 연동** : 러닝 활동 추가 화면에서 정보를 입력 후, 저장 버튼을 누르면 firebase cloud-store 의 Runnings 라는 컬렉션 안에 자동으로 생성된 문서 ID 에 입력한 정보들이 쌓이게 된다.
- **전역 상태 관리 Provider** : 추가된 러닝 활동들은 사용되는 위젯이 많기 때문에 유지보수를 위해 Provider 를 사용하여 간단히 firebase 에서 읽어와 리스트로 저장을 해둔채로 StreamBuilder 를 이용해 불러올 수 있도록 했다.
