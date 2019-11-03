public typealias Call = () -> Void
public typealias Dispatch<Action> = (Action) -> ()
public typealias Update<State, Action> = (inout State, Action) -> Void
public typealias Effect<State, Action> = (@escaping () -> State, Action, @escaping Dispatch<Action>) -> ()
