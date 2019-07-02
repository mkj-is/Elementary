
public protocol Store {
    associatedtype Action

    func dispatch(_ action: Action) -> Call
}
