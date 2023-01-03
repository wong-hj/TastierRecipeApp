
import Foundation
import Firebase

class AuthViewModel: ObservableObject {
    
    @Published var user: User
    
    @Published var listener: ListenerRegistration!
    
    init(){
        self.user = User(email: "", uid: "", username: "")
        fetchCurrentUser()
    }
    
//    func addUser(email : String, uid : String, username : String) {
//        let db = Firestore.firestore()
//        let ref = db.collection("User").document(uid)
//        ref.setData(["email": email, "uid" : uid, "username" : username]) { error in
//            
//            if let error = error {
//                print("something went wrong, error: \(error)")
//                
//            }
//            
//        }
//    }
    
    func fetchCurrentUser() {
        
        let uid = Auth.auth().currentUser?.uid
        //print("USERID is \(uid)\n\n")
        
        let db = Firestore.firestore()

        let docRef = db.collection("User").document(uid!)

        listener = docRef.addSnapshotListener { (documentSnapshot, error) in
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }

            if let documentSnapshot = documentSnapshot, documentSnapshot.exists {
                let data = documentSnapshot.data()

                if let data = data {

                    let email = data["email"] as? String ?? ""
                    let uid = data["uid"] as? String ?? ""
                    let username = data["username"] as? String ?? ""
                    

                    self.user = User(email: email, uid: uid, username: username)
                   
                }

            }
       }
    }
    
    func logout() {
        do {
          try Auth.auth().signOut()
            
            listener.remove()
            
          // User is signed out.
        } catch let error {
          // An error occurred while signing out.
            print("something went wrong, error: \(error)")
        }
    }
}
