import Cocoa
import Foundation
import Sauce

func keyLoggerSideEffect() -> SideEffect {
    return { action, _, _ in
        switch action {
        case AppDelegateAction.didFinishLaunching:
            guard isPermissionGranted(shouldAskForPermission: true) else {
                restartWhenPermissionIsGranted()
                return
            }
            NSEvent.addGlobalMonitorForEvents(matching: [.keyDown]) { event in
                let key = Sauce.shared.key(by: Int(event.keyCode))
                print("\(key)")
            }

        default:
            return
        }
    }
}

private func isPermissionGranted(shouldAskForPermission: Bool) -> Bool {
    if shouldAskForPermission {
        let options: NSDictionary = [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String: true]
        return AXIsProcessTrustedWithOptions(options)
    } else {
        return AXIsProcessTrusted()
    }
}

private func restartWhenPermissionIsGranted() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        guard isPermissionGranted(shouldAskForPermission: false) else {
            restartWhenPermissionIsGranted()
            return
        }
        restart()
    }
}

private func restart() {
    Process.launchedProcess(
        launchPath: "/bin/sh",
        arguments: [
            "-c",
            "sleep 3 ; /usr/bin/open '\(Bundle.main.bundlePath)'",
        ]
    )
    NSApplication.shared.terminate(nil)
}
