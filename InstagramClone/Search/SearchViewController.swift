//
//  SearchViewController.swift
//  InstagramClone
//
//  Created by Wataru Uehara on 2026/05/23.
//

import UIKit
import Combine

class SearchViewController: UIViewController {
    private let collectionView = SearchCollectionView(frame: .zero)
    private let viewModel = SearchViewModel()
    private var dataSource: UICollectionViewDiffableDataSource<Section, Post>!
    private var cancellables: Set<AnyCancellable> = []
    private let loadingView: HomeLoadingView = {
        let view = HomeLoadingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let zoomTransitionDelegate = ZoomTransitionDelegate()
    
    enum Section {
        case main
    }
    
    private let errorMessageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 13)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let retryButton: UIButton = {
        let button = UIButton()
        button.setTitle("再試行", for: .normal)
        return button
    }()
    
    private lazy var errorView: UIView = {
        let stackView = UIStackView(arrangedSubviews: [errorMessageLabel, retryButton])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.spacing = 16
        return stackView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDataSource()
        Task {
            bindViewModel()
            await viewModel.loadSearchPosts()
        }
    }
    
    private func setupUI() {
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        view.addSubview(errorView)
        errorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        retryButton.addTarget(self, action: #selector(retryButtonTapped), for: .touchUpInside)
    }
    
    @objc private func retryButtonTapped() {
        Task {
            await viewModel.loadSearchPosts()
        }
    }
    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Post>(collectionView: collectionView) { collectionView, indexPath, post in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchGridCell.reuseIdentifier, for: indexPath) as? SearchGridCell else {
                return UICollectionViewCell()
            }
            
            cell.imageUrl = post.imageUrl
            return cell
        }
    }
    
    private func applySnapshot(_ posts: [Post]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Post>()
        snapshot.appendSections([.main])
        snapshot.appendItems(posts)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func bindViewModel() {
        viewModel.$posts
            .receive(on: DispatchQueue.main)
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
    
    private func updateViewForStatus(_ status: SearchViewModel.Status) {
        switch status {
        case .loading:
            collectionView.isHidden = true
            errorView.isHidden = true
            loadingView.isHidden = false
            loadingView.startAnimating()
            
        case .loaded:
            collectionView.isHidden = false
            errorView.isHidden = true
            loadingView.isHidden = true
            loadingView.stopAnimating()
            
        case .error(let message):
            collectionView.isHidden = true
            errorView.isHidden = false
            loadingView.stopAnimating()
            errorMessageLabel.text = message
        }
    }
    
    
}

extension SearchViewController: UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let post = dataSource.itemIdentifier(for: indexPath) else { return }
        guard let cell = collectionView.cellForItem(at: indexPath) as? SearchGridCell else { return }
        zoomTransitionDelegate.fromImageView = cell.thumbnailImageView
        
        let detailVC = PostDetailViewController(post: post)
        detailVC.transitioningDelegate = zoomTransitionDelegate
        detailVC.modalPresentationStyle = .fullScreen
        present(detailVC, animated: true)
    }
    
    
}

