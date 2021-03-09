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

    private lazy var topLeftItem: NSMenuItem = {
        let item = NSMenuItem(title: "Top Left", action: #selector(didSelectTopLeft), keyEquivalent: "")
        item.target = self
        return item
    }()

    private lazy var topRightItem: NSMenuItem = {
        let item = NSMenuItem(title: "Top Right", action: #selector(didSelectTopRight), keyEquivalent: "")
        item.target = self
        return item
    }()

    private lazy var bottomLeftItem: NSMenuItem = {
        let item = NSMenuItem(title: "Bottom Left", action: #selector(didSelectBottomLeft), keyEquivalent: "")
        item.target = self
        return item
    }()

    private lazy var bottomRightItem: NSMenuItem = {
        let item = NSMenuItem(title: "Bottom Right", action: #selector(didSelectBottomRight), keyEquivalent: "")
        item.target = self
        return item
    }()

    private lazy var showCombinationsItem: NSMenuItem = {
        let item = NSMenuItem(
            title: "Show ^⌥⌘ combinations only",
            action: #selector(didSelectShowCombinationsOnly),
            keyEquivalent: ""
        )
        item.target = self
        return item
    }()

    private lazy var menu: NSMenu = {
        let menu = NSMenu()

        menu.addItem(showCombinationsItem)

        let positionItem = NSMenuItem(title: "Position", action: nil, keyEquivalent: "")
        let positionSubmenu = NSMenu()
        positionSubmenu.addItem(topLeftItem)
        positionSubmenu.addItem(topRightItem)
        positionSubmenu.addItem(bottomLeftItem)
        positionSubmenu.addItem(bottomRightItem)
        positionItem.submenu = positionSubmenu
        menu.addItem(positionItem)

        menu.addItem(withTitle: "Quit Exposition", action: #selector(NSApplication.terminate), keyEquivalent: "")

        return menu
    }()

    init() {
        store.subscribe(self) { subscription in
            subscription
                .select(MenuStateFragment.init)
                .skipRepeats()
        }
        statusItem.menu = menu
    }

    func newState(state: MenuStateFragment) {
        DispatchQueue.main.async {
            self.updateMenu(with: state)
        }
    }

    func updateMenu(with stateFragment: MenuStateFragment) {
        showCombinationsItem.state = stateFragment.settingsState.shouldShowCombinationsOnly ? .on : .off

        let position = stateFragment.settingsState.position
        topLeftItem.state = position == .topLeft ? .on : .off
        topRightItem.state = position == .topRight ? .on : .off
        bottomLeftItem.state = position == .bottomLeft ? .on : .off
        bottomRightItem.state = position == .bottomRight ? .on : .off
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
