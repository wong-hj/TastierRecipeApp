
import SwiftUI
import Firebase

struct ContentView: View {
    var body: some View {
        NavigationView {
            TabView {
                Group {
                    // First tab
                    LandingView()
                        .tabItem {
                            Image(systemName: "house")
                            Text("Home")
                        }

                    // Second tab
                    RecipeView(category: .constant(""))
                        .tabItem {
                            Image(systemName: "fork.knife.circle.fill")
                            Text("Recipe")
                        }
                    
                    // Third tab
                    PersonalRecipeView()
                        .tabItem {
                            Image(systemName: "list.bullet.rectangle.portrait")
                            Text("Personal Recipe")
                        }
                    
                    // Fourth tab
                    ProfileView()
                        .tabItem {
                            Image(systemName: "person.circle.fill")
                            Text("User")
                            
                        }
                }
    
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
