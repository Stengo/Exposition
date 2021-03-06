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

    @IBOutlet var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
    }
}

