
import Foundation
import Firebase
import FirebaseStorage

class UpdateRecipeViewModel: ObservableObject {
    var documentid: String
    @Published var recipe: Recipe

    init(documentid: String) {

        self.documentid = documentid
        self.recipe = Recipe(name: "", time: 0, rating: 0.0, difficulty: "", ingredient: "", step: "", category: "", docid: "", username: "", UID: "", imageURL: "")
        fetchRecipe()
    }
    
    func fetchRecipe() {
        let db = Firestore.firestore()

        let docRef = db.collection("Recipe").document(documentid)
        print("DOCUMENT ID IS \(documentid)")
        docRef.getDocument { (document, error) in
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }

            if let document = document, document.exists {
                let documentId = document.documentID
                let data = document.data()

                if let data = data {

                    //let id = data["id"] as? Int ?? 0
                    let name = data["name"] as? String ?? ""
                    let rating = data["rating"] as? Double ?? 0.0
                    let time = data["time"] as? Int ?? 0
                    let difficulty = data["difficulty"] as? String ?? ""
                    let category = data["category"] as? String ?? ""
                    let ingredient = data["ingredient"] as? String ?? ""
                    let step = data["step"] as? String ?? ""
                    let username = data["username"] as? String ?? ""
                    let uid = data["uid"] as? String ?? ""
                    let imageURL = data["imageURL"] as? String ?? ""

                    self.recipe = Recipe(name: name, time: time, rating: rating, difficulty: difficulty, ingredient: ingredient,
                                         step: step, category: category, docid: documentId, username: username, UID: uid, imageURL: imageURL)
                   
                }

            }
       }
    }
    
    func updateRecipe(name: String, time: Int, rating: Double, difficulty: String, ingredient: String, step: String, category: String, selectedImage: UIImage?, docid: String) {
        
        if selectedImage != nil {
            let storageRef = Storage.storage().reference()
            
            let imageData = selectedImage!.jpegData(compressionQuality: 0.8)
            
            guard imageData != nil else {
                return
            }
            
            let path = UUID().uuidString
            let fileRef = storageRef.child(path)
            
            fileRef.putData(imageData!, metadata: nil) { metadata, err in
                
                if let err = err {
                    print(err)
                }
                
                fileRef.downloadURL { url, err in
                    
                    let db = Firestore.firestore()
                    let ref = db.collection("Recipe").document(docid)
                    //let id = Int.random(in: 1..<10000)
                    
                    ref.setData(["name": name, "time": time, "rating": rating, "difficulty": difficulty, "ingredient": ingredient,
                                 "step": step, "category": category, "imageURL": url?.absoluteString ?? ""], merge: true) { error in
                        
                        if let error = error {
                            print("something went wrong, error: \(error)")
                            
                        }
                        
                    }
                    
                }
            }
        } else {
            
            let db = Firestore.firestore()
            let ref = db.collection("Recipe").document(docid)
            //let id = Int.random(in: 1..<10000)
            
            ref.setData(["name": name, "time": time, "rating": rating, "difficulty": difficulty, "ingredient": ingredient,
                         "step": step, "category": category], merge: true) { error in
                
                if let error = error {
                    print("something went wrong, error: \(error)")
                    
                }
                
            }
        }
        
    }
    
    
    
}
