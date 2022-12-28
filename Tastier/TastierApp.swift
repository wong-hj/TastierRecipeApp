
import SwiftUI
import Firebase

@main
struct TastierApp: App {
    @StateObject var dataManager = AddRecipeViewModel()
    init(){
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            //WelcomeView()
            AddRecipeView()
                .environmentObject(dataManager)
        }
    }
}
