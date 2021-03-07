import Cocoa
import ReSwift

struct KeyLoggerState: StateType, Equatable {
    let latestKeyEvent: KeyEvent?

    static var initialState: KeyLoggerState {
        return KeyLoggerState(latestKeyEvent: nil)
    }
}

struct KeyEvent: Equatable {
    let keyCode: UInt16
    let modifierFlags: NSEvent.ModifierFlags
    let date: Date
}

enum KeyLoggerAction: Action {
    case didTrigger(KeyEvent)
}

func keyLoggerReducer(action: Action, state: KeyLoggerState) -> KeyLoggerState {
    switch action {
    case let KeyLoggerAction.didTrigger(keyEvent):
        return KeyLoggerState(latestKeyEvent: keyEvent)
    default:
        return state
    }
}
