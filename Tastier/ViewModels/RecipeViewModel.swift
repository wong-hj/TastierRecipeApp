
import Foundation
import Firebase
import FirebaseStorage

class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var image: UIImage?
 
    func fetchRecipes(category: String) {
        recipes.removeAll()
        let db = Firestore.firestore()
        
        if category == "All" {
            let ref = db.collection("Recipe")
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
        } else {
            let ref = db.collection("Recipe").whereField("category", isEqualTo: category)
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
        
        
    }

}
