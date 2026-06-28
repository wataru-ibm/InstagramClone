//
//  HomeViewModel.swift
//  InstagramClone
//
//  Created by Wataru Uehara on 2026/04/28.
//

import Combine

class HomeViewModel {
    @Published private(set) var posts: [Post] = []
    @Published private(set) var status: Status = .loading
    
    enum Status {
        case loading
        case loaded
        case error(String)
    }
    
    func loadPosts() async {
        
        if posts.isEmpty {
            status = .loading
        }
        
        do {
            posts = try await APIClient.shared.fetchPosts()
            status = .loaded
        } catch {
            if posts.isEmpty {
                status = .error(error.localizedDescription)
            }
            print("[HomeViewModel] 投稿取得失敗: \(error.localizedDescription)")
        }
    }

    

    func toggleLike(at index: Int) {
        guard posts.indices.contains(index) else {
            return
        }
        
        posts[index].isLiked.toggle()
            
        posts[index].likeCount += posts[index].isLiked ? 1 : -1
            
    }
    
    func toggleBookmark(at index: Int) {
        guard posts.indices.contains(index) else {
            return
        }
        
        posts[index].isBookmarked.toggle()
        
        let post = posts[index]
        if post.isBookmarked {
            BookmarkRepository.shared.save(post: post)
        } else {
            BookmarkRepository.shared.delete(postId: post.id)
        }
    }
}
