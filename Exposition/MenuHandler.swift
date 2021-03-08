import Cocoa
import ReSwift

enum MenuAction: Action {
    case didToggleShowCombinationsOnly
}

final class MenuHandler: StoreSubscriber {
    typealias StoreSubscriberStateType = MenuStateFragment

    struct MenuStateFragment: Equatable {
        let settingsState: SettingsState

        init(appState: AppState) {
            settingsState = appState.settingsState
        }
    }

    private lazy var statusItem: NSStatusItem = {
        let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        statusItem.button?.image = NSImage(named: NSImage.Name("statusBarIcon"))
        return statusItem
    }()

    init() {
        store.subscribe(self) { subscription in
            subscription
                .select(MenuStateFragment.init)
                .skipRepeats()
        }
    }

    func newState(state: MenuStateFragment) {
        DispatchQueue.main.async {
            self.createMenu(from: state)
        }
    }

    func createMenu(from stateFragment: MenuStateFragment) {
        let menu = NSMenu()
        let item = NSMenuItem(
            title: "Show ^⌥⌘ combinations only",
            action: #selector(didSelectShowCombinationsOnly),
            keyEquivalent: ""
        )
        item.state = stateFragment.settingsState.shouldShowCombinationsOnly ? .on : .off
        item.target = self
        menu.addItem(item)
        menu.addItem(
            NSMenuItem(
                title: "Quit Exposition",
                action: #selector(NSApplication.terminate),
                keyEquivalent: ""
            )
        )
        statusItem.menu = menu
    }

    @objc private func didSelectShowCombinationsOnly() {
        store.dispatch(MenuAction.didToggleShowCombinationsOnly)
    }
}
