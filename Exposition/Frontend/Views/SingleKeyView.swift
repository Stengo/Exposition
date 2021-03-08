import AppKit

final class SingleKeyView: NSView {
    private lazy var textView: NSTextField = {
        let textView = NSTextField()
        textView.textColor = .white
        textView.backgroundColor = .black
        textView.alignment = .center
        textView.isBordered = false
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

        addSubview(textView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor),
            textView.centerYAnchor.constraint(equalTo: centerYAnchor),

            heightAnchor.constraint(equalTo: widthAnchor),
        ])
    }

    override func layout() {
        super.layout()

        textView.font = .systemFont(ofSize: bounds.height / 3.5)
        layer?.cornerRadius = bounds.height / 10
    }

    func render(symbol: String) {
        textView.stringValue = symbol
    }
}
