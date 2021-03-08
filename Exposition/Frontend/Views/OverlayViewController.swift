import AppKit

final class OverlayViewController: SubscriberViewController<OverlayViewData> {
    private lazy var keyCombinationView: KeyCombinationView = {
        let view = KeyCombinationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var topConstraint: NSLayoutConstraint = {
        keyCombinationView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16 + 22)
    }()

    private lazy var bottomConstraint: NSLayoutConstraint = {
        keyCombinationView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
    }()

    private lazy var rightConstraint: NSLayoutConstraint = {
        keyCombinationView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
    }()

    private lazy var leftConstraint: NSLayoutConstraint = {
        keyCombinationView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16)
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
            keyCombinationView.heightAnchor.constraint(equalToConstant: 80),
        ])
    }

    override func update(with viewData: OverlayViewData) {
        switch viewData.position {
        case .topLeft:
            NSLayoutConstraint.deactivate([
                bottomConstraint,
                rightConstraint,
            ])
            NSLayoutConstraint.activate([
                topConstraint,
                leftConstraint,
            ])
        case .topRight:
            NSLayoutConstraint.deactivate([
                bottomConstraint,
                leftConstraint,
            ])
            NSLayoutConstraint.activate([
                topConstraint,
                rightConstraint,
            ])
        case .bottomLeft:
            NSLayoutConstraint.deactivate([
                topConstraint,
                rightConstraint,
            ])
            NSLayoutConstraint.activate([
                bottomConstraint,
                leftConstraint,
            ])
        case .bottomRight:
            NSLayoutConstraint.deactivate([
                topConstraint,
                leftConstraint,
            ])
            NSLayoutConstraint.activate([
                bottomConstraint,
                rightConstraint,
            ])
        }
        keyCombinationView.render(viewData.keyCombination)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
