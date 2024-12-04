# LectureNote | 02. More SwiftUI

> **주의:** 이 노트는 제 개인적인 학습을 위한 것입니다. 따라서 내용이 공식 강의 자료와 다를 수 있습니다. 제 이해를 돕기 위해 저만의 방식으로 정리한 점 참고 부탁드립니다.


### 💡 Keywords

- ViewBuilder - Immutable Views
- @State
- Array & Generic
- ForEach
- LazyVGrid

### Locals in @ViewBuilder

- 지역변수: ViewBuilder에서 변수 선언은 가능하지만, `let` 또는 read-only `var` 만 허용됨.
- ViewBuilder는 conditionals, lists, variable assignments 정도만 지원.
> **Why??** <br/>
> ViewBuilder는 UI를 선언적으로 정의하는 것이 목적이기 때문! <br/>
> 그렇기에 View는 불변(immutable)구조이다.

### @State

- View에서 **일시적인 상태**를 관리하기 위해 사용
  - ex) 애니메이션 상태 추적
- 내부적으로 메모리의 포인터를 사용해 상태를 추적, 그렇기에 포인터 자체는 변경되지 않지만 가리키는 값은 변경됨.

### Array

- `Array<String>` = `[String]` 
- Generic으로 모든 타입의 요소를 처리 가능

### ForEach

```swift
ForEach(emojis.indices, id: \.self) { index in
    Text(emojis[index])
}
```

### LazyVGrid

```swift
LazyVGrid(columns: [GridItem(), GridItem()]) {
    ForEach(0..<cardCount, id: \.self) { index in
        CardView(content: emojis[index])
    }
}
```

- HStack은 가능한 모든 공간을 사용하지만, LazyVGrid는 필요한 만큼만(최소공간만) 사용함.


### Extra
- Trailing Closure
- Type Inference
- 일반적으로 ViewModifier는 하위뷰에 적용되지만, padding은 해당뷰에만 적용됨.
- implicit return (return 생략)은 한 줄로 표현 가능할 때만 사용 가능.
- internal vs external parameter name
- opacity - 뷰의 크기와 레이아웃을 유지하면서, 가시성만 조절 가능
- aspectRatio
- ScrollView
