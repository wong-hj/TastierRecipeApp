
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
                            
                        }

                    // Second tab
                    RecipeView(category: .constant(""))
                        .tabItem {
                            Image(systemName: "book.fill")
                                .foregroundColor(.black)
                        }
                    
                    // Third tab
                    PersonalRecipeView()
                        .tabItem {
                            Image(systemName: "square.grid.2x2")
                        }
                    
                    // Fourth tab
                    ProfileView()
                        .tabItem {
                            Image(systemName: "person.circle.fill")
                            
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
