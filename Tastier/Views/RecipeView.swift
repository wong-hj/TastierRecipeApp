
import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct RecipeView: View {
    @ObservedObject var dataManager = RecipeViewModel()
    @State var toAddRecipeView = false
    @Binding var category: String
    
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
                                Text("Recipes")
                                    .font(.largeTitle)
                                    .foregroundColor(.orange)
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
                                
                            }
                            
                            Text("Find the perfect recipe!")
                                .foregroundColor(.gray)
                                .padding(.bottom, 10)
                      
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
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
