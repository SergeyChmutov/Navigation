import UIKit

class ProfileHeaderView: UITableViewHeaderFooterView {

    // MARK: -- Margins & Sizes

    private let imageViewSize:CGFloat = 100
    private let imageViewTopMargin: CGFloat = 16
    private let leadingMargin: CGFloat = 16
    private let trailingMargin: CGFloat = 16
    private let buttonSetStatusHeight: CGFloat = 50
    private let topFullNameMargin: CGFloat = 27
    private let bottomSetStatusButtonMargin: CGFloat = 56
    private let textFieldHeight:CGFloat = 40
    private let betweenMargin: CGFloat = 16

    // MARK: -- Status Text

    private let noStatusText = "Waiting for something..."
    private var statusText: String

    // MARK: -- Subviews

    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named:"profileImage") ?? UIImage())

        imageView.translatesAutoresizingMaskIntoConstraints = false

        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = CGFloat(imageViewSize / 2)
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 3

        imageView.clipsToBounds = true

        return imageView
    }()

    private lazy var setStatusButton: UIButton = {
        let button = UIButton()

        button.translatesAutoresizingMaskIntoConstraints = false

        button.backgroundColor = .blue
        button.layer.cornerRadius = 4

        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.7

        button.setTitleColor(.white, for: .normal)
        button.setTitle("Set status", for: .normal)

        return button
    }()

    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false

        label.text = "Hipster Cat"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left

        return label
    }()

    private lazy var statusLabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false

        label.text = statusText
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.textAlignment = .left

        return label
    }()

    private lazy var statusTextField: UITextField = {
        let textField = UITextField()

        textField.translatesAutoresizingMaskIntoConstraints = false

        textField.backgroundColor = .white
        textField.textAlignment = .left
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.textColor = .black

        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 12

        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: textField.frame.size.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.rightView = paddingView
        textField.rightViewMode = .always

        return textField
    }()

    // MARK: -- inits

    override init(reuseIdentifier: String?) {
        statusText = noStatusText
        super.init(reuseIdentifier: reuseIdentifier)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: -- Methods

    private func setupView() {
        addSubview(avatarImageView)
        addSubview(fullNameLabel)
        addSubview(setStatusButton)
        addSubview(statusLabel)
        addSubview(statusTextField)

        addSetStatusButtonAction()
        addStatusTextFieldAction()

        setupViewConstraints()
    }

    private func setupViewConstraints() {

        NSLayoutConstraint.activate([

            avatarImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: imageViewTopMargin),
            avatarImageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: leadingMargin),
            avatarImageView.widthAnchor.constraint(equalToConstant: imageViewSize),
            avatarImageView.heightAnchor.constraint(equalToConstant: imageViewSize),

            fullNameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: topFullNameMargin),
            fullNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: leadingMargin),
            fullNameLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -trailingMargin),

            setStatusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: bottomSetStatusButtonMargin - betweenMargin),
            setStatusButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: leadingMargin),
            setStatusButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -trailingMargin),
            setStatusButton.heightAnchor.constraint(equalToConstant: buttonSetStatusHeight),
            setStatusButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),

            statusTextField.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: betweenMargin),
            statusTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -trailingMargin),
            statusTextField.bottomAnchor.constraint(equalTo: setStatusButton.topAnchor, constant: -betweenMargin / 2),
            statusTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),

            statusLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: betweenMargin),
            statusLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -trailingMargin),
            statusLabel.bottomAnchor.constraint(equalTo: setStatusButton.topAnchor, constant: -bottomSetStatusButtonMargin),

        ])
    }

    private func addSetStatusButtonAction() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(setStatusLabelText))
        setStatusButton.isUserInteractionEnabled = true
        setStatusButton.addGestureRecognizer(gesture)
    }

    private func addStatusTextFieldAction() {
        statusTextField.addTarget(self, action: #selector(statusTextFieldDidChange(textField:)), for: .editingChanged)
    }

    // MARK: -- Events Handling Methods

    @objc
    private func setStatusLabelText() {
        statusLabel.text = statusText.isEmpty ? noStatusText : statusText
        statusTextField.endEditing(true)
    }

    @objc
    private func statusTextFieldDidChange(textField: UITextField) {
        let str = textField.text!
        statusText = str.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
