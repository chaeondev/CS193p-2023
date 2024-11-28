# Lecture Note | 01. Getting Started with SwiftUI

> **주의:** 이 노트는 제 개인적인 학습을 위한 것입니다. 따라서 내용이 공식 강의 자료와 다를 수 있습니다. 제 이해를 돕기 위해 저만의 방식으로 정리한 점 참고 부탁드립니다.


### 💡 Keywords
- Object-Oriented Programming: OOP
- Functional Programming: FP
- Computed property
- Opaque return type: `some View`
- @ViewBuilder
- ViewModifier

### FP vs OOP

- OOP(Object-Oriented Programming) -> data encapsulation 이 핵심
- FP(Functional Programming) -> behavior encapsulation 이 핵심
  - 사물이 어떻게 동작하는지가 중요 `behaves like a ...`
  - focus on the functionality(the behavior), not on the data

### ContentView

```swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        Image(systemName: "globe")
            .padding()
    }
}
```

- `ContentView: View`
  - ContentView **behaves like** a View
    - responsibility: body 라는 property를 가지고 있어야 함
    - 해당 responsibility를 충족하면, View의 모든 functionality를 사용할 수 있음
    
    -> Leveraged kind of programming
- `var body: some View`
  - body는 computed property (get-only) <-> stored property
  - `some View`: some은 opaque return type
    - body가 어떤 View를 return하는지는 중요하지 않음
    - body가 View를 return한다는 것만 중요함
    - body가 return하는 View의 type은 컴파일러가 추론함

### Image(systemName: "globe")

- Creating instances of structs
- Named Parameters
- Parameter Defaults

### VStack
- VStack { } => parameter로 함수를 받음
- {}안의 여러 View를 묶어 하나의 View로 반환 (@ViewBuilder)

-> 중괄호 `{}`는 View를 반환하는 함수이며, SwiftUI는 이를 하나의 TupleView로 포장해서 처리함. 이때 @ViewBuilder는 여러 View를 자동으로 묶는데 사용됨

> ❓ TupleView 찾아보기

### ViewModifier
- View를 수정하고, 새로운 수정된 View를 반환하는 함수 (기존 View를 직접 수정X)
- chaining 가능
- **scope** : 적용 범위에 영향을 받음 -> 유연성
  ```swift
  VStack {
    Text("Hello")
    Text("World")
  }
  .foregroundStyle(.orange)
  ```
  - VStack 내부 모든 View가 orange -> View Modifier는 상위 View 적용되면 하위 View로 "전달"됨
  <br>

  ```swift
  VStack {
    Text("Hello").foregroundStyle(.black))
    Text("World")
  }
  .foregroundStyle(.orange)
  ```
  - 하위 View에서 명시적으로 modifier설정하면, 상위 View의 modifier의 영향을 받지 않음
  - "Hello"만 black, "World"는 orange
  
