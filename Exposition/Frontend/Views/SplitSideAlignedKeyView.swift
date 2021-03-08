import AppKit

final class SplitSideAlignedKeyView: NSView {
    private lazy var topTextView: NSTextField = {
        let textView = NSTextField()
        textView.alignment = .left
        textView.isBordered = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    private lazy var bottomTextView: NSTextField = {
        let textView = NSTextField()
        textView.alignment = .left
        textView.isBordered = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    private lazy var layoutGuide: NSLayoutGuide = {
        let layoutGuide = NSLayoutGuide()
        return layoutGuide
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

        addLayoutGuide(layoutGuide)
        addSubview(topTextView)
        addSubview(bottomTextView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            layoutGuide.centerYAnchor.constraint(equalTo: centerYAnchor),
            layoutGuide.centerXAnchor.constraint(equalTo: centerXAnchor),
            layoutGuide.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            layoutGuide.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.75),

            topTextView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
            topTextView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
            topTextView.centerYAnchor.constraint(equalTo: layoutGuide.topAnchor),

            bottomTextView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
            bottomTextView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
            bottomTextView.centerYAnchor.constraint(equalTo: layoutGuide.bottomAnchor),

            widthAnchor.constraint(equalTo: heightAnchor, multiplier: 1.5),
        ])
    }

    override func layout() {
        super.layout()

        topTextView.font = .systemFont(ofSize: bounds.height / 3.5)
        bottomTextView.font = .systemFont(ofSize: bounds.height / 4.5)
        layer?.cornerRadius = bounds.height / 10

        layer?.backgroundColor = NSColor.textBackgroundColor.cgColor
        topTextView.backgroundColor = NSColor.textBackgroundColor
        topTextView.textColor = NSColor.textColor
        bottomTextView.backgroundColor = NSColor.textBackgroundColor
        bottomTextView.textColor = NSColor.textColor
    }

    func render(symbolTop: String, symbolBottom: String) {
        topTextView.stringValue = symbolTop
        bottomTextView.stringValue = symbolBottom
    }
}
