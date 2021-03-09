import Cocoa
import Foundation
import Sauce

struct OverlayStateFragment: Equatable {
    let keyLoggerState: KeyLoggerState
    let settingsState: SettingsState
}

struct OverlayViewData: ViewDataType {
    typealias StateFragment = OverlayStateFragment

    let keyCombination: KeyCombinationViewData
    let position: SettingsState.Position

    static func fragment(of appState: AppState) -> StateFragment {
        return StateFragment(
            keyLoggerState: appState.keyLoggerState,
            settingsState: appState.settingsState
        )
    }

    init(for fragment: StateFragment) {
        position = fragment.settingsState.position

        guard
            let keyEvent = fragment.keyLoggerState.latestKeyEvent,
            let key = Sauce.shared.key(by: Int(keyEvent.keyCode))
        else {
            keyCombination = KeyCombinationViewData(keys: [])
            return
        }

        let modifiersViewData = KeyViewData.keys(for: keyEvent.modifierFlags)
        let keyViewData = KeyViewData(key: key)
        keyCombination = KeyCombinationViewData(keys: modifiersViewData + [keyViewData])
    }
}

struct KeyCombinationViewData {
    let keys: [KeyViewData]
}

enum KeyViewData {
    case single(symbol: String)
    case splitCenter(symbolTop: String, symbolBottom: String)
    case splitSide(symbolTop: String, symbolBottom: String)

    static func keys(for modifierFlags: NSEvent.ModifierFlags) -> [KeyViewData] {
        var keys: [KeyViewData] = []
        if modifierFlags.contains(.control) {
            keys.append(.splitSide(symbolTop: "⌃", symbolBottom: "control"))
        }
        if modifierFlags.contains(.option) {
            keys.append(.splitSide(symbolTop: "⌥", symbolBottom: "option"))
        }
        if modifierFlags.contains(.command) {
            keys.append(.splitSide(symbolTop: "⌘", symbolBottom: "command"))
        }
        if modifierFlags.contains(.shift) {
            keys.append(.splitSide(symbolTop: "⇧", symbolBottom: "shift"))
        }
        return keys
    }

    init(key: Key) {
        switch key {
        case .a, .b, .c, .d, .e, .f, .g, .h, .i, .j, .k, .l, .m, .n, .o, .p, .q, .r, .s, .t, .u, .v, .w, .x, .y, .z:
            self = .single(symbol: key.rawValue.uppercased())
        case .one:
            self = .splitCenter(symbolTop: "!", symbolBottom: "1")
        case .two:
            self = .splitCenter(symbolTop: "@", symbolBottom: "2")
        case .three:
            self = .splitCenter(symbolTop: "#", symbolBottom: "3")
        case .four:
            self = .splitCenter(symbolTop: "$", symbolBottom: "4")
        case .five:
            self = .splitCenter(symbolTop: "%", symbolBottom: "5")
        case .six:
            self = .splitCenter(symbolTop: "^", symbolBottom: "6")
        case .seven:
            self = .splitCenter(symbolTop: "&", symbolBottom: "7")
        case .eight:
            self = .splitCenter(symbolTop: "*", symbolBottom: "8")
        case .nine:
            self = .splitCenter(symbolTop: "(", symbolBottom: "9")
        case .zero:
            self = .splitCenter(symbolTop: ")", symbolBottom: "0")
        case .minus:
            self = .splitCenter(symbolTop: "_", symbolBottom: "-")
        case .equal:
            self = .splitCenter(symbolTop: "+", symbolBottom: "=")
        case .rightBracket:
            self = .splitCenter(symbolTop: "}", symbolBottom: "]")
        case .leftBracket:
            self = .splitCenter(symbolTop: "{", symbolBottom: "{")
        case .quote:
            self = .splitCenter(symbolTop: "\"", symbolBottom: "'")
        case .semicolon:
            self = .splitCenter(symbolTop: ":", symbolBottom: ";")
        case .backslash:
            self = .splitCenter(symbolTop: "\\", symbolBottom: "|")
        case .comma:
            self = .splitCenter(symbolTop: "<", symbolBottom: ",")
        case .slash:
            self = .splitCenter(symbolTop: "?", symbolBottom: "/")
        case .period:
            self = .splitCenter(symbolTop: ">", symbolBottom: ".")
        case .grave:
            self = .splitCenter(symbolTop: "~", symbolBottom: "`")
        case .keypadDecimal:
            self = .single(symbol: ".")
        case .keypadMultiply:
            self = .single(symbol: "*")
        case .keypadPlus:
            self = .single(symbol: "+")
        case .keypadClear:
            self = .single(symbol: "clear")
        case .keypadDivide:
            self = .single(symbol: "/")
        case .keypadEnter:
            self = .splitCenter(symbolTop: "", symbolBottom: "enter")
        case .keypadMinus:
            self = .single(symbol: "-")
        case .keypadEquals:
            self = .single(symbol: "=")
        case .keypadZero:
            self = .single(symbol: "0")
        case .keypadOne:
            self = .single(symbol: "1")
        case .keypadTwo:
            self = .single(symbol: "2")
        case .keypadThree:
            self = .single(symbol: "3")
        case .keypadFour:
            self = .single(symbol: "4")
        case .keypadFive:
            self = .single(symbol: "5")
        case .keypadSix:
            self = .single(symbol: "6")
        case .keypadSeven:
            self = .single(symbol: "7")
        case .keypadEight:
            self = .single(symbol: "8")
        case .keypadNine:
            self = .single(symbol: "9")
        case .return:
            self = .splitSide(symbolTop: "⏎", symbolBottom: "return")
        case .tab:
            self = .splitSide(symbolTop: "⇥", symbolBottom: "tab")
        case .space:
            self = .single(symbol: "␣")
        case .delete:
            self = .splitSide(symbolTop: "⌫", symbolBottom: "delete")
        case .escape:
            self = .splitSide(symbolTop: "", symbolBottom: "esc")
        case .f1, .f2, .f3, .f4, .f5, .f6, .f7, .f8, .f9, .f10, .f11, .f12, .f13, .f14, .f15, .f16, .f17, .f18, .f19, .f20:
            self = .splitCenter(symbolTop: "", symbolBottom: key.rawValue.uppercased())
        case .help:
            self = .single(symbol: "help")
        case .home:
            self = .single(symbol: "home")
        case .pageUp:
            self = .single(symbol: "page\nup")
        case .forwardDelete:
            self = .single(symbol: "⌦\ndelete")
        case .end:
            self = .single(symbol: "end")
        case .pageDown:
            self = .single(symbol: "page\ndown")
        case .leftArrow:
            self = .single(symbol: "◀︎")
        case .rightArrow:
            self = .single(symbol: "▶︎")
        case .downArrow:
            self = .single(symbol: "▼")
        case .upArrow:
            self = .single(symbol: "▲")
        case .underscore:
            self = .splitCenter(symbolTop: "_", symbolBottom: "-")
        case .keypadComma:
            self = .single(symbol: ",")
        case .eisu, .yen, .kana, .atSign, .caret, .colon, .section:
            self = .splitSide(symbolTop: "?", symbolBottom: "unknown")
        }
    }
}
