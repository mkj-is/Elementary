public func combine<State, Action>(effects: Effect<State, Action>...) -> Effect<State, Action> {
    combine(effects: effects)
}

public func combine<State, Action>(effects: [Effect<State, Action>]) -> Effect<State, Action> {
    { state, action, dispatch in
        effects.forEach { effect in
            effect(state, action, dispatch)
        }
    }
}
