
import Foundation
import Firebase

class DetailViewModel: ObservableObject {
    var recordId: String
    
    @Published var name: String = ""
    @Published var time: Int = 0
    @Published var rating: Double = 0
    @Published var difficulty: String = ""
    @Published var ingredient: String = ""
    @Published var step: String = ""
    @Published var category: String = ""
    @Published var id: Int = 0
    @Published var docid: String = ""
    
    init(recordId: String) {

        self.recordId = recordId
        self.fetchRecipe()
    }

    
    func fetchRecipe() {
        //recipe.removeAll()
        let db = Firestore.firestore()

        let docRef = db.collection("Recipe").document(recordId)

        docRef.getDocument { (document, error) in
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }

            if let document = document, document.exists {
                
                let data = document.data()

                if let data = data {

                    self.id = data["id"] as? Int ?? 0
                    self.name = data["name"] as? String ?? ""
                    self.rating = data["rating"] as? Double ?? 0.0
                    self.time = data["time"] as? Int ?? 0
                    self.difficulty = data["difficulty"] as? String ?? ""
                    self.category = data["category"] as? String ?? ""
                    self.ingredient = data["ingredient"] as? String ?? ""
                    self.step = data["step"] as? String ?? ""

//                    let recipe_one = Recipe(name: name, time: time, rating: rating, difficulty: difficulty, ingredient: ingredient, step: step, category: category, id: id, docid: documentId)
//                    self.recipe.append(recipe_one)
//
//                    print(self.recipe)
                }


            }
       }
        
    }
    
}
