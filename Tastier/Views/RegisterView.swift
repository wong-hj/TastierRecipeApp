
import SwiftUI
import Firebase

struct RegisterView: View {
    @ObservedObject var dataManager = RegisterViewModel()
    
    @State private var email = ""
    @State private var password = ""
    @State private var username = ""
    @State private var cfmPassword = ""
    @State private var registerSucceed = false
    @State private var emptyField = false
    @State private var errorAlert = false
    @State private var errorText = ""
    @State private var activeAlert: RegisterAlert = .success
    @State private var showAlert = false
    @State private var toContentView = false
    
    var body: some View {
        ZStack {
            VStack {
                Group {
                    Text("**Register**")
                        .font(.largeTitle)
                        .padding(.bottom, 5)
                    
                    Text("Fill in the Fields with Relevant Details.")
                        .foregroundColor(.gray)
                        .padding(.bottom, 10)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                
                Group{
                    Text("Username")
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    TextField("", text: $username)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding(8)
                        .background()
                        .foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.orange, lineWidth: 2)
                        )
                    
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
                    
                    Text("Confirm Password")
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    SecureField("", text: $cfmPassword)
                        .padding(8)
                        .background()
                        .foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.orange, lineWidth: 2)
                        )
                }
                
                 //button confirming if user entered all fields or not
                Button(action: {
                    
                    if (username.isEmpty || email.isEmpty || password.isEmpty || cfmPassword.isEmpty) {
                        
                        activeAlert = RegisterAlert.empty
                        
                    } else if (password != cfmPassword) {
                        
                        activeAlert = RegisterAlert.unmatch
                    } else {
                        // save user data in Firebase
                        
                        register()

                    }
                    
                    showAlert = true
                    

                }, label: {
                    
                    HStack{
                        Text("Sign Up")
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
                    // Present an alert if registration is successful
                    switch activeAlert {
                        
                        
                        case RegisterAlert.unmatch:
                            return Alert(title: Text("Error"), message: Text("Password Do Not Match."), dismissButton: .default(Text("OK")))
                        
                        case RegisterAlert.error:
                            return Alert(title: Text("Error"), message: Text(errorText), dismissButton: .default(Text("OK")))
                        
                        case RegisterAlert.success:
                            return Alert(title: Text("Success"), message: Text("Registered Successfully!"), dismissButton: .default(Text("OK")))
                        
                        case RegisterAlert.empty:
                            return Alert(title: Text("Error"), message: Text("Please fill in all fields."), dismissButton: .default(Text("OK")))

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
        
    }
    
    func register() {
        
        //Create a user with email and password, save in Firebase Auth
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            
            //if there is error with sign up
            if let error = error {
                //set alert status to error
                self.activeAlert = RegisterAlert.error
                //save error text to errorText
                self.errorText = "\(error.localizedDescription)"
                
                
            } else {
                //set alert status to success
                self.activeAlert = RegisterAlert.success
                //set toContentView boolean to true for navigation
                self.toContentView = true
                
                //get current user id
                let uid = Auth.auth().currentUser?.uid
                
                //save data into Firestore
                dataManager.addUser(email: email, uid: uid!, username: username)
                
                
            }

        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
