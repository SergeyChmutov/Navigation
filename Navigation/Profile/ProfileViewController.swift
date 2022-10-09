import UIKit

class ProfileViewController: UIViewController {

    // MARK: -- Properties

    private var profileHeaderView = ProfileHeaderView()

    // MARK: -- View Methods

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        profileHeaderView.frame = view.safeAreaLayoutGuide.layoutFrame
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    // MARK: -- Methods

    private func setupView() {
        title = "Profile"
        view.backgroundColor = .lightGray

        view.addSubview(profileHeaderView)
    }
}
