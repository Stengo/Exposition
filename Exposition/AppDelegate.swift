import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    let statusItem: NSStatusItem = {
        let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)

        statusItem.button?.image = NSImage(named:NSImage.Name("statusBarIcon"))

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

    let window: NSWindow = {
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 200, height: 80),
            styleMask: .borderless,
            backing: .buffered,
            defer: false
        )
        window.isOpaque = false
        window.backgroundColor = NSColor.green.withAlphaComponent(0.5)
        window.level = .floating
        window.ignoresMouseEvents = true
        window.makeKeyAndOrderFront(nil)
        return window
    }()


    func applicationDidFinishLaunching(_ aNotification: Notification) {
    }
}

