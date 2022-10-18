import UIKit

enum Constants {

    // MARK: - Texts

    enum Colors {
        static var loginColor: UIColor? {
            UIColor(named: "LogInColor")
        }
    }

    // MARK: - Logos

    enum Logos {
        static let VK = UIImage(named: "VKLogo")
    }

    // MARK: - Images

    enum Pixels {
        static let bluePixel = UIImage(named: "BluePixel")
    }

    // MARK: -- Login View Margins

    enum LoginViewMargins {
        static let topLogo: CGFloat = 120
        static let logoWidth: CGFloat = 100
        static let logoHeight: CGFloat = 100
        
        static let topStackView: CGFloat = 120

        static let leadingMargin: CGFloat = 16
        static let trailingMargin: CGFloat = 16

        static let buttonHeight: CGFloat = 50
        static let buttonTopMargin: CGFloat = 16
        static let buttonBottomMargin: CGFloat = 16

        static let loginTextFieldsHeight: CGFloat = 100
    }
}
