
import Foundation
import Firebase

class DetailViewModel: ObservableObject {
    @Published var recordId: String
    @Published var recipe: Recipe

    init(recordId: String) {

        self.recordId = recordId
        self.recipe = Recipe(name: "", time: 0, rating: 0.0, difficulty: "", ingredient: "", step: "", category: "", docid: "", username: "", UID: "", imageURL: "")
        fetchRecipe()
    }

    func fetchRecipe() {
        let db = Firestore.firestore()

        let docRef = db.collection("Recipe").document(recordId)

        docRef.addSnapshotListener { (documentSnapshot, error) in
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }

            if let documentSnapshot = documentSnapshot, documentSnapshot.exists {
                let documentId = documentSnapshot.documentID
                let data = documentSnapshot.data()

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
    
}
