
import Foundation
import Firebase

struct User: Identifiable, Codable {
   
    var email: String
    var id = UUID()
    var uid: String
    var username: String
}
