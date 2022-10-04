import UIKit

class PostViewController: UIViewController {

    var postData: Post!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    // MARK: -- Methods

    private func setupView() {
        title = postData.title
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

    func setupPostData(data: Post) {
        self.postData = data
    }
}
