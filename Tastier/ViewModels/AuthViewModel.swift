
import Foundation
import Firebase

class AuthViewModel: ObservableObject {
    @Published var user: User
    
    init(){
        self.user = User(email: "", uid: "", username: "")
        fetchCurrentUser()
    }
    
    func addUser(email : String, uid : String, username : String) {
        let db = Firestore.firestore()
        let ref = db.collection("User").document(uid)
        ref.setData(["email": email, "uid" : uid, "username" : username]) { error in
            
            if let error = error {
                print("something went wrong, error: \(error)")
                
            }
            
        }
    }
    
    func fetchCurrentUser() {
        
        let uid = Auth.auth().currentUser?.uid
        let db = Firestore.firestore()

        let docRef = db.collection("User").document(uid!)

        docRef.getDocument { (document, error) in
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }

            if let document = document, document.exists {
                let data = document.data()

                if let data = data {

                    let email = data["email"] as? String ?? ""
                    let uid = data["uid"] as? String ?? ""
                    let username = data["username"] as? String ?? ""
                    

                    self.user = User(email: email, uid: uid, username: username)
                   
                }

            }
       }
    }
}
