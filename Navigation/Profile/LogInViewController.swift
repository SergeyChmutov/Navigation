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
                                               selector: #selector(didShowKeyboard(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil
        )

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didHideKeyboard(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil
        )
    }

    // MARK: -- Private Methods

    private func setupConstraints() {

        let stackViewHeight = Constants.LoginViewMargins.loginTextFieldsHeight +
        Constants.LoginViewMargins.buttonHeight +
        Constants.LoginViewMargins.buttonTopMargin

        NSLayoutConstraint.activate([

            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: Constants.LoginViewMargins.topStackView),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.LoginViewMargins.leadingMargin),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.LoginViewMargins.trailingMargin),
            stackView.heightAnchor.constraint(equalToConstant: stackViewHeight),

            logoImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: Constants.LoginViewMargins.topLogo),
            logoImageView.widthAnchor.constraint(equalToConstant: Constants.LoginViewMargins.logoWidth),
            logoImageView.heightAnchor.constraint(equalToConstant: Constants.LoginViewMargins.logoHeight),

        ])
    }

    private func setupView() {
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(true, animated: true)

        setupGestures()

        view.addSubview(scrollView)

        scrollView.addSubview(logoImageView)

        stackView.addArrangedSubview(loginAccountTextField)
        stackView.addArrangedSubview(loginPasswordTextField)
        stackView.addArrangedSubview(loginButton)

        stackView.setCustomSpacing(Constants.LoginViewMargins.buttonTopMargin, after: loginPasswordTextField)

        scrollView.addSubview(stackView)

        setupConstraints()
    }

    private func setupGestures() {
        let tapViewGesture = UITapGestureRecognizer(target: self, action: #selector(forcedHidingKeyboard))
        view.addGestureRecognizer(tapViewGesture)
    }

    // MARK: -- Events Handler Methods

    @objc
    private func didShowKeyboard(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {

            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height

            let loginButtonBottomPointY = stackView.frame.origin.y + stackView.frame.height

            // Учесть разницу view и safe area
            let keyboardOriginY = view.frame.height - view.safeAreaLayoutGuide.layoutFrame.origin.y - keyboardHeight

            let offsetY = keyboardOriginY < loginButtonBottomPointY ? loginButtonBottomPointY - keyboardOriginY + Constants.LoginViewMargins.buttonBottomMargin : 0

            scrollView.contentOffset = CGPoint(x: 0, y: offsetY)
        }
    }

    @objc
    private func didHideKeyboard(_ notification: Notification) {
        forcedHidingKeyboard()
    }

    @objc
    private func forcedHidingKeyboard() {
        view.endEditing(true)
        scrollView.setContentOffset(.zero, animated: true)
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
            loginAccount = textField.text
        case 1:
            loginPassword = textField.text
        default:
            break
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        forcedHidingKeyboard()
        return true
    }
}
