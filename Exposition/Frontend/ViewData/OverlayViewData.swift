import Foundation

struct OverlayStateFragment: Equatable {}

struct OverlayViewData: ViewDataType {
    typealias StateFragment = OverlayStateFragment

    static func fragment(of _: AppState) -> StateFragment {
        return StateFragment()
    }

    init(for _: StateFragment) {}
}
