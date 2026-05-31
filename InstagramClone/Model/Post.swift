//
//  Post.swift
//  InstagramClone
//
//  Created by Wataru Uehara on 2026/04/28.
//

import Foundation

struct Post: Hashable, Decodable {
    let id: Int
    let username: String
    let avatarUrl: String
    let imageUrl: String
    var likeCount: Int
    let caption: String
    var isLiked: Bool
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(username)
        hasher.combine(avatarUrl)
        hasher.combine(imageUrl)
        hasher.combine(caption)
        hasher.combine(isLiked)
        hasher.combine(likeCount)
    }
    
    static func == (lhs: Post, rhs: Post) -> Bool {
        lhs.id == rhs.id
        && lhs.username == rhs.username
        && lhs.avatarUrl == rhs.avatarUrl
        && lhs.imageUrl == rhs.imageUrl
        && lhs.caption == rhs.caption
        && lhs.isLiked == rhs.isLiked
        && lhs.likeCount == rhs.likeCount
    }
    
}

extension Post {
    static let sampleData: [Post] = [
        Post(id: 1, username: "tanaka_yuki", avatarUrl: "https://picsum.photos/seed/tanaka/200/200", imageUrl: "https://picsum.photos/seed/post1/600/600", likeCount: 100, caption: "Hello, world!", isLiked: false),
        Post(id: 2, username: "sato_jiro", avatarUrl: "https://picsum.photos/seed/sato/200/200", imageUrl: "https://picsum.photos/seed/post2/600/600", likeCount: 50, caption: "Swift is fun!", isLiked: true),
        Post(id: 3, username: "yamamoto_saburo", avatarUrl: "https://picsum.photos/seed/suzuki/200/200", imageUrl: "https://picsum.photos/seed/post3/600/600", likeCount: 200, caption: "UIKit is amazing!", isLiked: false),
        Post(id: 4, username: "hirose_goro", avatarUrl: "https://picsum.photos/seed/yamada/200/200", imageUrl: "https://picsum.photos/seed/post4/600/600", likeCount: 1570, caption: "iOS development is cool!", isLiked: true),
        Post(id: 5, username: "matsuda_shiro", avatarUrl: "https://picsum.photos/seed/ito/200/200", imageUrl: "https://picsum.photos/seed/post5/600/600", likeCount: 1, caption: "React Native is great!リアクトネイティブは素晴らしい！React Native is great!リアクトネイティブは素晴らしい！React Native is great!リアクトネイティブは素晴らしい！React Native is great!リアクトネイティブは素晴らしい！", isLiked: false),
    ]
}
