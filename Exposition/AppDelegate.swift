import Cocoa
import ReSwift

enum AppDelegateAction: Action {
    case didFinishLaunching
}

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    private let statusItem: NSStatusItem = {
        let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)

        statusItem.button?.image = NSImage(named: NSImage.Name("statusBarIcon"))

        let menu = NSMenu()
        menu.addItem(
            NSMenuItem(
                title: "Quit Exposition",
                action: #selector(NSApplication.terminate),
                keyEquivalent: ""
            )
        )
        statusItem.menu = menu

        return statusItem
    }()

    private lazy var window: NSWindow = {
        let window = NSWindow(contentViewController: overlayViewController)
        window.styleMask = [.borderless]
        window.isOpaque = false
        window.backgroundColor = .clear
        window.level = .floating
        window.ignoresMouseEvents = true
        window.hasShadow = false
        return window
    }()

    private lazy var overlayViewController: OverlayViewController = {
        let viewController = OverlayViewController()
        return viewController
    }()

    func applicationDidFinishLaunching(_: Notification) {
        window.makeKeyAndOrderFront(nil)
        let screenFrame = NSScreen.main?.frame ?? .zero
        window.setFrame(screenFrame, display: true)

        store.dispatch(AppDelegateAction.didFinishLaunching)
    }
}
