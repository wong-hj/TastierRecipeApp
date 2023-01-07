
import SwiftUI
import SDWebImageSwiftUI

struct ProfileView: View {
    
    @ObservedObject var dataManager = PersonalRecipeViewModel()
    @ObservedObject var auth = AuthViewModel()
    @State private var isShowSheet = false
    @State private var isLoggedOut = false
 
    init(){
        print("THIS IS RUN!")
    }
    
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
                    
                    NavigationLink(destination: EditProfileView(), isActive: $isShowSheet) {
                        Text("")
                    }
 
                }
                
                Image("user")
                    .font(.system(size: 0))
                    .padding()
                    .background(.white)
                    .clipShape(Circle())
                    .overlay(
                            Circle().stroke(.black, lineWidth: 2)
                        )
                    
                Text(auth.user.username.uppercased())
                    .font(.system(size: 25))
                    .fontWeight(.semibold)
                
                
                Text(auth.user.email)
                
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
            
            if dataManager.recipes.count > 0 {
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
                

            } else {
                Text("No recipe has been added yet.")
                    .padding()
            }
            
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
                    .padding(10)
                    .background(.red)
                    .cornerRadius(30)
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
