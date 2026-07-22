//
//  PostDetailViewController.swift
//  InstagramClone
//
//  Created by Wataru Uehara on 2026/06/01.
//

import UIKit

class PostDetailViewController: UIViewController, ZoomTransitionable {

    private let post: Post
    private let imageDetailView = UIImageView()
    private var imageLoadTask: Task<Void, Never>?
    var transitionImageView: UIImageView {
        imageDetailView
    }
    private let avatarView = UIImageView()
    private let usernameLabel = UILabel()
    private let likeButton = UIButton(type: .system)
    private let bookmarkButton = UIButton(type: .system)
    private let likeCountLabel = UILabel()
    private let captionLabel = UILabel()
    private let scrollView = UIScrollView()

    init(post: Post) {
        self.post = post
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIStackView()
        configure()
        imageLoadTask = Task {
            let image = try? await ImageLoader.shared.loadImage(urlString: post.imageUrl)
            await MainActor.run {
                imageDetailView.image = image
            }
        }
    }
    
    private func configure() {
        usernameLabel.text = post.username
        likeCountLabel.text = "いいね\(post.likeCount)件"
        captionLabel.text = "\(post.username)\(post.caption)"
        likeButton.setImage(
            UIImage(systemName: post.isLiked ? "heart.fill" : "heart"),
            for: .normal
        )
        likeButton.tintColor = post.isLiked ? .systemRed : .label
        
        bookmarkButton.setImage(
            UIImage(systemName: post.isBookmarked ? "bookmark.fill" : "bookmark"),
            for: .normal
        )
        bookmarkButton.tintColor = post.isBookmarked ? .systemBlue : .label
        
        Task {
            let image = try? await ImageLoader.shared.loadImage(urlString: post.avatarUrl)
            await MainActor.run {
                avatarView.image = image
            }
        }
    }

    private func setupUIStackView() {
        let spacer = UIView()
        
        let headerStack = UIStackView(arrangedSubviews: [avatarView, usernameLabel])
        headerStack.axis = .horizontal
        headerStack.spacing = 8
        headerStack.alignment = .center
        headerStack.isLayoutMarginsRelativeArrangement = true
        headerStack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 8)
        
        let buttonStack = UIStackView(arrangedSubviews: [likeCountLabel, spacer, bookmarkButton])
        buttonStack.axis = .horizontal
        buttonStack.spacing = 8
        buttonStack.alignment = .center
        
        let bottomStack = UIStackView(arrangedSubviews: [likeButton, buttonStack, captionLabel])
        bottomStack.axis = .vertical
        bottomStack.spacing = 8
        bottomStack.alignment = .fill
        bottomStack.isLayoutMarginsRelativeArrangement = true
        bottomStack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 8)
        
        let mainStack = UIStackView(arrangedSubviews: [headerStack, imageDetailView, bottomStack])
        mainStack.axis = .vertical
        mainStack.spacing = 8
        mainStack.alignment = .fill
        
        view.addSubview(scrollView)
        scrollView.addSubview(mainStack)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            mainStack.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 64),
            mainStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            mainStack.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            imageDetailView.heightAnchor.constraint(equalTo: imageDetailView.widthAnchor),
            avatarView.widthAnchor.constraint(equalToConstant: 32),
            avatarView.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        likeButton.contentHorizontalAlignment = .leading
        avatarView.layer.cornerRadius = 16
        avatarView.clipsToBounds = true
        captionLabel.numberOfLines = 0
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func handleTap() {
        dismiss(animated: true)
    }
}
