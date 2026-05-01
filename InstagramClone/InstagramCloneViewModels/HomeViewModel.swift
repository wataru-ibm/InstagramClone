//
//  HomeViewModel.swift
//  InstagramClone
//
//  Created by Wataru Uehara on 2026/04/28.
//

import Combine

class HomeViewModel {
    @Published private(set) var posts: [Post] = []

    func loadPosts() {
        posts = Post.sampleData
    }

    func toggleLike(at index: Int) {
        guard posts.indices.contains(index) else {
            return
        }
        
        posts[index].isLiked.toggle()
            
        posts[index].likeCount += posts[index].isLiked ? 1 : -1
            
    }
}
