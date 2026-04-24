//
//  ViewController.swift
//  InstagramClone
//
//  Created by Wataru Uehara on 2026/04/17.
//

import UIKit

class InstagramCloneViewController: UIViewController, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
    private let collectionView = InstagramCloneView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
    }
}

