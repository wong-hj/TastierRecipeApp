
import SwiftUI
import SDWebImageSwiftUI

struct LandingView: View {
    
    @State private var searchText = ""
    @ObservedObject var dataManager = RecipeViewModel()
    @State private var categoryIcon = ["dessert", "western", "fried", "beverage", "eastern"]
    @State private var isShow = false
    
    init() {
        dataManager.fetchRecipes(category: "All")
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                ZStack {
                    VStack {
                        //Orange background
                        Rectangle()
                            .fill(.orange)
                            .frame(height: 200)
                            .cornerRadius(20)
                            .edgesIgnoringSafeArea(.top)
                        
                        //Hortizontally arrange the available categories
                        HStack {
                            //ForEach categories, execute the following code
                            ForEach (Categories.allCases, id: \.self) {icon in
                                //Vertically show the category icon and the name
                                VStack {
                                    NavigationLink(destination: RecipeView(category: .constant(icon.rawValue.capitalized))) {
                                    
                                        Image(icon.rawValue)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width:50)
                                                .padding([.top, .bottom], 15)
                                                .padding([.leading, .trailing], 5)
                                                .background(.yellow)
                                                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                                
                                    }
                                    Text(icon.rawValue.capitalized)
                                        .font(Font.system(size: 14))
                                }
                            }
                        }
                        .padding(.top, -40)
                        .padding(.bottom, 30)
                        
                        VStack {
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
                    
                    //On top of the screen
                    Group {
                        VStack(alignment: .leading) {
                            //Slogan
                            Text("***Finger Tastin' Good!***")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                            //Search bar
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
                            
                            //Show list of search result
                            
                            //if filtered result return 0
                            if dataManager.recipes.filter({$0.name.lowercased().contains(searchText.lowercased())}).count == 0 {
                                
                                List() {
                                    Text("No Results Found.")
                                }
                                .listStyle(.plain)
                                .frame(height:300)
                                .offset(x:0, y: -90)
                                
                            } else {
                                List(dataManager.recipes.filter{$0.name.lowercased().contains(searchText.lowercased())}) { recipe in
                                    
                                    //show filtered recipes with images and name, click to navigate to detail view of the selected recipe
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
