public func join<State, Action>(effects: Effect<State, Action>...) -> Effect<State, Action> {
    join(effects: effects)
}

public func join<State, Action>(effects: [Effect<State, Action>]) -> Effect<State, Action> { { state, action, dispatch in
        effects.forEach { effect in
            effect(state, action, dispatch)
        }
    }
}
