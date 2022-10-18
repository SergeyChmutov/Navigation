import UIKit

class MainTabBarController: UITabBarController {

    // MARK: -- Properties

    var feedTabNavigationController: UINavigationController!
    var loginTabNavigationController: UINavigationController!

    // MARK: -- Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }

    // MARK: -- Methods

    private func setupView() {
        feedTabNavigationController = UINavigationController(rootViewController: FeedViewController())
        loginTabNavigationController = UINavigationController(rootViewController: LogInViewController())

        viewControllers = [feedTabNavigationController, loginTabNavigationController]

        let feedTabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "doc"), tag: 0)
        let loginTabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 1)

        feedTabNavigationController.tabBarItem = feedTabBarItem
        loginTabNavigationController.tabBarItem = loginTabBarItem
    }
}
