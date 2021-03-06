import AppKit

final class KeyCombinationView: NSView {
    private lazy var keysStackView: NSStackView = {
        let stackView = NSStackView(views: [
            KeyView(),
            KeyView(),
            KeyView(),
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    init() {
        super.init(frame: .zero)
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
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
}
