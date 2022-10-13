import UIKit

class ProfileHeaderView: UIView {

    // MARK: -- Margins & Sizes

    private let imageViewSize = 100
    private let imageViewTopMargin = 16
    private let leftMargin = 16
    private let buttonOfImageMargin = 16
    private let buttonHeight = 50
    private let topTitleMargin = 27
    private let bottomButtonMargin = 34

    // MARK: -- Subviews

    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named:"profileImage") ?? UIImage())

        imageView.frame = CGRect(x: leftMargin, y: imageViewTopMargin, width: imageViewSize, height: imageViewSize)

        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = CGFloat(imageViewSize / 2)
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 3

        imageView.clipsToBounds = true

        return imageView
    }()

    private lazy var profileShowStatusButton: UIButton = {
        let button = UIButton()

        button.backgroundColor = .blue
        button.layer.cornerRadius = 4

        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.7

        button.setTitleColor(.white, for: .normal)

        button.setTitle("Show status", for: .normal)

        return button
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Hipster Cat"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Waiting for something..."
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.textAlignment = .left
        return label
    }()

    // MARK: -- inits

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: -- Methods

    private func setupView() {
        addSubview(profileImageView)
        addSubview(profileShowStatusButton)
        addSubview(titleLabel)
        addSubview(statusLabel)

        addShowStatusButtonAction()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let viewWidth = Int(frame.width)

        // MARK: -- Show Status Button

        let topMarginStatusButton = imageViewTopMargin + imageViewSize + buttonOfImageMargin
        profileShowStatusButton.frame = CGRect(x: leftMargin,
                                               y: topMarginStatusButton,
                                               width: viewWidth - leftMargin * 2,
                                               height: buttonHeight
        )

        // MARK: -- Title Label

        let titleLabelHeight = 22
        titleLabel.frame = CGRect(x: leftMargin * 2 + imageViewSize,
                                  y: topTitleMargin,
                                  width: viewWidth - (leftMargin * 3 + imageViewSize),
                                  height: titleLabelHeight
        )

        // MARK: -- Status Label

        let statusLabelHeight = 18
        statusLabel.frame = CGRect(x: leftMargin * 2 + imageViewSize,
                                   y: topMarginStatusButton - bottomButtonMargin - statusLabelHeight,
                                   width: viewWidth - (leftMargin * 3 + imageViewSize),
                                   height: statusLabelHeight
        )
    }

    private func addShowStatusButtonAction() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(printProfileStatus))
        profileShowStatusButton.isUserInteractionEnabled = true
        profileShowStatusButton.addGestureRecognizer(gesture)
    }

    // MARK: -- Recognizer Methods

    @objc
    private func printProfileStatus() {
        print("Profile status: \(statusLabel.text!)")
    }
}
