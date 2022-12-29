
import Foundation
import Firebase

class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    
    init() {
        fetchRecipes()
    }
    
    func fetchRecipes() {
        recipes.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("Recipe")
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let documentId = document.documentID
                    let data = document.data()
                    
                    let id = data["id"] as? Int ?? 0
                    let name = data["name"] as? String ?? ""
                    let rating = data["rating"] as? Double ?? 0.0
                    let time = data["time"] as? Int ?? 0
                    let difficulty = data["difficulty"] as? String ?? ""
                    let category = data["category"] as? String ?? ""
                    
                    let recipe = Recipe(name: name, time: time, rating: rating, difficulty: difficulty, ingredient: "", step: "", category: category, id: id, docid: documentId)
                    self.recipes.append(recipe)
                }
            }
        }
        
    }
    
    
}
