
import SwiftUI
import Firebase

struct ContentView: View {
    //@ObservedObject var dataManager: AuthViewModel
    @State var image: UIImage?
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
                        //.environmentObject(RecipeViewModel())

                    // Third tab
                    PersonalRecipeView()
                        .tabItem {
                            Image(systemName: "square.grid.2x2")
                            
                        }
                    
                    ProfileView()
                        .tabItem {
                            Image(systemName: "person.circle.fill")
                            
                        }
                }

                
                
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
        
        //.accentColor(.orange)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        //ContentView(dataManager: AuthViewModel())
        ContentView()
    }
}
