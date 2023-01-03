
import SwiftUI
import Firebase

@main
struct TastierApp: App {
    
    //configure firebase
    init(){
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            //First screen is WelcomeView()
            WelcomeView()
        }
    }
}
