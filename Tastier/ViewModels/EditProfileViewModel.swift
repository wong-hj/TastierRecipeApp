
import Foundation
import Firebase

class EditProfileViewModel: ObservableObject {
    
    
    func editUser(email: String, username: String, password: String) {
        let uid = Auth.auth().currentUser?.uid
        
        let db = Firestore.firestore()
        let ref = db.collection("User").document(uid ?? "")
        //let id = Int.random(in: 1..<10000)
        
        ref.setData(["username": username, "email": email], merge: true) { error in
            
            if let error = error {
                print("something went wrong, error: \(error)")
                
            }
            
        }
        
        let userEmail = Auth.auth().currentUser?.email
        let currentUser = Auth.auth().currentUser
        
        // if email entered is not same as the userEmail in Firebase Auth
        if email != userEmail {
            
            // update email
            currentUser?.updateEmail(to: email) { error in
                if let error = error {
                    print("something went wrong, error: \(error)")
                    
                }
            }
        }
        
        // if password is not empty
        if !password.isEmpty {
            
            // update password
            currentUser?.updatePassword(to: password) { error in
                if let error = error {
                    print("something went wrong, error: \(error)")
                    
                }
            }
        }
        
        
        
    }
    
    
}
