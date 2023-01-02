
import SwiftUI
import SDWebImageSwiftUI

struct PersonalRecipeView: View {
    @ObservedObject var dataManager = PersonalRecipeViewModel()
    
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
                
                List {
                    
                    ForEach(dataManager.recipes, id: \.id) { recipe in
                        
                        ZStack {
                            NavigationLink(destination: UpdateRecipeView(dataManager: UpdateRecipeViewModel(documentid: recipe.docid))) { EmptyView() }.opacity(0)
                            
                            HStack{
                                
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
                            .swipeActions(edge: .trailing) {
                                Button {
                                    dataManager.deleteRecipe(documentID: recipe.docid)
                                } label: {
                                    Image(systemName: "trash")
                                }
                                .tint(.red)
                                
                            }
                        }
                    }
                }
                .listStyle(.plain)
                
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
