//
//  SearchCollectionView.swift
//  InstagramClone
//
//  Created by Wataru Uehara on 2026/05/23.
//

import UIKit

class SearchCollectionView: UICollectionView {
    
    private static func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1/3),
            heightDimension: .fractionalWidth(1/3)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalWidth(1/3)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    init (frame: CGRect) {
        let layout = SearchCollectionView.createCompositionalLayout()
        super.init(frame: frame, collectionViewLayout: layout)
        self.register(SearchGridCell.self, forCellWithReuseIdentifier: SearchGridCell.reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
