
public protocol Store {
    func dispatch(_ action: Action) -> Call
}
