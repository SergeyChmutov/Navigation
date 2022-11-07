import UIKit

class PostViewController: UIViewController {

    var postTitle: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    // MARK: -- Methods

    private func setupView() {
        title = postTitle
        view.backgroundColor = .white

        setupBarButtonItem()
    }

    private func setupBarButtonItem() {
        let infoViewBarItem = UIBarButtonItem(image: UIImage(systemName: "questionmark.app"),
                                              style: .plain,
                                              target: self,
                                              action: #selector(showInfoViewController)
        )
        self.navigationItem.rightBarButtonItem = infoViewBarItem
    }

    @objc
    private func showInfoViewController() {
        let infoViewController = InfoViewController()
        infoViewController.modalPresentationStyle = .pageSheet
        infoViewController.modalTransitionStyle = .coverVertical
        present(infoViewController, animated: true, completion: nil)
    }

    func setupPostData(title: String) {
        self.postTitle = title
    }
}
