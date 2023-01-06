
import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct DetailView: View {
    
    @EnvironmentObject var dataManager: DetailViewModel
    @ObservedObject var viewModel: DetailViewModel
    
    var body: some View {
        
        let ingredients = viewModel.recipe.ingredient
        let ingredientsArr = ingredients.components(separatedBy: ";")
        
        let steps = viewModel.recipe.step
        let stepsArr = steps.components(separatedBy: ";")
        
        //NavigationView {
            ScrollView {
                ZStack{
                    VStack(alignment: .leading){
                        WebImage(url: URL(string: viewModel.recipe.imageURL))
                            .resizable()
                            .frame(height: 300)
                            .aspectRatio(contentMode: .fit)
                            .overlay(cardOverlay())
                        
                        
                        VStack(alignment: .leading) {
                            Section {
                                Text("Ingredients")
                                    .font(.title)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.orange)
                                    .padding(.bottom, 10)
                                
                                ForEach(ingredientsArr, id: \.self) { item in
                                    
                                    let itemTrim = item.trimmingCharacters(in: .whitespacesAndNewlines)
                                    
                                    Group{
                                        
                                        Text("• ").foregroundColor(.yellow).fontWeight(.bold).font(.title2) + Text(itemTrim)
                                    }
                                    .padding(.bottom, 1)
                                    .listRowSeparator(.hidden)
                                }
                                
                                Text("")
                                    .padding(.bottom, 5)
                            }
                            
                            Section {
                                Text("Directions")
                                    .font(.title)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.orange)
                                    .padding(.bottom, 10)
                                
                                ForEach(stepsArr.indices, id: \.self) { index in
                                    
                                    let stepTrim = stepsArr[index].trimmingCharacters(in: .whitespacesAndNewlines)
                                    Text("Step \(index + 1)")
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .padding(.bottom, 5)
                                       
                                    Text(stepTrim.capitalized)
                                    
                                    .padding(.bottom, 1)
                                    .listRowSeparator(.hidden)
                                }
                                
                                Text("")
                                    .padding(.top, 100)
                            }
                            
                        }
                        .padding()
                        .padding(.top, 60)

                        Spacer()
                        
                    }
                
                    
                    
                }
            }
            .edgesIgnoringSafeArea(.all)
    
    }
    
    
    
    func cardOverlay() -> some View {
        
        VStack(alignment: .leading){
            VStack(alignment: .leading) {
                Text(viewModel.recipe.name)
                    .font(.title)
                    .fontWeight(.bold)
                Text("By **\(viewModel.recipe.username)**")
                    
                    .padding(.bottom, 1)
            }
            .foregroundColor(.white)
            
            HStack(){
                HStack{
                    Image(systemName: "hand.thumbsup")
                    Text(String(viewModel.recipe.rating))
                }
                .padding(5)
                
                .frame(width: 80)
                .background(Rectangle().fill(.white))
                .cornerRadius(5)
                
                Spacer()
                
                HStack{
                    Image(systemName: "timer")
                    Text("\(String(viewModel.recipe.time)) min")
                }
                .padding(5)
                .frame(width: 100)
                .background(Rectangle().fill(.white))
                .cornerRadius(5)
                
                Spacer()
                
                HStack{
                    Image(systemName: "flame")
                    Text(viewModel.recipe.difficulty)
                }
                .padding(5)
                
                .frame(width: 100)
                .background(Rectangle().fill(.white))
                .cornerRadius(5)
            }
            
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(width: 350)
        .background(Rectangle().fill(.orange))
        .cornerRadius(10)
        .shadow(radius: 4)
        .offset(x:0, y: 140)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(viewModel: DetailViewModel(recordId: "ydh6xKli3hFlH3jY8C4D"))
            
    }
}
