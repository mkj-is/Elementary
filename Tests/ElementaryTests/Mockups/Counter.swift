import Elementary

enum CounterAction {
    case increment, decrement, reset
}

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

func counterStore(state: Int = 0) -> Store<Int, CounterAction> {
    Store(
        state: state,
        update: updateCounter
    )
}
