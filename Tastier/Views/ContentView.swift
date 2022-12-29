
import SwiftUI
import Firebase

struct ContentView: View {
    init() {
    //UITabBar.appearance().backgroundColor = UIColor.orange
    }
    var body: some View {
        TabView {
            // First tab
            Text("First tab")
                .tabItem {
                    Image(systemName: "house")
                    
                }

            // Second tab
            RecipeView()
                .tabItem {
                    Image(systemName: "book.fill")
                        .foregroundColor(.black)
                }
                .environmentObject(RecipeViewModel())

            // Third tab
            Text("Third tab")
                .tabItem {
                    Image(systemName: "square.grid.2x2")
                    
                }
            
            Text("Third tab")
                .tabItem {
                    Image(systemName: "person.circle.fill")
                    
                }
            
            
        }
        
        .accentColor(.orange)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
