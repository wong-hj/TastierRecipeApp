

import Foundation
import Firebase

class RegisterViewModel: ObservableObject {
    
    func addUser(email : String, uid : String, username : String) {
        let db = Firestore.firestore()
        let ref = db.collection("User").document(uid)
        ref.setData(["email": email, "uid" : uid, "username" : username]) { error in
            
            if let error = error {
                print("something went wrong, error: \(error)")
                
            }
            
        }
    }
}
