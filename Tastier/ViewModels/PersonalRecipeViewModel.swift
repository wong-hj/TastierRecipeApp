

import Foundation
import Firebase

class PersonalRecipeViewModel: ObservableObject {
    
    @Published var recipes: [Recipe] = []
    
    init() {
        fetchPersonalRecipe()
    }
    
    func fetchPersonalRecipe() {
        let uid = Auth.auth().currentUser?.uid
        let db = Firestore.firestore()
        let ref = db.collection("Recipe").whereField("uid", isEqualTo: uid ?? "")
        ref.addSnapshotListener { snapshot, error in
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            
            if let snapshot = snapshot {
                
                self.recipes.removeAll()
                for document in snapshot.documents {
                    let documentId = document.documentID
                    let data = document.data()
                    
                    //let id = data["id"] as? Int ?? 0
                    let name = data["name"] as? String ?? ""
                    let rating = data["rating"] as? Double ?? 0.0
                    let time = data["time"] as? Int ?? 0
                    let difficulty = data["difficulty"] as? String ?? ""
                    let category = data["category"] as? String ?? ""
                    let username = data["username"] as? String ?? ""
                    let uid = data["uid"] as? String ?? ""
                    let imageURL = data["imageURL"] as? String ?? ""
                    
                    let recipe = Recipe(name: name, time: time, rating: rating, difficulty: difficulty, ingredient: "", step: "", category: category, docid: documentId, username: username, UID: uid, imageURL: imageURL)
                    self.recipes.append(recipe)
                    
                }
            }
        }
    }
    
    func deleteRecipe(documentID: String) {
        let db = Firestore.firestore()
        
        db.collection("Recipe").document(documentID).delete{ error in
            
            if error == nil {
                
                DispatchQueue.main.async {
                    
                    //remove in list
                    
                    self.recipes.removeAll { recipe in
                        return recipe.docid == documentID
                    }
                }
                
            }
            
        }
    }
    
    
}
