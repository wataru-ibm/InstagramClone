//
//  InstagramCloneCell.swift
//  InstagramClone
//
//  Created by Wataru Uehara on 2026/04/18.
//

import UIKit

class InstagramCloneCell: UICollectionViewCell {
    
    private let avatarView = UIView()
    private let usernameLabel = UILabel()
    private let postImageView = UIImageView()
    private let likeCountLabel = UILabel()
    private let captionLabel = UILabel()
    private let likeButton: UIButton = {
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
                captionLabel.text = "\(username) \(caption)"
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
    
    var avatarColor: UIColor = .clear {
        didSet {
            avatarView.backgroundColor = avatarColor
        }
    }
    
    var imageColor: UIColor = .clear {
        didSet {
            postImageView.backgroundColor = imageColor
        }
    }
    
    var onLikeTapped: (() -> Void)?
    
    @objc private func likeTapped() {
        onLikeTapped?()
    }
    
    @objc private func expandTapped() {
        captionLabel.numberOfLines = 0
        expandButton.isHidden = true
    }
    
    static let reuseIdentifier = "InstagramCloneCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUIStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUIStackView() {
        
        let headerStack = UIStackView(arrangedSubviews: [avatarView, usernameLabel])
        headerStack.axis = .horizontal
        headerStack.spacing = 8
        headerStack.alignment = .center
        headerStack.isLayoutMarginsRelativeArrangement = true
        headerStack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12)
        headerStack.translatesAutoresizingMaskIntoConstraints = false
        
        let bottomStack = UIStackView(arrangedSubviews: [likeButton, likeCountLabel, captionLabel, expandButton])
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
            
        ])
        
        likeButton.addTarget(self, action: #selector(likeTapped), for: .touchUpInside)
        
        captionLabel.numberOfLines = 2
        captionLabel.lineBreakMode = .byTruncatingTail
        expandButton.setTitle("もっと見る", for: .normal)
        expandButton.addTarget(self, action: #selector(expandTapped), for: .touchUpInside)
    }
}
