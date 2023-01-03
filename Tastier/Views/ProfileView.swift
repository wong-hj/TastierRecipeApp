
import SwiftUI
import SDWebImageSwiftUI

struct ProfileView: View {
    
    @ObservedObject var dataManager = PersonalRecipeViewModel()
    @ObservedObject var auth = AuthViewModel()
    @State var isShowSheet = false
    @State var isLoggedOut = false
    
    var body: some View {
        
        VStack{
            Text("My Profile")
                .font(.largeTitle)
                .foregroundColor(.orange)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            VStack {
                HStack {
                    Spacer()
                    
                   Button(action: {
                       // Code to execute when the button is tapped
                       isShowSheet.toggle()
                       
                   }) {
                       
                       Image(systemName: "pencil")
                           .font(.system(size: 25))
                           .foregroundColor(.black)

                   }
                   .sheet(isPresented: $isShowSheet) {
                       EditProfileView()
                   }
 
                }
                
                Image(systemName: "person")
                    .padding()
                    .background(.blue)
                    .clipShape(Circle())
                Text("June".uppercased())
                    .font(.system(size: 25))
                    .fontWeight(.semibold)
                Text("wonghorngjun@hotmail. com")
            }
            .padding()
            .frame(width: 350)
            .background(.orange)
            .cornerRadius(30)
            .shadow(radius: 5)
            .padding(.bottom, 20)
            
            Text("My Recipes")
                .font(.title2)
                .foregroundColor(.orange)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            List() {
                ForEach(dataManager.recipes, id: \.id) { recipe in
                    
                    HStack{
                        
                        WebImage(url: URL(string: recipe.imageURL))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100)
      
                        Text(recipe.name)
                            .font(.title2)
                            .fontWeight(.light)

                    }
                    .frame(height: 80)
                }
            }
            .listStyle(.plain)
            
            Spacer()
            
            HStack {
                Spacer()
                Button(action: {
                    
                    auth.logout()
                    
                    isLoggedOut = true
                    
                }) {
                    HStack{
                        
                        Text("Logout")
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(.red)
                    .cornerRadius(40)
                    .padding()
                    
                }
                NavigationLink(destination: WelcomeView(), isActive: $isLoggedOut) {
                    Text("")
                }
                
            }
            
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
