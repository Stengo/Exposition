import ReSwift

struct SettingsState: StateType, Equatable, Codable {
    let shouldShowCombinationsOnly: Bool

    static var initialState: SettingsState {
        return SettingsState(shouldShowCombinationsOnly: false)
    }
}

func settingsReducer(action: Action, state: SettingsState) -> SettingsState {
    switch action {
    case MenuAction.didToggleShowCombinationsOnly:
        return SettingsState(shouldShowCombinationsOnly: state.shouldShowCombinationsOnly == false)

    case let SettingsRestorationAction.didSucceed(settings):
        return settings

    default:
        return state
    }
}
