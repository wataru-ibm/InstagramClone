//
//  BookmarkRepository.swift
//  InstagramClone
//
//  Created by Wataru Uehara on 2026/06/13.
//

import Foundation
import RealmSwift

class BookmarkRepository {
    let realm = try! Realm()
    
    func save(post: Post) {
        let bookmarked = BookmarkedPost()
        bookmarked.id = post.id
        bookmarked.username = post.username
        bookmarked.avatarUrl = post.avatarUrl
        bookmarked.imageUrl = post.imageUrl
        bookmarked.caption = post.caption
        bookmarked.savedAt = Date()
        
        try! realm.write {
            realm.add(bookmarked)
        }
    }
    
    func delete(postId: Int) {
        let object = realm.object(ofType: BookmarkedPost.self, forPrimaryKey: postId)
        guard let object = object else { return }
        try! realm.write {
            realm.delete(object)
        }
    }
    
    func fetchAll() -> [BookmarkedPost] {
        let results = realm.objects(BookmarkedPost.self)
        return Array(results)
    }
}
