import AppKit

final class KeyView: NSView {
    private lazy var textView: NSTextField = {
        let textView = NSTextField()
        textView.textColor = .white
        textView.backgroundColor = .black
        textView.alignment = .center
        textView.isBordered = false
        textView.font = .systemFont(ofSize: 20)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    init() {
        super.init(frame: .zero)
        setupView()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        wantsLayer = true
        layer?.backgroundColor = NSColor.black.cgColor
        layer?.cornerRadius = 8

        addSubview(textView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 80),
            widthAnchor.constraint(equalToConstant: 80),
            textView.leadingAnchor.constraint(equalTo: leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor),
            textView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

    func render(_ viewData: KeyViewData) {
        switch viewData {
        case let .single(symbol):
            textView.stringValue = symbol
        case let .splitCenter(symbolTop, symbolBottom):
            textView.stringValue = symbolTop + symbolBottom
        case let .splitLeft(symbolTop, symbolBottom, _):
            textView.stringValue = symbolTop + symbolBottom
        case let .splitRight(symbolTop, symbolBottom, _):
            textView.stringValue = symbolTop + symbolBottom
        }
    }
}
