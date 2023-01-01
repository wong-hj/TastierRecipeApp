
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
            
            //ContentView(dataManager: AuthViewModel())
            ContentView()
                //.environmentObject(dataManager)
            //WelcomeView()
            //AddRecipeView()
                //.environmentObject(dataManager)
        }
    }
}
