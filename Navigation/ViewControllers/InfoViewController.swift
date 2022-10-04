import UIKit

class InfoViewController: UIViewController {

    // MARK: -- Properties

    private lazy var alertButton: UIButton = {
        let button = UIButton()
        button.setTitle("Alert!", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(showAlertController), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    // MARK: -- Methods

    private func setupView() {
        view.backgroundColor = .lightGray

        setupConstraints()
    }

    private func setupConstraints() {
        view.addSubview(alertButton)

        NSLayoutConstraint.activate([
            alertButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc
    private func showAlertController() {
        let alertController = UIAlertController(title: "Alert", message: "This is the first post view!", preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: "Good", style: .cancel, handler: { _ in
            print("😀 Good!")
        }))

        alertController.addAction(UIAlertAction(title: "Sadness", style: .default, handler: { _ in
            print("😥 Sadness...")
        }))

        present(alertController, animated: true)
    }
}
