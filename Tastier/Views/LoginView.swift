
import SwiftUI
import Firebase

struct LoginView: View {
  
    @State private var email = ""
    @State private var password = ""
    @State private var toContentView = false
    @State private var activeAlert: LoginAlert = .success
    @State private var showAlert = false
    
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
                if (email.isEmpty || password.isEmpty) {
                    
                    activeAlert = LoginAlert.empty
                    
                } else {
                    
                    login()
                }
                
                showAlert = true
                
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
            .alert(isPresented: $showAlert, content: {
                // Present an alert if login is successful
                switch activeAlert {
                    case LoginAlert.empty:
                        return Alert(title: Text("Error"), message: Text("Please fill in all fields."), dismissButton: .default(Text("OK")))
                    
                    case LoginAlert.success:
                        return Alert(title: Text("Success"), message: Text("Successfully Login.\nWelcome to Tastier!"), dismissButton: .default(Text("OK")))
                
                    case LoginAlert.error:
                        return Alert(title: Text("Error"), message: Text("Email or Password is incorrect."), dismissButton: .default(Text("OK")))

                }
                
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
        //Signin by checking the email and password in Firebase Auth
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            // if error
            if let error = error {
                //indicates error for alert
                activeAlert = LoginAlert.error
                //show error in console
                print(error.localizedDescription)
                
            } else {
                //indicates success for alert
                activeAlert = LoginAlert.success
                
                //set toContentView boolean to true
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
