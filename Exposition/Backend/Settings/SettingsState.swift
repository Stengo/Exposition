import ReSwift

struct SettingsState: StateType, Equatable {
    let shouldShowCombinationsOnly: Bool

    static var initialState: SettingsState {
        return SettingsState(shouldShowCombinationsOnly: false)
    }
}

func settingsReducer(action: Action, state: SettingsState) -> SettingsState {
    switch action {
    case MenuAction.didToggleShowCombinationsOnly:
        return SettingsState(shouldShowCombinationsOnly: state.shouldShowCombinationsOnly == false)
    default:
        return state
    }
}
