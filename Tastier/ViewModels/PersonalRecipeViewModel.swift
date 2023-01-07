

import Foundation
import Firebase

class PersonalRecipeViewModel: ObservableObject {
    // create a recipe array to store recipe fetched
    @Published var recipes: [Recipe] = []
    
    // initialize the fetchPersonalRecipe method
    // run fetchPersonalRecipe() method straight away
    init() {
        fetchPersonalRecipe()
    }
    
    func fetchPersonalRecipe() {
        //get currentUser id
        let uid = Auth.auth().currentUser?.uid
        
        //firestore reference
        let db = Firestore.firestore()
        
        //filter with where clause to get personal recipe
        let ref = db.collection("Recipe").whereField("uid", isEqualTo: uid ?? "")
        ref.addSnapshotListener { snapshot, error in
            // if error then print and return
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            
            
            if let snapshot = snapshot {
                //remove recipes array to avoid any confusion / duplication
                self.recipes.removeAll()
                
                // for each document in the fetched result
                for document in snapshot.documents {
                    let documentId = document.documentID
                    let data = document.data()
                    
                    // get data to constants
                    
                    let name = data["name"] as? String ?? ""
                    let rating = data["rating"] as? Double ?? 0.0
                    let time = data["time"] as? Int ?? 0
                    let difficulty = data["difficulty"] as? String ?? ""
                    let category = data["category"] as? String ?? ""
                    let username = data["username"] as? String ?? ""
                    let uid = data["uid"] as? String ?? ""
                    let imageURL = data["imageURL"] as? String ?? ""
                    
                    let recipe = Recipe(name: name, time: time, rating: rating, difficulty: difficulty, ingredient: "", step: "", category: category, docid: documentId, username: username, UID: uid, imageURL: imageURL)
                    
                    //append recipe to recipes array
                    self.recipes.append(recipe)
                }
            }
        }
    }
    
    // delete Recipe
    func deleteRecipe(documentID: String) {
        let db = Firestore.firestore()
        
        // delete document
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
