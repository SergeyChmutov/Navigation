import UIKit

class LogInViewController: UIViewController {

    // MARK: -- UI Properties

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView(image: Constants.Logos.VK)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var loginAccountTextField: UITextField = {
        let textField = UITextField()

        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]

        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.tintColor = Constants.Colors.loginColor
        textField.autocapitalizationType = .none
        textField.backgroundColor = .systemGray6

        textField.tag = 0
        textField.placeholder = "Email or phone"
        textField.keyboardType = .default
        textField.clearButtonMode = .whileEditing
        textField.delegate = self

        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: textField.layer.cornerRadius, height: textField.frame.size.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.rightView = paddingView
        textField.rightViewMode = .always

        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private lazy var loginPasswordTextField: UITextField = {
        let textField = UITextField()

        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]

        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.tintColor = Constants.Colors.loginColor
        textField.autocapitalizationType = .none
        textField.backgroundColor = .systemGray6
        textField.tag = 1
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.delegate = self

        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: textField.layer.cornerRadius, height: textField.frame.size.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.rightView = paddingView
        textField.rightViewMode = .always

        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(Constants.Pixels.bluePixel, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Log In", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(showProfileView), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: -- Properties

    private var loginAccount: String?
    private var loginPassword: String?

    // MARK: -- View Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.didShowKeyboard(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil
        )

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.didHideKeyboard(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil
        )
    }

    // MARK: -- Private Methods

    private func scrollViewConstraints() -> [NSLayoutConstraint] {
        let topAnchor = self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        let leadingAnchor = self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingAnchor = self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let bottomAnchor = self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)

        return [topAnchor, leadingAnchor, trailingAnchor, bottomAnchor]
    }

    private func stackViewConstraints() -> [NSLayoutConstraint] {
        let topAnchor = self.stackView.topAnchor.constraint(equalTo: self.logoImageView.bottomAnchor, constant: Constants.LoginViewMargins.topStackView)
        let leadingConstraint = self.stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Constants.LoginViewMargins.leadingMargin)
        let trailingConstraint = self.stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -Constants.LoginViewMargins.trailingMargin)

        let stackViewHeight = Constants.LoginViewMargins.loginTextFieldsHeight +
        Constants.LoginViewMargins.buttonHeight +
        Constants.LoginViewMargins.buttonTopMargin

        let heightConstraints = self.stackView.heightAnchor.constraint(equalToConstant: stackViewHeight)

        return [topAnchor, leadingConstraint, trailingConstraint, heightConstraints]
    }

    private func logoImageViewConstraints() -> [NSLayoutConstraint] {
        let centerXAnchor = self.logoImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        let topAnchor = self.logoImageView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: Constants.LoginViewMargins.topLogo)
        let widthConstraints = self.logoImageView.widthAnchor.constraint(equalToConstant: Constants.LoginViewMargins.logoWidth)
        let heightConstraints = self.logoImageView.heightAnchor.constraint(equalToConstant: Constants.LoginViewMargins.logoHeight)

        return [centerXAnchor, topAnchor, widthConstraints, heightConstraints]
    }

    private func setupView() {
        self.view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(true, animated: true)

        self.setupGestures()

        self.view.addSubview(self.scrollView)

        self.scrollView.addSubview(self.logoImageView)

        self.stackView.addArrangedSubview(self.loginAccountTextField)
        self.stackView.addArrangedSubview(self.loginPasswordTextField)
        self.stackView.addArrangedSubview(self.loginButton)

        self.stackView.setCustomSpacing(Constants.LoginViewMargins.buttonTopMargin, after: loginPasswordTextField)

        self.scrollView.addSubview(self.stackView)

        let scrollViewConstraints = self.scrollViewConstraints()
        let logoImageViewConstraints = self.logoImageViewConstraints()
        let stackViewConstraints = self.stackViewConstraints()

        NSLayoutConstraint.activate(
            scrollViewConstraints +
            logoImageViewConstraints +
            stackViewConstraints
        )
    }

    private func setupGestures() {
        let tapViewGesture = UITapGestureRecognizer(target: self, action: #selector(self.forcedHidingKeyboard))
        self.view.addGestureRecognizer(tapViewGesture)
    }

    // MARK: -- Events Handler Methods

    @objc
    private func didShowKeyboard(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {

            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height

            let loginButtonBottomPointY = self.stackView.frame.origin.y + self.stackView.frame.height

            // Учесть разницу view и safe area
            let keyboardOriginY = self.view.frame.height - self.view.safeAreaLayoutGuide.layoutFrame.origin.y - keyboardHeight

            let offsetY = keyboardOriginY < loginButtonBottomPointY ? loginButtonBottomPointY - keyboardOriginY + Constants.LoginViewMargins.buttonBottomMargin : 0

            self.scrollView.contentOffset = CGPoint(x: 0, y: offsetY)
        }
    }

    @objc
    private func didHideKeyboard(_ notification: Notification) {
        self.forcedHidingKeyboard()
    }

    @objc
    private func forcedHidingKeyboard() {
        self.view.endEditing(true)
        self.scrollView.setContentOffset(.zero, animated: true)
    }

    @objc
    private func showProfileView() {
        let profileViewController = ProfileViewController()
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.pushViewController(profileViewController, animated: true)
    }
}

// MARK: -- Extensions

extension LogInViewController: UITextFieldDelegate {

    func textFieldDidChangeSelection(_ textField: UITextField) {
        switch textField.tag {
        case 0:
            self.loginAccount = textField.text
        case 1:
            self.loginPassword = textField.text
        default:
            break
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.forcedHidingKeyboard()
        return true
    }
}
