//
//  SearchGridCell.swift
//  InstagramClone
//
//  Created by Wataru Uehara on 2026/05/23.
//

import UIKit

class SearchGridCell: UICollectionViewCell {
    
    static let reuseIdentifier = "SearchGridCell"
    
    private let postImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    var imageUrl: String? {
        didSet {
            guard let imageUrl = imageUrl else { return }
            imageLoadTask = Task {
                let image = try? await ImageLoader.shared.loadImage(urlString: imageUrl)
                await MainActor.run {
                    postImageView.image = image
                }
            }
        }
    }
    
    var thumbnailImageView: UIImageView { postImageView }
    
    private var imageLoadTask: Task<Void, Never>?
    
    private func setupUI() {
        contentView.addSubview(postImageView)
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            postImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageLoadTask?.cancel()
        imageLoadTask = nil
        postImageView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
