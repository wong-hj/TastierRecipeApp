
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
            ContentView()
                .environmentObject(dataManager)
            //AddRecipeView()
                //.environmentObject(dataManager)
        }
    }
}
