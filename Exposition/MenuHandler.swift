import Cocoa
import ReSwift

enum MenuAction: Action {
    case didToggleShowCombinationsOnly
    case didSelectPosition(SettingsState.Position)
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

        let showCombinationsItem = NSMenuItem(
            title: "Show ^⌥⌘ combinations only",
            action: #selector(didSelectShowCombinationsOnly),
            keyEquivalent: ""
        )
        showCombinationsItem.state = stateFragment.settingsState.shouldShowCombinationsOnly ? .on : .off
        showCombinationsItem.target = self
        menu.addItem(showCombinationsItem)

        let positionItem = NSMenuItem(title: "Position", action: nil, keyEquivalent: "")
        let positionSubmenu = NSMenu()
        let topLeftItem = NSMenuItem(title: "Top Left", action: #selector(didSelectTopLeft), keyEquivalent: "")
        let topRightItem = NSMenuItem(title: "Top Right", action: #selector(didSelectTopRight), keyEquivalent: "")
        let bottomLeftItem = NSMenuItem(title: "Bottom Left", action: #selector(didSelectBottomLeft), keyEquivalent: "")
        let bottomRightItem = NSMenuItem(title: "Bottom Right", action: #selector(didSelectBottomRight), keyEquivalent: "")
        topLeftItem.target = self
        topRightItem.target = self
        bottomLeftItem.target = self
        bottomRightItem.target = self
        switch stateFragment.settingsState.position {
        case .topLeft:
            topLeftItem.state = .on
        case .topRight:
            topRightItem.state = .on
        case .bottomLeft:
            bottomLeftItem.state = .on
        case .bottomRight:
            bottomRightItem.state = .on
        }
        positionSubmenu.addItem(topLeftItem)
        positionSubmenu.addItem(topRightItem)
        positionSubmenu.addItem(bottomLeftItem)
        positionSubmenu.addItem(bottomRightItem)
        positionItem.submenu = positionSubmenu
        menu.addItem(positionItem)

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

    @objc private func didSelectTopLeft() {
        store.dispatch(MenuAction.didSelectPosition(.topLeft))
    }

    @objc private func didSelectTopRight() {
        store.dispatch(MenuAction.didSelectPosition(.topRight))
    }

    @objc private func didSelectBottomLeft() {
        store.dispatch(MenuAction.didSelectPosition(.bottomLeft))
    }

    @objc private func didSelectBottomRight() {
        store.dispatch(MenuAction.didSelectPosition(.bottomRight))
    }
}
