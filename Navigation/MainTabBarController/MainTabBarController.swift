import UIKit

class MainTabBarController: UITabBarController {

    // MARK: -- Properties

    var feedTabNavigationController: UINavigationController!
    var profileTabNavigationController: UINavigationController!

    // MARK: -- Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }

    // MARK: -- Methods

    private func setupView() {
        feedTabNavigationController = UINavigationController(rootViewController: FeedViewController())
        profileTabNavigationController = UINavigationController(rootViewController: ProfileViewController())

        viewControllers = [feedTabNavigationController, profileTabNavigationController]

        let feedTabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "doc"), tag: 0)
        let profileTabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 1)

        feedTabNavigationController.tabBarItem = feedTabBarItem
        profileTabNavigationController.tabBarItem = profileTabBarItem
    }
}
