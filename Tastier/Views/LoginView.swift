
import SwiftUI
import Firebase

struct LoginView: View {
  
    @State var email = ""
    @State var password = ""
    @State var toContentView = false
    
    var body: some View {
        
        VStack {
            
            Image("vege")
                .resizable()
                .scaledToFit()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .clipShape(Circle())
                .offset(x: 150, y: -30)
            
            Group {
                Text("Welcome to Tastier.")
                    .foregroundColor(.gray)
                    .fontWeight(.light)
                Text("**Login**")
                    .font(.largeTitle)
                    .padding(.bottom, 10)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Group{
                
                Text("Email")
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                TextField("", text: $email)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(8)
                    .background()
                    .foregroundColor(.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.orange, lineWidth: 2)
                    )
                
                Text("Password")
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                SecureField("", text: $password)
                    .padding(8)
                    .background()
                    .foregroundColor(.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.orange, lineWidth: 2)
                    )
            }
            
            Button(action: {
                login()
                
            }, label: {
                
                HStack{
                    Text("Login")
                    Image(systemName: "arrow.right")
                }
                .padding(10)
                .background(.yellow)
                .foregroundColor(.black)
                .cornerRadius(20)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.top, 10)
                
            })
            
            
             //To Content View
            NavigationLink(
                destination: ContentView(),
                isActive: $toContentView) {
                EmptyView()
            }
            
            Spacer()
            
        }
        .padding()
    }

    
    //login function
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                print("Success")
                toContentView = true
                
            }
        }
    }
    
}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
