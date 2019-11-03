
public final class Store<State, Action> {
    public private(set) var state: State
    private let update: Update<State, Action>
    private let effect: Effect<State, Action>?

    public init(
        state: State,
        update: @escaping Update<State, Action>,
        effect: Effect<State, Action>? = nil,
        initialAction: Action? = nil
    ) {
        self.state = state
        self.update = update
        self.effect = effect

        initialAction.flatMap(dispatch)
    }

    public func dispatch(_ action: Action) {
        update(&state, action)
        effect?({ self.state }, action, dispatch)
    }
}
