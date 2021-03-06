import Cocoa
import ReSwift

enum AppDelegateAction: Action {
    case didFinishLaunching
    case willTerminate
}

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    private lazy var window: NSWindow = {
        let window = NSWindow(contentViewController: overlayViewController)
        window.styleMask = [.borderless]
        window.isOpaque = false
        window.backgroundColor = .clear
        window.level = .floating
        window.ignoresMouseEvents = true
        window.hasShadow = false
        window.collectionBehavior = .canJoinAllSpaces
        return window
    }()

    private lazy var overlayViewController: OverlayViewController = {
        let viewController = OverlayViewController()
        return viewController
    }()

    private var menuHandler: MenuHandler?

    func applicationDidFinishLaunching(_: Notification) {
        updateWindowFrame()

        menuHandler = MenuHandler()

        store.dispatch(AppDelegateAction.didFinishLaunching)
    }

    func applicationWillTerminate(_: Notification) {
        store.dispatch(AppDelegateAction.willTerminate)
    }

    func applicationDidChangeScreenParameters(_: Notification) {
        updateWindowFrame()
    }

    private func updateWindowFrame() {
        window.makeKeyAndOrderFront(nil)
        let screenFrame = NSScreen.main?.frame ?? .zero
        window.setFrame(screenFrame, display: true)
    }
}
