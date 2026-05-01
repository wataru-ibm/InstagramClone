//
//  ViewController.swift
//  InstagramClone
//
//  Created by Wataru Uehara on 2026/04/17.
//

import UIKit
import Combine

class InstagramCloneViewController: UIViewController, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InstagramCloneCell.reuseIdentifier, for: indexPath) as? InstagramCloneCell else {
           return UICollectionViewCell()
        }
        
        let post = viewModel.posts[indexPath.row]
        cell.username = post.username
        cell.avatarColor = post.avatarColor
        cell.imageColor = post.imageColor
        cell.likeCount = post.likeCount
        cell.isLiked = post.isLiked
        cell.caption = post.caption
        cell.onLikeTapped = { [weak self] in
            self? .viewModel.toggleLike(at: indexPath.row)
        }
        
        return cell
        
    }
    
    private let collectionView = InstagramCloneView(frame: .zero)
    private let viewModel = HomeViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.loadPosts()
        bindViewModel()
    }
    
    private func setupUI() {
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func bindViewModel() {
        viewModel.$posts.sink { [weak self] posts in
            self?.collectionView.reloadData()
        }
        .store(in: &cancellables)
    }
}

