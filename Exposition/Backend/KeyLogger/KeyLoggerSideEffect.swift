import Cocoa
import Foundation

func keyLoggerSideEffect() -> SideEffect {
    return { action, dispatch, _ in
        switch action {
        case AppDelegateAction.didFinishLaunching:
            guard isPermissionGranted(shouldAskForPermission: true) else {
                restartWhenPermissionIsGranted()
                return
            }
            NSEvent.addGlobalMonitorForEvents(matching: [.keyDown]) { event in
                let keyEvent = KeyEvent(
                    keyCode: event.keyCode,
                    modifierFlags: event.modifierFlags,
                    date: Date()
                )
                dispatch(KeyLoggerAction.didTrigger(keyEvent))
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
