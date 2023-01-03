
import SwiftUI
import Firebase

@main
struct TastierApp: App {
    
    init(){
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            
            //ContentView(dataManager: AuthViewModel())
            //ContentView()
                //.environmentObject(dataManager)
            WelcomeView()
            //AddRecipeView()
                //.environmentObject(dataManager)
        }
    }
}
