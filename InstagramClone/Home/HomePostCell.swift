//
//  InstagramCloneCell.swift
//  InstagramClone
//
//  Created by Wataru Uehara on 2026/04/18.
//

import UIKit

class HomePostCell: UICollectionViewCell {
    
    private let avatarView = UIImageView()
    private let usernameLabel = UILabel()
    private let postImageView = UIImageView()
    private let likeCountLabel = UILabel()
    private let captionLabel = UILabel()
    private let likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .label
        return button
    }()
    private let bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .label
        return button
    }()
    private let expandButton = UIButton(type: .system)
    
    var likeCount: Int = 0 {
        didSet {
            likeCountLabel.text = "いいね\(likeCount)件"
        }
    }
        
    var username: String = "" {
        didSet {
            usernameLabel.text = username
        }
    }
        
    
    var caption: String = "" {
            didSet {
                captionLabel.text = "\(username)\(caption)"
                captionLabel.numberOfLines = 2
                expandButton.isHidden = false
            }
        }
        
    var isLiked: Bool = false {
        didSet {
            let heartImage = isLiked
                ? UIImage(systemName: "heart.fill")
                : UIImage(systemName: "heart")
            likeButton.setImage(heartImage, for: .normal)
            likeButton.tintColor = isLiked ? .systemRed : .label
        }
    }
    
    var avatarUrl: String = "" {
        didSet {
            avatarLoadTask = Task {
                let image = try? await ImageLoader.shared.loadImage(urlString: avatarUrl)
                await MainActor.run {
                    avatarView.image = image
                }
            }
        }
    }
    
    var imageUrl: String = "" {
        didSet {
            imageLoadTask = Task {
                let image = try? await ImageLoader.shared.loadImage(urlString: imageUrl)
                await MainActor.run {
                    postImageView.image = image
                }
            }
        }
    }
    
    var isBookmarked: Bool = false {
        didSet {
            let bookedImage = isBookmarked
            ? UIImage(systemName: "bookmark.fill")
            : UIImage(systemName: "bookmark")
            bookmarkButton.setImage(bookedImage, for: .normal)
            bookmarkButton.tintColor = isBookmarked ? .systemBlue : .label
        }
    }
    
    var onLikeTapped: (() -> Void)?
    var onBookmarkTapped: (() -> Void)?
    var avatarLoadTask: Task<Void, Never>?
    var imageLoadTask: Task<Void, Never>?
    var onExpandTapped: (() -> Void)?
    
    @objc private func likeTapped() {
        onLikeTapped?()
    }
    
    @objc private func bookmarkTapped() {
        onBookmarkTapped?()
    }
    
    @objc private func expandTapped() {
        captionLabel.numberOfLines = 0
        expandButton.isHidden = true
        onExpandTapped?()
    }
    
    static let reuseIdentifier = "InstagramCloneCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUIStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarLoadTask?.cancel()
        avatarLoadTask = nil
        avatarView.image = nil
        imageLoadTask?.cancel()
        imageLoadTask = nil
        postImageView.image = nil
    }
    
    private func setupUIStackView() {
        
        let spacer = UIView()
        
        let headerStack = UIStackView(arrangedSubviews: [avatarView, usernameLabel])
        headerStack.axis = .horizontal
        headerStack.spacing = 8
        headerStack.alignment = .center
        headerStack.isLayoutMarginsRelativeArrangement = true
        headerStack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12)
        headerStack.translatesAutoresizingMaskIntoConstraints = false
        
        let likeCountRow = UIStackView(arrangedSubviews: [likeCountLabel, spacer, bookmarkButton])
        likeCountRow.axis = .horizontal
        likeCountRow.spacing = 4
        likeCountRow.alignment = .center
        likeCountRow.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 12)
        likeCountRow.translatesAutoresizingMaskIntoConstraints = false
        
        let bottomStack = UIStackView(arrangedSubviews: [likeButton, likeCountRow, captionLabel, expandButton])
        bottomStack.axis = .vertical
        bottomStack.spacing = 4
        bottomStack.alignment = .leading
        bottomStack.isLayoutMarginsRelativeArrangement = true
        bottomStack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12)
        bottomStack.translatesAutoresizingMaskIntoConstraints = false
        
        let mainStack = UIStackView(arrangedSubviews: [headerStack, postImageView, bottomStack])
        mainStack.axis = .vertical
        mainStack.spacing = 8
        mainStack.alignment = .fill
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(mainStack)
        
        avatarView.layer.cornerRadius = 32 / 2
        avatarView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            avatarView.widthAnchor.constraint(equalToConstant: 32),
            avatarView.heightAnchor.constraint(equalToConstant: 32),
            
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
                                    
            postImageView.heightAnchor.constraint(equalTo: postImageView.widthAnchor),
            
            likeCountRow.widthAnchor.constraint(equalTo: bottomStack.layoutMarginsGuide.widthAnchor),
            
        ])
        
        likeButton.addTarget(self, action: #selector(likeTapped), for: .touchUpInside)
        bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        bookmarkButton.addTarget(self, action: #selector(bookmarkTapped), for: .touchUpInside)
        
        captionLabel.numberOfLines = 2
        captionLabel.lineBreakMode = .byTruncatingTail
        expandButton.setTitle("もっと見る", for: .normal)
        expandButton.addTarget(self, action: #selector(expandTapped), for: .touchUpInside)
    }
}
