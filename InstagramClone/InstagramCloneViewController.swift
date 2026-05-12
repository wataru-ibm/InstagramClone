//
//  ViewController.swift
//  InstagramClone
//
//  Created by Wataru Uehara on 2026/04/17.
//

import UIKit
import Combine

class InstagramCloneViewController: UIViewController {
    
    private let collectionView = InstagramCloneView(frame: .zero)
    private let viewModel = HomeViewModel()
    private var dataSource: UICollectionViewDiffableDataSource<Section, Post>!
    private var cancellables: Set<AnyCancellable> = []
    private let loadingView: InstagramCloneLoadingView = {
        let view = InstagramCloneLoadingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let errorMessageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 13)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let retryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("再試行", for: .normal)
        return button
    }()
    
    private lazy var errorView: UIView = {
        let stackView = UIStackView(arrangedSubviews: [errorMessageLabel, retryButton])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 16
        stackView.alignment = .center
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        Task {
            await viewModel.loadPosts()
        }
        bindViewModel()
    }
    
    private func setupUI() {
        dataSource = UICollectionViewDiffableDataSource<Section, Post>(collectionView: collectionView){collectionView, indexPath, post in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InstagramCloneCell.reuseIdentifier, for: indexPath) as? InstagramCloneCell else {
                return UICollectionViewCell()
            }
            
            cell.username = post.username
            cell.avatarUrl = post.avatarUrl
            cell.imageUrl = post.imageUrl
            cell.likeCount = post.likeCount
            cell.isLiked = post.isLiked
            cell.caption = post.caption
            cell.onLikeTapped = { [weak self] in
                self? .viewModel.toggleLike(at: indexPath.row)
            }
            return cell
        }
        
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        view.addSubview(errorView)
        errorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    private func applySnapshot(_ posts: [Post]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Post>()
        snapshot.appendSections([.main])
        snapshot.appendItems(posts)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func bindViewModel() {
        viewModel.$posts
            .sink { [weak self] posts in
            self?.applySnapshot(posts)
        }
            .store(in: &cancellables)
        
        viewModel.$status
            .receive(on: DispatchQueue.main)
            .sink { [weak self] status in
                self?.updateViewForStatus(status)
            }
            .store(in: &cancellables)
    }
    
    private func updateViewForStatus(_ status: HomeViewModel.Status) {
        switch status {
        case .loading:
            collectionView.isHidden = true
            errorView.isHidden = true
            loadingView.isHidden = false
            loadingView.startAnimating()
            
        case .loaded:
            loadingView.stopAnimating()
            errorView.isHidden = true
            collectionView.isHidden = false
            
        case .error(let message):
            loadingView.stopAnimating()
            loadingView.isHidden = true
            collectionView.isHidden = true
            errorView.isHidden = false
            errorMessageLabel.text = message
        }
    }
    
    enum Section {
    case main
    }
}

