import UIKit

class ProfileHeaderView: UIView {
    
    // MARK: -- Margins & Sizes
    
    private let imageViewSize = 100
    private let imageViewTopMargin = 16
    private let leadingMargin = 16
    private let trailingMargin = 16
    private let buttonSetStatusHeight = 50
    private let topFullNameMargin = 27
    private let bottomSetStatusButtonMargin = 56
    private let textFieldHeight = 40
    private let betweenMargin = 16
    
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
    
    override init(frame: CGRect) {
        statusText = noStatusText
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        statusText = noStatusText
        super.init(coder: coder)
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
            
            avatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: CGFloat(imageViewTopMargin)),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: CGFloat(leadingMargin)),
            avatarImageView.widthAnchor.constraint(equalToConstant: CGFloat(imageViewSize)),
            avatarImageView.heightAnchor.constraint(equalToConstant: CGFloat(imageViewSize)),
            
            fullNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: CGFloat(topFullNameMargin)),
            fullNameLabel.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor, constant: CGFloat(leadingMargin)),
            fullNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: CGFloat(-trailingMargin)),
            
            setStatusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: CGFloat(bottomSetStatusButtonMargin - betweenMargin)),
            setStatusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: CGFloat(leadingMargin)),
            setStatusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: CGFloat(-trailingMargin)),
            setStatusButton.heightAnchor.constraint(equalToConstant: CGFloat(buttonSetStatusHeight)),
            
            statusTextField.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: CGFloat(betweenMargin)),
            statusTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: CGFloat(-trailingMargin)),
            statusTextField.bottomAnchor.constraint(equalTo: setStatusButton.topAnchor, constant: CGFloat(-betweenMargin / 2)),
            statusTextField.heightAnchor.constraint(equalToConstant: CGFloat(textFieldHeight)),
            
            statusLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: CGFloat(betweenMargin)),
            statusLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: CGFloat(-trailingMargin)),
            statusLabel.bottomAnchor.constraint(equalTo: setStatusButton.topAnchor, constant: CGFloat(-bottomSetStatusButtonMargin)),
            
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
