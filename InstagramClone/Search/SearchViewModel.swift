//
//  SearchViewModel.swift
//  InstagramClone
//
//  Created by Wataru Uehara on 2026/05/23.
//

import Combine

class SearchViewModel {
    @Published private(set) var posts: [Post] = []
    @Published private(set) var status: Status = .loading
    
    enum Status {
        case loading
        case loaded
        case error(String)
    }
    
    func loadSearchPosts() async {
        
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
            print("[SearchViewModel] 投稿取得失敗: \(error.localizedDescription)")
        }
    }
}


