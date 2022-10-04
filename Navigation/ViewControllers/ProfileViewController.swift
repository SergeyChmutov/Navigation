import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    // MARK: -- Methods
    
    private func setupView() {
        title = "Profile"
        view.backgroundColor = .white
    }
}
