
import SwiftUI
import Firebase

struct RecipeView: View {
    @EnvironmentObject var dataManager: RecipeViewModel
 
    var body: some View {
        
        
        NavigationView {
            ScrollView {
                ZStack {
                    VStack {
                        
                        Group{
                            Text("Recipes")
                                .font(.largeTitle)
                                .foregroundColor(.orange)
                            Text("Find the perfect recipe!")
                                .foregroundColor(.gray)
                                .padding(.bottom, 10)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ForEach(dataManager.recipes, id: \.id) { recipe in
                            NavigationLink(destination: DetailView(viewModel: DetailViewModel(recordId: recipe.docid))) {
                                VStack {
                                    Image("avocado")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                    
                                    VStack() {
                                        Text(recipe.name)
                                            .foregroundColor(.orange)
                                            .padding(.bottom, 1)
                                            .font(.title)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        
                                        HStack() {
                                            
                                            Image(systemName: "timer")
                                            Text(String(recipe.time))
                                            
                                            Image(systemName: "hand.thumbsup")
                                            Text(String(recipe.rating))
                                            
                                            Image(systemName: "flame")
                                            Text(recipe.difficulty)
                                            
                                            Image(systemName: "rectangle.stack")
                                            Text(recipe.category)
                                            
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .foregroundColor(.black)
                                        .font(.system(size: 14))
                                        .padding(.bottom, 10)

                                    }
                                    .padding(.leading, 10)
                                    
                                }
                                .background(Rectangle().fill(Color.white))
                                .cornerRadius(10)
                                .shadow(radius: 4)
                            }
                            
                        }
                        .padding(.bottom, 20)
                        
                        Spacer()
                        
                        
                    }
                    .padding()
                    .navigationTitle("Recipes")
                    .navigationBarHidden(true)
                }
            }

        }

    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView()
            .environmentObject(RecipeViewModel())
    }
}
