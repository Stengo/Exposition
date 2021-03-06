import AppKit

final class OverlayViewController: SubscriberViewController<OverlayViewData> {
    private lazy var keyCombinationView: KeyCombinationView = {
        let view = KeyCombinationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        view = NSView()
    }

    override func viewDidLoad() {
        setupView()
        setupConstraints()
    }

    func setupView() {
        view.addSubview(keyCombinationView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            keyCombinationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            keyCombinationView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
        ])
    }

    override func update(with _: OverlayViewData) {}

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
