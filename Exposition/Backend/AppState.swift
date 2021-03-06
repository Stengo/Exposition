import ReSwift

struct AppState: StateType, Equatable {
    static var initialState: AppState {
        return AppState()
    }
}

func appReducer(action: Action, state: AppState?) -> AppState {
    let state = state ?? .initialState

    return state
}
