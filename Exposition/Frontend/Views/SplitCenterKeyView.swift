import AppKit

final class SplitCenterKeyView: NSView {
    private lazy var topTextView: NSTextField = {
        let textView = NSTextField()
        textView.textColor = .white
        textView.backgroundColor = .black
        textView.alignment = .center
        textView.isBordered = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    private lazy var bottomTextView: NSTextField = {
        let textView = NSTextField()
        textView.textColor = .white
        textView.backgroundColor = .black
        textView.alignment = .center
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
            layoutGuide.leadingAnchor.constraint(equalTo: leadingAnchor),
            layoutGuide.trailingAnchor.constraint(equalTo: trailingAnchor),
            layoutGuide.centerYAnchor.constraint(equalTo: centerYAnchor),
            layoutGuide.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1 / 3),

            topTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topTextView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topTextView.centerYAnchor.constraint(equalTo: layoutGuide.topAnchor),

            bottomTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomTextView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomTextView.centerYAnchor.constraint(equalTo: layoutGuide.bottomAnchor),

            heightAnchor.constraint(equalTo: widthAnchor),
        ])
    }

    override func layout() {
        super.layout()

        topTextView.font = .systemFont(ofSize: bounds.height / 4.9)
        bottomTextView.font = .systemFont(ofSize: bounds.height / 3.6)
        layer?.cornerRadius = bounds.height / 10
    }

    func render(symbolTop: String, symbolBottom: String) {
        topTextView.stringValue = symbolTop
        bottomTextView.stringValue = symbolBottom
    }
}
