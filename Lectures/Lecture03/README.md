# LectureNote | 03. MVVM

> **주의:** 이 노트는 제 개인적인 학습을 위한 것입니다. 따라서 내용이 공식 강의 자료와 다를 수 있습니다. 제 이해를 돕기 위해 저만의 방식으로 정리한 점 참고 부탁드립니다.


### 💡 Keywords

- MVVM
- Struct vs Class
- OOP vs FP
- Generics
- Protocols
- Functions as Types
- Closures

### MVVM (Model-View-ViewModel)

1. MVVM의 핵심 개념
   - 애플리케이션 로직과 UI를 분리 -> UI는 Model의 *시각적 표현(visual manifestation)*
   - **Model**: 데이터와 로직을 관리하는 진실의 원천(The Truth)
   - **View**: Model을 시각적으로 표현하는 UI, 자체적으로 상태를 가지지 않음
     - Stateless, Declarative, Reactive
   - **ViewModel**: View와 Model을 연결하는 Interpreter/Gatekeeper 역할
2. MVVM 데이터 흐름
   - **Model -> View** 
     1) Model 변경(M) -> ViewModel이 감지(VM) -> 변경 내용을 Publish (VM)
     2) View가 해당 변경사항을 인식하여 UI 업데이트(V)
   - **View -> Model** : 
     1) V -> VM: 사용자가 View에서 어떤 행동을 하면, 이를 ViewModel의 함수로 전달 (사용자의 의도 전달)
     2) VM -> M: ViewModel은 사용자의 의도를 해석하고, Model을 적절히 수정(변경)
     3) M -> VM -> V: Model이 변경되면 ViewModel이 이를 감지하고 Publish, View에 변경사항을 전달하여 UI 업데이트

### Struct vs Class (값 타입 vs 참조 타입)

| | Struct (구조체) | Class (클래스) |
|:---:|:---:|:---:|
| 저장 방식 | 값을 직접 저장 | 포인터를 저장 (실제 데이터는 heap에 저장) |
| 메모리 관리 | Stack에 저장 | Heap에 저장 + ARC 관리 |
| 복사 방식 | 복사 시 새로운 개체 생성 (Copy on Write) | 복사해도 같은 개체를 참조 |
| 사용 사례 | 불변성 강조할 때 (ex. 데이터 모델) | 데이터 공유가 필요할 때 (ex. ViewModel) |

- **Copy on Write (COW)**
  - 값이 변경되면 새로운 인스턴스를 생성하여 변경된 값을 저장하는 방식
  - 즉, 데이터를 변경하기 전까지는 메모리를 공유하고 있다가, 변경하는 순간 복사본을 생성
- **Automatic Reference Counting (ARC)**
  - 클래스의 참조 개수를 추적하여, 참조 개수가 0이 되면 자동으로 메모릐를 해제
- **ViewModel에는 Class 사용하는 이유**
  - 여러 View에서 공유되기 때문
  - ViewModel의 역할이 "Gatekeeper"이기 때문에, 안전하게 공유 가능 (Model이 손상되지않음)

### OOP vs FP

- **OOP(Object-Oriented Programming)**
  - 데이터 중심
  - 객체가 데이터를 캡슐화하고, 해당 데이터를 다루는 메서드를 가짐
  - 상속(Inheritance) 기반 설계
  - 객체의 상태를 직접 변경 가능 (mutable by default)
- **FP(Functional Programming)**
  - 기능 중심
  - 데이터보다 함수(연산)자체를 중요하게 여김
  - 데이터 불변성(Immutability) 강조 - Immutable State
  - 코드의 예측가능성(Provability)이 증가

### Array 메서드 비교 `shuffle()` vs `shuffled()`

- `shuffle()`: 원본 배열을 섞음 (in-place) -> `var`로 선언된 배열에만 사용 가능
- `shuffled()`: 원본 배열을 섞은 새로운 배열을 반환 (불변성 유지)

> SwiftUI에서는 불변성을 중요하게 여기기 때문에, `shuffled()`를 사용하는 것을 선호

### Generics

- 타입에 구애받지않고(agnostic) 범용적인 코드 작성 가능

```swift
struct Stack<Element> {
    var elements: [Element] = []
    
    mutating func push(_ element: Element) {
        elements.append(element)
    }
    
    mutating func pop() -> Element? {
        elements.popLast()
    }
}
```

- `Element`의 타입을 정해놓지 않았기 때문에 어떤 타입이든 받을 수 있음

### Protocols

- 구현 없이 "동작"만 정의하는 개념
- 프로토콜을 사용하면 내부 구현을 숨길 수 있어서 코드 변경이 쉬움
  - 어떤 객체가 특정 프로토콜을 준수하기만 하면, 내부가 어떻게 동작하는지는 알 필요 없음

### Functions as Types & Closures

- 함수는 변수에 저장하거나 인자로 사용 가능 (First-class citizen)
- Closure는 주변 변수 캡쳐 가능 

> Closure의 변수 캡쳐 다시 확인하기