
import Foundation
import Firebase

class EditProfileViewModel: ObservableObject {
    
    
    func editUser(email: String, username: String, password: String) {
        let uid = Auth.auth().currentUser?.uid
        let userEmail = Auth.auth().currentUser?.email
        let currentUser = Auth.auth().currentUser
        let db = Firestore.firestore()
        let ref = db.collection("User").document(uid ?? "")
        //let id = Int.random(in: 1..<10000)
        
        ref.setData(["username": username, "email": email], merge: true) { error in
            
            if let error = error {
                print("something went wrong, error: \(error)")
                
            }
            
        }
        
        if email != userEmail {
            currentUser?.updateEmail(to: email) { error in
                if let error = error {
                    print("something went wrong, error: \(error)")
                    
                }
            }
        }
        
        if !password.isEmpty {
            currentUser?.updatePassword(to: password) { error in
                if let error = error {
                    print("something went wrong, error: \(error)")
                    
                }
            }
        }
        
        
        
    }
    
    
}
