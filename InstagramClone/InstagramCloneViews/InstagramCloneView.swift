//
//  InstagramCloneView.swift
//  InstagramClone
//
//  Created by Wataru Uehara on 2026/04/18.
//

import UIKit

class InstagramCloneView: UICollectionView {
    
    private let avatarHeight: CGFloat = 40
    private let avatarTopPadding: CGFloat = 8
    private let avatarBottomPadding: CGFloat = 8
    private var headerHeight: CGFloat{
        avatarHeight + avatarTopPadding + avatarBottomPadding
    }
    private let actionBarHeight: CGFloat = 56
    private let spacing: CGFloat = 24

    init (frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        super.init(frame: frame, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        self.register(InstagramCloneCell.self, forCellWithReuseIdentifier: "cell")
        (collectionViewLayout as? UICollectionViewFlowLayout)?.itemSize = CGSize(width: UIScreen.main.bounds.width, height: headerHeight + UIScreen.main.bounds.width + actionBarHeight + spacing)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
    


