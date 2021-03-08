import AppKit

final class KeyCombinationView: NSView {
    private lazy var keysStackView: NSStackView = {
        let stackView = NSStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    var animationTimer: Timer?

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

        addSubview(keysStackView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            keysStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            keysStackView.topAnchor.constraint(equalTo: topAnchor),
            keysStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            keysStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    override func layout() {
        super.layout()

        layer?.cornerRadius = bounds.height / 8
        let inset = bounds.height / 10
        keysStackView.spacing = inset
        keysStackView.edgeInsets = NSEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)

        layer?.backgroundColor = NSColor.windowFrameColor.cgColor
    }

    func render(_ viewData: KeyCombinationViewData) {
        animationTimer?.invalidate()
        animationTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { [weak self] _ in
            NSAnimationContext.runAnimationGroup { context in
                context.duration = 0.5
                self?.animator().alphaValue = 0
            }
        })
        NSAnimationContext.runAnimationGroup { [weak self] context in
            context.duration = 0.5
            self?.animator().alphaValue = 1
        }
        keysStackView.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
        viewData.keys.forEach { keyViewData in
            switch keyViewData {
            case let .single(symbol):
                let view = SingleKeyView()
                view.render(symbol: symbol)
                keysStackView.addArrangedSubview(view)

            case let .splitCenter(symbolTop, symbolBottom):
                let view = SplitCenterKeyView()
                view.render(symbolTop: symbolTop, symbolBottom: symbolBottom)
                keysStackView.addArrangedSubview(view)

            case let .splitSide(symbolTop, symbolBottom):
                let view = SplitSideAlignedKeyView()
                view.render(symbolTop: symbolTop, symbolBottom: symbolBottom)
                keysStackView.addArrangedSubview(view)
            }
        }
    }
}
