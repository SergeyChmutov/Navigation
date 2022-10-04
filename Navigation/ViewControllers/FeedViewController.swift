import UIKit

class FeedViewController: UIViewController {

    // MARK: -- Properties

    let firstPost = Post(title: "First post")

    private lazy var postViewButton: UIButton = {
        let button = UIButton()
        button.setTitle("View first post", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(showPostViewController), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: -- Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    // MARK: -- Methods

    private func setupView() {
        title = "News feed"
        view.backgroundColor = .white
        
        setupConstraints()
    }

    private func setupConstraints() {
        view.addSubview(postViewButton)

        NSLayoutConstraint.activate([
            postViewButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            postViewButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc
    private func showPostViewController() {
        let postViewController = PostViewController()
        postViewController.setupPostData(data: firstPost)
        navigationController?.pushViewController(postViewController, animated: true)
    }
}
