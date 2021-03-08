import ReSwift

struct AppState: StateType, Equatable {
    let keyLoggerState: KeyLoggerState
    let settingsState: SettingsState

    static var initialState: AppState {
        return AppState(
            keyLoggerState: .initialState,
            settingsState: .initialState
        )
    }
}

func appReducer(action: Action, state: AppState?) -> AppState {
    let state = state ?? .initialState

    return AppState(
        keyLoggerState: keyLoggerReducer(action: action, state: state.keyLoggerState),
        settingsState: settingsReducer(action: action, state: state.settingsState)
    )
}
