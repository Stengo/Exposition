import AppKit

final class OverlayViewController: NSViewController {
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

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
