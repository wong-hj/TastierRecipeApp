
import SwiftUI
import SDWebImageSwiftUI

struct LandingView: View {
    
    @State var searchText = ""
    @ObservedObject var dataManager = RecipeViewModel()
    @State var categoryIcon = ["dessert", "western", "fried", "beverage", "eastern"]
    @State var isShow = false
    
    init() {
        dataManager.fetchRecipes(category: "All")
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                ZStack {
                    VStack {
                        Rectangle()
                            .fill(.orange)
                            .frame(height: 200)
                            .cornerRadius(20)
                            .edgesIgnoringSafeArea(.top)
                        HStack {
                            ForEach (categoryIcon, id: \.self) {icon in
                                VStack {
                                    NavigationLink(destination: RecipeView(category: .constant(icon.capitalized))) {
                                    
                                        Image(icon)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width:50)
                                                .padding([.top, .bottom], 15)
                                                .padding([.leading, .trailing], 5)
                                                .background(.yellow)
                                                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                                
                                    }
                                    Text(icon.capitalized)
                                        .font(Font.system(size: 14))
                                }
                            }
                        }
                        .padding(.top, -40)
                        .padding(.bottom, 30)
                        
                        VStack() {
                            Text("**Hot Recipes**")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.title)
                                .foregroundColor(.orange)
                            
                            TabView{
                                ForEach(dataManager.recipes, id: \.id) { recipe in
                                    
                                    if recipe.rating > 2.00 {
                                        NavigationLink(destination: DetailView(viewModel: DetailViewModel(recordId: recipe.docid))) {
                                            Group {
                                                
                                                WebImage(url: URL(string: recipe.imageURL))
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                
                                            }
                                            .frame(height: 250)
                                            .overlay(
                                                VStack {
                                                    
                                                    
                                                    Text("***\(recipe.name)***\nBy **\(recipe.username)**")
                                                        .padding()
                                                        .background(.black.opacity(0.8))
                                                        .foregroundColor(.orange)
                                                        .cornerRadius(10)
                                                        .padding()
                                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                                    Spacer()
                                                }
                                                
                                            )
                                        }
                                    }
                                        
                                }
                                
                            }
                            .frame(height:250)
                            .tabViewStyle(.page)
                            .indexViewStyle(.page(backgroundDisplayMode: .always))
                        }
                        .padding()
                        
                        Spacer()
                    }
                    
                    Group {
                        VStack(alignment: .leading) {
                            Text("***Finger Tastin' Good!***")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                            HStack {
                                TextField("Search", text: $searchText)
                                    .autocapitalization(.none)
                                
                                Image(systemName: "magnifyingglass")
                                    .padding(.trailing, 8)
                            }
                            .padding(5)
                            .background(.white)
                            .cornerRadius(10)
                            
                            
                        }
                        .offset(x:0, y: -280)
                        
                        if !searchText.isEmpty {
                            
                            
                            if dataManager.recipes.filter({$0.name.contains(searchText)}).count == 0 {
                                
                                List() {
                                    Text("No Results Found.")
                                }
                                .listStyle(.plain)
                                .frame(height:300)
                                .offset(x:0, y: -90)
                                
                            } else {
                                List(dataManager.recipes.filter{$0.name.contains(searchText)}) { recipe in
                                    
                                    NavigationLink(destination: DetailView(viewModel: DetailViewModel(recordId: recipe.docid))){
                                        HStack {
                                            WebImage(url: URL(string: recipe.imageURL))
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 70)
                                            Divider()
                                            Text(recipe.name)
                                        }
                                    }
                                    
                                    
                                }
                                .listStyle(.plain)
                                .frame(height:300)
                                .offset(x:0, y: -90)
                            }
                            
                        }

                    }
                    .padding()
                }
                
                Spacer()
                
            }
        }

    }

}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
