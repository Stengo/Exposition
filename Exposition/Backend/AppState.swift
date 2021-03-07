import ReSwift

struct AppState: StateType, Equatable {
    let keyLoggerState: KeyLoggerState

    static var initialState: AppState {
        return AppState(
            keyLoggerState: .initialState
        )
    }
}

func appReducer(action: Action, state: AppState?) -> AppState {
    let state = state ?? .initialState

    return AppState(
        keyLoggerState: keyLoggerReducer(action: action, state: state.keyLoggerState)
    )
}
