import ReSwift

struct SettingsState: StateType, Equatable, Codable {
    enum Position: String, Equatable, Codable {
        case topLeft
        case topRight
        case bottomLeft
        case bottomRight
    }

    let shouldShowCombinationsOnly: Bool
    let position: Position

    static var initialState: SettingsState {
        return SettingsState(
            shouldShowCombinationsOnly: false,
            position: .bottomRight
        )
    }
}

func settingsReducer(action: Action, state: SettingsState) -> SettingsState {
    switch action {
    case MenuAction.didToggleShowCombinationsOnly:
        return SettingsState(
            shouldShowCombinationsOnly: state.shouldShowCombinationsOnly == false,
            position: state.position
        )

    case let SettingsRestorationAction.didSucceed(settings):
        return settings

    case let MenuAction.didSelectPosition(position):
        return SettingsState(
            shouldShowCombinationsOnly: state.shouldShowCombinationsOnly,
            position: position
        )

    default:
        return state
    }
}
