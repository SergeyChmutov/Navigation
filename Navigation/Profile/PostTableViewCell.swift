import UIKit

class PostTableViewCell: UITableViewCell {

    // MARK: -- Properties

    let contentMargin: CGFloat = 16

    private lazy var postTitleLabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false

        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 2

        return label
    }()

    private lazy var postImageView: UIImageView = {
        let imageView = UIImageView()

        imageView.translatesAutoresizingMaskIntoConstraints = false

        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black

        return imageView
    }()

    private lazy var postDescriptionLabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false

        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        label.numberOfLines = 0

        return label
    }()

    private lazy var postLikesLabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false

        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black

        return label
    }()

    private lazy var postViewsLabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false

        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black

        return label
    }()

    // MARK: -- CellView Method

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupCellView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        postTitleLabel.text = nil
        postImageView.image = nil
        postDescriptionLabel.text = nil
        postLikesLabel.text = nil
        postViewsLabel.text = nil
    }

    // MARK: -- Private Methods

    private func setupCellView() {

        contentView.addSubview(postTitleLabel)
        contentView.addSubview(postImageView)
        contentView.addSubview(postDescriptionLabel)
        contentView.addSubview(postLikesLabel)
        contentView.addSubview(postViewsLabel)

        NSLayoutConstraint.activate([

            postTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: contentMargin),
            postTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: contentMargin),
            postTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -contentMargin),

            postImageView.topAnchor.constraint(equalTo: postTitleLabel.bottomAnchor, constant: contentMargin),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1.0),
            postImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1.0),

            postDescriptionLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: contentMargin),
            postDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: contentMargin),
            postDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -contentMargin),

            postLikesLabel.topAnchor.constraint(equalTo: postDescriptionLabel.bottomAnchor, constant: contentMargin),
            postLikesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: contentMargin),
            postLikesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postLikesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -contentMargin),

            postViewsLabel.topAnchor.constraint(equalTo: postDescriptionLabel.bottomAnchor, constant: contentMargin),
            postViewsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postViewsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -contentMargin),
            postViewsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -contentMargin),

        ])
    }

    func setPostData(post: Post) {
        postTitleLabel.text = post.title
        let image = UIImage(named: post.image)
        postImageView.image = image
        postDescriptionLabel.text = post.description
        postLikesLabel.text = "Likes: \(post.likes)"
        postViewsLabel.text = "Views: \(post.views)"
    }
}
