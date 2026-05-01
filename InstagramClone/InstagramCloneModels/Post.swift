//
//  Post.swift
//  InstagramClone
//
//  Created by Wataru Uehara on 2026/04/28.
//

import UIKit

struct Post {
    let id: Int
    let username: String
    let avatarColor: UIColor
    let imageColor: UIColor
    var likeCount: Int
    let caption: String
    var isLiked: Bool
}

extension Post {
    static let sampleData: [Post] = [
        Post(id: 1, username: "tanaka_yuki", avatarColor: .blue, imageColor: .yellow, likeCount: 100, caption: "Hello, world!", isLiked: false),
        Post(id: 2, username: "sato_jiro", avatarColor: .red, imageColor: .green, likeCount: 50, caption: "Swift is fun!", isLiked: true),
        Post(id: 3, username: "yamamoto_saburo", avatarColor: .orange, imageColor: .purple, likeCount: 200, caption: "UIKit is amazing!", isLiked: false),
        Post(id: 4, username: "hirose_goro", avatarColor: .brown, imageColor: .black, likeCount: 1570, caption: "iOS development is cool!", isLiked: true),
        Post(id: 5, username: "matsuda_shiro", avatarColor: .gray, imageColor: .orange, likeCount: 1, caption: "React Native is great!リアクトネイティブは素晴らしい！React Native is great!リアクトネイティブは素晴らしい！React Native is great!リアクトネイティブは素晴らしい！React Native is great!リアクトネイティブは素晴らしい！", isLiked: false),
    ]
}
