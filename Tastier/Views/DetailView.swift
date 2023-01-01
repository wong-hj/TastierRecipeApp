
import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct DetailView: View {
    
    @EnvironmentObject var dataManager: DetailViewModel
    @ObservedObject var viewModel: DetailViewModel
    
    //var recordId: String
    
    var body: some View {
        
        GeometryReader { geo in
            
            let image = UIImage(named: "avocado")
            let imageHeight = image!.size.height
            let imageWidth = image!.size.width
            //let width = geo.size.width
            let height = geo.size.width * (imageHeight / imageWidth)
            
            let ingredients = viewModel.recipe.ingredient
            let ingredientsArr = ingredients.components(separatedBy: ",")
            
            let steps = viewModel.recipe.step
            let stepsArr = steps.components(separatedBy: ",")
            
            NavigationView {
                ScrollView(showsIndicators: false) {
                    ZStack(){
                        VStack(alignment: .leading){
                            WebImage(url: URL(string: viewModel.recipe.imageURL))
                                .resizable()
                                .frame(height: height)
                                .scaledToFill()
                                .aspectRatio(contentMode: .fit)
                            //.frame(height: height)
                                //.edgesIgnoringSafeArea(.all)
                                .overlay(cardOverlay())
                            
                            
                            VStack(alignment: .leading) {
                                Section {
                                    Text("Ingredients")
                                        .font(.title)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.orange)
                                        .padding(.bottom, 10)
                                    
                                    ForEach(ingredientsArr, id: \.self) { item in
                                        Group{
                                            
                                            Text("• ").foregroundColor(.yellow).fontWeight(.bold).font(.title2) + Text(item)
                                        }
                                        .padding(.bottom, 1)
                                        .listRowSeparator(.hidden)
                                    }
                                    
                                    Text("")
                                        .padding(.bottom, 5)
                                }
                                
                                Section {
                                    Text("Steps")
                                        .font(.title)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.orange)
                                        .padding(.bottom, 10)
                                    
                                    ForEach(stepsArr.indices, id: \.self) { index in
                                        Group{
                                            
                                            Text("\(index + 1). ").foregroundColor(.yellow).fontWeight(.semibold) + Text(stepsArr[index].capitalized)
                                        }
                                        .padding(.bottom, 1)
                                        .listRowSeparator(.hidden)
                                    }
                                    
                                    Text("")
                                        .padding(.bottom, 20)
                                }
                                
                            }
                            .padding()
                            .offset(x:0, y:40)
   
                            Spacer()
                            
                        }
                    
                        
                        
                    }
                }
                
                .edgesIgnoringSafeArea(.all)
                    
                //}
                .navigationTitle("Recipe Detail")
                .navigationBarHidden(true)
                
                //.navigationBarBackButtonHidden(true)
        
            }
            //.navigationBarBackButtonHidden(true)
        }
        
        
        
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
