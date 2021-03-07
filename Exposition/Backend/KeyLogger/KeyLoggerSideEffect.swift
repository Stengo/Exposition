import Foundation

func keyLoggerSideEffect() -> SideEffect {
    return { action, _, _ in
        switch action {
        default:
            return
        }
    }
}
