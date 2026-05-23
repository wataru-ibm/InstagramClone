//
//  InstagramCloneLoadingView.swift
//  InstagramClone
//
//  Created by Wataru Uehara on 2026/05/11.
//

import UIKit
import SkeletonView

class InstagramCloneLoadingView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isSkeletonable = true
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        let stackView =  UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.isSkeletonable = true
        for _ in 0..<3 {
            stackView.addArrangedSubview(createSkeletonPostView())
        }
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func createSkeletonPostView() -> UIView {
        let avatarView = UIView()
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        avatarView.layer.cornerRadius = 16
        avatarView.clipsToBounds = true
        avatarView.isSkeletonable = true
        avatarView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        avatarView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        let usernameView = UIView()
        usernameView.translatesAutoresizingMaskIntoConstraints = false
        usernameView.heightAnchor.constraint(equalToConstant: 14).isActive = true
        usernameView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        usernameView.isSkeletonable = true
        
        let headerStackView = UIStackView(arrangedSubviews: [avatarView, usernameView])
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        headerStackView.axis = .horizontal
        headerStackView.spacing = 8
        headerStackView.alignment = .center
        headerStackView.isSkeletonable = true
        
        let imageView = UIView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        imageView.isSkeletonable = true
        
        let heartView = UIView()
        heartView.translatesAutoresizingMaskIntoConstraints = false
        heartView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        heartView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        heartView.isSkeletonable = true
        
        let likeCountView = UIView()
        likeCountView.translatesAutoresizingMaskIntoConstraints = false
        likeCountView.heightAnchor.constraint(equalToConstant: 14).isActive = true
        likeCountView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        likeCountView.isSkeletonable = true
        
        let captionView = UIView()
        captionView.translatesAutoresizingMaskIntoConstraints = false
        captionView.heightAnchor.constraint(equalToConstant: 14).isActive = true
        captionView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        captionView.isSkeletonable = true
        
        let actionStackView = UIStackView(arrangedSubviews: [heartView, likeCountView])
        actionStackView.translatesAutoresizingMaskIntoConstraints = false
        actionStackView.axis = .horizontal
        actionStackView.spacing = 8
        actionStackView.alignment = .leading
        actionStackView.isSkeletonable = true
        
        let bottomStackView = UIStackView(arrangedSubviews: [actionStackView, captionView])
        bottomStackView.axis = .vertical
        bottomStackView.spacing = 8
        bottomStackView.alignment = .leading
        bottomStackView.isSkeletonable = true
        
        let mainStackView = UIStackView(arrangedSubviews: [headerStackView, imageView, bottomStackView])
        mainStackView.axis = .vertical
        mainStackView.spacing = 8
        mainStackView.isSkeletonable = true
        return mainStackView
    }
    
    func startAnimating() {
        showAnimatedGradientSkeleton()
    }
        
    func stopAnimating() {
        hideSkeleton()
    }
    
}
