//
//  InstagramCloneView.swift
//  InstagramClone
//
//  Created by Wataru Uehara on 2026/04/18.
//

import UIKit

class InstagramCloneView: UICollectionView {

    private static func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(500)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(500)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }

    init (frame: CGRect) {
        let layout = InstagramCloneView.createCompositionalLayout()
        super.init(frame: frame, collectionViewLayout: layout)
        self.register(InstagramCloneCell.self, forCellWithReuseIdentifier: InstagramCloneCell.reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
    


