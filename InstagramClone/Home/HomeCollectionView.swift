//
//  InstagramCloneView.swift
//  InstagramClone
//
//  Created by Wataru Uehara on 2026/04/18.
//

import UIKit

class HomeCollectionView: UICollectionView {

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
        let layout = HomeCollectionView.createCompositionalLayout()
        super.init(frame: frame, collectionViewLayout: layout)
        self.register(HomePostCell.self, forCellWithReuseIdentifier: HomePostCell.reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
    


