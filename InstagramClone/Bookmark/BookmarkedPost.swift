import Foundation
import RealmSwift

class BookmarkedPost: Object {
    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var username: String = ""
    @Persisted var avatarUrl: String = ""
    @Persisted var imageUrl: String = ""
    @Persisted var caption: String = ""
    @Persisted var savedAt: Date = Date()
}

