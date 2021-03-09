import Foundation
import ReSwift

private let userDefaults = UserDefaults.standard
private let userDefaultsKey = "settings"

enum SettingsRestorationAction: Action {
    case didSucceed(SettingsState)
}

func settingsSideEffect() -> SideEffect {
    return { action, dispatch, getState in
        guard let appState = getState() else {
            return
        }
        switch action {
        case AppDelegateAction.willTerminate:
            let data = try? JSONEncoder().encode(appState.settingsState)
            userDefaults.setValue(data, forKey: userDefaultsKey)

        case AppDelegateAction.didFinishLaunching:
            guard
                let data = userDefaults.data(forKey: userDefaultsKey),
                let settings = try? JSONDecoder().decode(SettingsState.self, from: data)
            else {
                return
            }
            dispatch(SettingsRestorationAction.didSucceed(settings))

        default:
            return
        }
    }
}
