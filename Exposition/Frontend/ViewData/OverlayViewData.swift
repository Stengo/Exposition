import Foundation

struct OverlayStateFragment: Equatable {
}

struct OverlayViewData: ViewDataType {
    typealias StateFragment = OverlayStateFragment

    static func fragment(of appState: AppState) -> StateFragment {
        return StateFragment()
    }

    init(for fragment: StateFragment) {
    }
}
