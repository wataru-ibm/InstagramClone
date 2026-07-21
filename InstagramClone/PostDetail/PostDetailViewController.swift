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

    init(post: Post) {
        self.post = post
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        imageLoadTask = Task {
            let image = try? await ImageLoader.shared.loadImage(urlString: post.imageUrl)
            await MainActor.run {
                imageDetailView.image = image
            }
        }
    }

    private func setupUI() {
        view.addSubview(imageDetailView)
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
        imageDetailView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageDetailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func handleTap() {
        dismiss(animated: true)
    }
}
