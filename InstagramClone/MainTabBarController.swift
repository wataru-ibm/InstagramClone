//
//  MainTabBarController.swift
//  InstagramClone
//
//  Created by Wataru Uehara on 2026/05/23.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let homeVC = HomeViewController()
        let searchVC = SearchViewController()
        let bookmarkVC = BookmarkViewController()
        let homeNav = UINavigationController(rootViewController: homeVC)
        let searchNav = UINavigationController(rootViewController: searchVC)
        let bookmarkNav = UINavigationController(rootViewController: bookmarkVC)
        homeNav.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        searchNav.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        bookmarkNav.tabBarItem = UITabBarItem(title: "Bookmark", image: UIImage(systemName: "bookmark"), tag: 2)
        viewControllers = [homeNav, searchNav, bookmarkNav]
    }
}
