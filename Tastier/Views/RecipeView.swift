
import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct RecipeView: View {
    @ObservedObject var dataManager = RecipeViewModel()
    @Binding var category: String
    @State private var toAddRecipeView = false
    
    
    init(category: Binding<String>) {
        
        self._category = category
            
        if category.wrappedValue.isEmpty {
            
            dataManager.fetchRecipes(category: "All")
            
        } else {
            
            
            dataManager.fetchRecipes(category: category.wrappedValue)
            
        }
    }
    
    var body: some View {
 
        NavigationView {
            ScrollView {
                ZStack {
                    VStack {
                        
                        Group{
                            HStack {
                                if $category.wrappedValue.isEmpty {
                                    Text("Recipes")
                                        .font(.largeTitle)
                                        .foregroundColor(.orange) +
                                    Text(" All")
                                        .font(.title3)
                                        .foregroundColor(.orange)
                                        .baselineOffset(8.0)
                                    
                                    Spacer()
                                    
                                    
                                    Button(action: {
                                            // Code to execute when the button is tapped
                                            toAddRecipeView = true
                                        }) {
                                            Image(systemName: "plus")
                                                .font(.system(size: 20))
                                                .foregroundColor(.orange)
                                        }
                                        .padding(.trailing, 10)
                                        .sheet(isPresented: $toAddRecipeView) {
                                            AddRecipeView()
                                        }
                                    
                                } else {
                                    Text("Recipes")
                                        .font(.largeTitle)
                                        .foregroundColor(.orange) +
                                    
                                    Text(" \($category.wrappedValue)")
                                        .font(.title3)
                                        .foregroundColor(.orange)
                                        .baselineOffset(12.0)
                                }
                                
                            }
                            
                            Text("Find the perfect recipe!")
                                .foregroundColor(.gray)
                                .padding(.bottom, 10)
                      
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        if dataManager.recipes.count > 0 {
                            ForEach(dataManager.recipes, id: \.id) { recipe in
                                NavigationLink(destination: DetailView(viewModel: DetailViewModel(recordId: recipe.docid))) {
                                    VStack {
                                        
                                        WebImage(url: URL(string: recipe.imageURL))
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                        
                                        VStack {
                                            Text(recipe.name)
                                                .foregroundColor(.orange)
                                                .padding(.bottom, 1)
                                                .font(.title)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            
                                            HStack {
                                                
                                                Image(systemName: "timer")
                                                Text(String(recipe.time))
                                                
                                                Image(systemName: "hand.thumbsup")
                                                Text(String(recipe.rating))
                                                
                                                Image(systemName: "flame")
                                                Text(recipe.difficulty)
                                                
                                                Image(systemName: "rectangle.stack")
                                                Text(recipe.category)
                                                
                                                Divider()
                                                Text(recipe.username)

                                            }
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .foregroundColor(.black)
                                            .font(.system(size: 14))
                                            .padding(.bottom, 10)

                                        }
                                        .padding(.leading, 10)
                                        
                                    }
                                    .background(Rectangle().fill(Color.white))
                                    //.frame(height: 200)
                                    .cornerRadius(10)
                                    .shadow(radius: 4)
                                }
                                
                            }
                            .padding(.bottom, 20)
                        } else {
                            Text("No recipes has been added yet.")
                                .padding(.top, 20)
                        }
                        
                        
                        Spacer()

                    }
                    .padding()
                    .navigationTitle("")
                    .accentColor(.black)
                    
                }
                
            }
            
        }
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(category: .constant("Dessert"))
    }
}
