# study_flutter

A new Flutter project.

### 플러터 위젯

#### StatelessWidget

-   상태가 없는 위젯, 변화가 거의 없는 위젯은 이것으로 선언힌다.

#### StatefulWidget

-   State 변화를 감지하고, state가 변할시 위젝을 rebuild하는 위젯. setState로 state를 컨트롤함.

### Provider pattern

#### 정의

-   하나 이상의 view widget에서 똑같은 State(상태)를 바라보고, 필요로 할 때 Widget트리 최상단에서 View Model과 연결된 Provider를 통해 State(상태)를 관리하고 각 view에서 사용할 logic(기능)을 제공해준다.

##### Provider

-   Provider는 Widget tree 어디에서든 ViewModel이 관리하는 State(상태)와 logic(기능)을 공급 해주기 위한 클래스로 Widget tree 최상단에 존재한다.

##### Consumer

-   Provider.of를 지원하는 Widget을 build 하는 클래스이다.
-   주 기능으로, Provider의 상태를 읽어오고, 상태에 따라 화면을 그리는 기능을 한다.

#### 방법론

-   Provider는 어떤 View가 자신을 필요로 할지 모르기에, 특정 View에 종속되면 안되기 때문에, MVVM 디자인 패턴을 통해, view와 viewModel의 관심사를 철저히 분리하도록 한다.
-   view는 오직 데이터를 받아 화면에 보여주는 일에만 관심사를 두도록 코드를 작성한다.
-   view model은 state를 관리하는데, 집중하고 state가 변경 될 경우, view(Consumer)에게 notifyListeners로 알려준다.
