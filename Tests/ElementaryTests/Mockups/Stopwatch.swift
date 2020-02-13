import Elementary
import Foundation

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

func createStopwatchEffect() -> Effect<Int, StopwatchAction> {
    var timer: DispatchSourceTimer?
    return { _, action, dispatch in
        switch action {
        case .start:
            timer = DispatchSource.makeTimerSource()
            timer?.schedule(deadline: .now() + 1, repeating: 1)
            timer?.setEventHandler {
                dispatch(.increment)
            }
            timer?.resume()
        case .stop, .reset:
            timer = nil
        case .increment:
            break
        }
    }
}

func stopwatchStore(state: Int = 0) -> Store<Int, StopwatchAction> {
    Store(
        state: state,
        update: updateStopwatch,
        effect: createStopwatchEffect()
    )
}
