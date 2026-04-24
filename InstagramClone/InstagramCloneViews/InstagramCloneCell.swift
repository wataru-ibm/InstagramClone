//
//  InstagramCloneCell.swift
//  InstagramClone
//
//  Created by Wataru Uehara on 2026/04/18.
//

import UIKit

class InstagramCloneCell: UICollectionViewCell {
    
    private let avatarImageView = UIImageView()
    private let usernameLabel = UILabel()
    private let postImageView = UIImageView()
    private let likeButton = UIButton()
    private let likeCountLabel = UILabel()
    private let captionLabel = UILabel()
    private var imageView: UIImageView?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView = UIImageView()
        contentView.addSubview(imageView!)
        contentView.addSubview(postImageView)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(likeButton)
        contentView.addSubview(likeCountLabel)
        contentView.addSubview(captionLabel)
        setupUsernameLabel()
        setupPostImageView()
        contentView.addSubview(avatarImageView)
        setupAvatarImageView()
        setupLikeButton()
        setupLikeCountLabel()
        setupCaptionLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let avatarImageTopPadding: CGFloat = 8
    let avatarImageHalfHeight: CGFloat = 40 / 2
    private var avatarImageCenterY: CGFloat {
        avatarImageTopPadding + avatarImageHalfHeight
    }
    let usernameLabelHeight: CGFloat = 20
    private var usernameLabelCenterY: CGFloat {
        avatarImageCenterY - usernameLabelHeight / 2
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let width = contentView.bounds.width
        imageView?.frame = CGRect(x: 0, y: 0, width: width, height: width)
        avatarImageView.frame = CGRect(x: 8, y: 8, width: 40, height: 40)
        usernameLabel.frame = CGRect(x: 56, y: usernameLabelCenterY, width: 300, height: 20)
        postImageView.frame = CGRect(x: 0, y: 56, width: width, height: width)
        likeButton.frame = CGRect(x: 8, y: 56 + width + 4, width: 40, height: 40)
        likeCountLabel.frame = CGRect(x: 8, y: 56 + width + 32, width: 200, height: 30)
        captionLabel.frame = CGRect(x: 8, y: 56 + width + 50, width: 400, height: 30)
    }
    
    
    func setupAvatarImageView() {
        avatarImageView.layer.cornerRadius = 40 / 2
        avatarImageView.clipsToBounds = true
        avatarImageView.backgroundColor = .gray
    }
    
    func setupUsernameLabel() {
        usernameLabel.text = "porsche_museum"
        usernameLabel.font = .systemFont(ofSize: 20, weight: .bold)
        usernameLabel.textColor = .blue
        usernameLabel.textAlignment = .left
        usernameLabel.clipsToBounds = true
    }
    
    func setupPostImageView() {
        postImageView.backgroundColor = .blue
        postImageView.contentMode = .scaleAspectFill
        postImageView.clipsToBounds = true
    }
    
    func setupLikeButton() {
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .light)
        likeButton.tintColor = .black
        likeButton.titleLabel?.font = .systemFont(ofSize: 50, weight: .bold)
        likeButton.setImage(UIImage(systemName: "heart", withConfiguration: config), for: .normal)
        likeButton.setImage(UIImage(systemName: "heart.fill", withConfiguration: config), for: .selected)
    }
    
    func setupLikeCountLabel() {
        likeCountLabel.textColor = .black
        likeCountLabel.font = .systemFont(ofSize: 15, weight: .bold)
        likeCountLabel.textAlignment = .left
        likeCountLabel.text = "いいね200件"
    }
    
    func setupCaptionLabel() {
        captionLabel.textColor = .black
        captionLabel.font = .systemFont(ofSize: 15, weight: .regular)
        captionLabel.textAlignment = .left
        captionLabel.text = (usernameLabel.text ?? "") + " Hello, どうも僕はここ"
    }
}
