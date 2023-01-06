
import SwiftUI
import SDWebImageSwiftUI

struct PersonalRecipeView: View {
    @ObservedObject var dataManager = PersonalRecipeViewModel()
    
    @State private var deleteAlert = false
    
    var body: some View {
        NavigationView{
            VStack{
                Group{
                    Text("Personal Recipes")
                        .font(.largeTitle)
                        .foregroundColor(.orange)
                    
                    Text("Click to Edit, Left Swipe to Delete")
                        .foregroundColor(.gray)
                        .padding(.bottom, 10)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                // if there are recipes then create a list
                if dataManager.recipes.count > 0 {
                    
                    List {
                        // For each recipe run the following code
                        ForEach(dataManager.recipes, id: \.id) { recipe in
                            
                            ZStack {
                                //navigate to UpdateRecipeView if the list is clicked
                                NavigationLink(destination: UpdateRecipeView(dataManager: UpdateRecipeViewModel(documentid: recipe.docid))) {
                                    EmptyView()
                                    
                                }.opacity(0)
                                
                                HStack{
                                    
                                    //Show image and other relevant details
                                    WebImage(url: URL(string: recipe.imageURL))
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 100)
                                    
                                    VStack(alignment: .leading) {
                                        
                                        Text(recipe.name)
                                            .font(.title2)
                                            .fontWeight(.light)
                                        HStack(){
                                            Group {
                                                HStack{
                                                    Image(systemName: "hand.thumbsup")
                                                    Text(String(recipe.rating))
                                                }
                                                .padding(3)
                                                .frame(width: 75)
                                                .background(Rectangle().fill(.orange))
                                                .cornerRadius(5)
                                                
                                                Spacer()
                                                
                                                HStack{
                                                    Image(systemName: "timer")
                                                    Text("\(String(recipe.time)) min")
                                                }
                                                .padding(3)
                                                .frame(width: 75)
                                                .background(Rectangle().fill(.orange))
                                                .cornerRadius(5)
                                                
                                                Spacer()
                                                
                                                HStack{
                                                    Image(systemName: "flame")
                                                    Text(recipe.difficulty)
                                                }
                                                .padding(3)
                                                
                                                .frame(width: 75)
                                                .background(Rectangle().fill(.orange))
                                                .cornerRadius(5)
                                            }
                                            .foregroundColor(.white)
                                            .font(.system(size: 13))
                                            
                                        }
                                    }
                                }
                                .frame(height: 80)
                                // if user left swipe
                                .swipeActions(edge: .trailing) {
                                    //action button to delete recipe and set deleteAlert boolean to true
                                    Button(action: {
                                        dataManager.deleteRecipe(documentID: recipe.docid)
                                        deleteAlert = true
                                    }, label: {
                                        Image(systemName: "trash")
                                    })
                                    .tint(.red)
                                    
                                }
                                //alert to show delete success.
                                .alert(isPresented: $deleteAlert, content: {
                                    Alert(title: Text("Success"), message: Text("Recipe has been successfully deleted."), dismissButton: .default(Text("OK")))
                                })

                            }
                        }
                    }
                    .listStyle(.plain)
                    
                } else {
                    List {
                        Text("No recipe has been added yet.")
                    }
                    .listStyle(.plain)
                }
                
                
                Spacer()
                
            }
            .padding()
        
        }
    }
}

struct PersonalRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalRecipeView()
    }
}
