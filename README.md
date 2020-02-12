# Elementary

**Elementary** is experimental, uni-directional and purely functional architecture in Swift.
It is inspired by ELM and Redux. Main motivation behind this was the introduction of SwiftUI,
but this core package is not dependent neither Combine or SwiftUI.

## Installation

When using Swift package manager install using Xcode 11+ or add following line to your dependencies:

```swift
.package(url: "https://github.com/mkj-is/Elementary.git", from: "0.1.0")
```

### Extensions

Base extension for making SwiftUI apps is [ElementaryCombine](https://github.com/mkj-is/ElementaryCombine).
Don't hesitate with using this one if you are supporting only newest Apple operating systems.

Another truly experimantal extension is [ElementaryEffectBuilder](https://github.com/mkj-is/ElementaryEffectBuilder).
This one is for combining side-effects using the new Swift function builders.

## Usage

Everything is bound together by initializing `Store` with these components:

- *State* (model from which the whole user interface can be built.)
- *Actions* (anything that can happen in your code, both user actions and actions that are dispatched by your side-effects.)
- *Update function* (which takes state and action and creates new state.)
- *Effects* (functions which are called after the update and can dispatch back actions asynchronously.)

## Examples

Let's take a first example: Simple implementation of a counter, where user can increment, decrement and reset it.

Firstly, we need to define all the actions. In this case, some enum should be sufficient:

```swift
enum CounterAction {
    case increment, decrement, reset
}
```

Then we implement the function taking state and action and updates the state.
The only thing which should be happening here is changing the state.

```swift
func updateCounter(state: inout Int, action: CounterAction) {
    switch action {
    case .increment:
        state += 1
    case .decrement:
        state = max(0, state - 1)
    case .reset:
        state = 0
    }
}
```
The last thing we need to do is initialize the store. This code does exactly that
and simulates sample run through the app. Testability is one of the key features
of this decomposition, you can see for yourself
in the example [test cases](Tests/Elementarytests/CounterTests.swift).

```swift
let store = Store(state: 0, update: updateCounter)
store.dispatch(.increment)
store.dispatch(.increment)
store.dispatch(.decrement)
store.dispatch(.increment)
store.dispatch(.reset)
store.state
```

### Effects

Most client apps need to execute some asynchronous work.
Let's take simple stopwatch, which increments the state every second.

```swift
enum StopwatchAction {
    case start, stop, increment, reset
}


func updateStopwatch(state: inout Int, action: StopwatchAction) {
    switch action {
    case .reset:
        state = 0
    case .increment:
        state += 1
    case .start, .stop:
        break
    }
}
```

Now we have all the actions and update function defined.
Next step is writing function which returns new side-effect
with captured-value of the timer. The effect will only react
on two actions, start and stop. When these actions are dispatched
the timer is either started or stopped. `DispatchSourceTimer`
is used to make this code multiplatform and backward-compatible.

```swift
func createStopwatchEffect() -> Effect<Int, StopwatchAction> {
    var timer: DispatchSourceTimer?
    return { _, action, dispatch in
        switch action {
        case .start:
            timer = DispatchSource.makeTimerSource()
            timer?.schedule(deadline: .now(), repeating: 1)
            timer?.setEventHandler {
                dispatch(.increment)
            }
            timer?.resume()
        case .stop, .reset:
            timer?.cancel()
            timer = nil
        case .increment:
            break
        }
    }
}
```

## Contributing

All contributions are welcome.

Project was created by [Matěj Kašpar Jirásek](https://github.com/mkj-is).

Project is licensed under [MIT license](LICENSE.txt).
