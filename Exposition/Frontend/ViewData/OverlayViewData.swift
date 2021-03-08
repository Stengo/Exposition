import Cocoa
import Foundation
import Sauce

struct OverlayStateFragment: Equatable {
    let keyLoggerState: KeyLoggerState
}

struct OverlayViewData: ViewDataType {
    typealias StateFragment = OverlayStateFragment

    let keyCombination: KeyCombinationViewData

    static func fragment(of appState: AppState) -> StateFragment {
        return StateFragment(
            keyLoggerState: appState.keyLoggerState
        )
    }

    init(for fragment: StateFragment) {
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
    case splitRight(symbolTop: String, symbolBottom: String, aspectRatio: Double)
    case splitLeft(symbolTop: String, symbolBottom: String, aspectRatio: Double)

    static func keys(for modifierFlags: NSEvent.ModifierFlags) -> [KeyViewData] {
        var keys: [KeyViewData] = []
        if modifierFlags.contains(.control) {
            keys.append(.splitLeft(symbolTop: "⌃", symbolBottom: "control", aspectRatio: 1.6))
        }
        if modifierFlags.contains(.option) {
            keys.append(.splitRight(symbolTop: "⌥", symbolBottom: "option", aspectRatio: 1.3))
        }
        if modifierFlags.contains(.command) {
            keys.append(.splitRight(symbolTop: "⌘", symbolBottom: "command", aspectRatio: 1.6))
        }
        if modifierFlags.contains(.shift) {
            keys.append(.splitLeft(symbolTop: "", symbolBottom: "shift", aspectRatio: 2.5))
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
            self = .splitRight(symbolTop: "", symbolBottom: "return", aspectRatio: 1.9)
        case .tab:
            self = .splitLeft(symbolTop: "", symbolBottom: "tab", aspectRatio: 1.6)
        case .space:
            self = .splitCenter(symbolTop: "", symbolBottom: "␣")
        case .delete:
            self = .splitRight(symbolTop: "", symbolBottom: "delete", aspectRatio: 1.6)
        case .escape:
            self = .splitLeft(symbolTop: "", symbolBottom: "esc", aspectRatio: 1.6)
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
            self = .single(symbol: "◄")
        case .rightArrow:
            self = .single(symbol: "►")
        case .downArrow:
            self = .single(symbol: "▼")
        case .upArrow:
            self = .single(symbol: "▲")
        case .underscore:
            self = .splitCenter(symbolTop: "_", symbolBottom: "-")
        case .keypadComma:
            self = .single(symbol: ",")
        case .eisu, .yen, .kana, .atSign, .caret, .colon, .section:
            self = .splitCenter(symbolTop: "?", symbolBottom: "unknown")
        }
    }
}
