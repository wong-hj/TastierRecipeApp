
import SwiftUI
import Firebase

struct RegisterView: View {
    @ObservedObject var dataManager = RegisterViewModel()
    
    @State var email = ""
    @State var password = ""
    @State var username = ""
    @State var cfmPassword = ""
    @State var registerSucceed = false
    @State var emptyField = false
    @State var errorAlert = false
    @State var errorText = ""
    @State var activeAlert = ""
    @State var showAlert = false
    
    //@State var unmatchPass = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Text("Fill in the Fields with Relevant Details.")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 10)
                    
                    Group{
                        Text("Username")
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        TextField("", text: $username)
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
                            
                            activeAlert = "empty"
                            
                        } else if (password != cfmPassword) {
                            
                            activeAlert = "unmatch"
                        } else {
                            // save user data in Firebase
                            
                            register()
                            
                            if self.errorText.isEmpty {
                                activeAlert = "success"
                                
                            } else {
                                activeAlert = "error"
                            }

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
                            case "empty":
                                return Alert(title: Text("Error"), message: Text("Please fill in all fields."), dismissButton: .default(Text("OK")))
                            
                            case "unmatch":
                                return Alert(title: Text("Error"), message: Text("Password Do Not Match."), dismissButton: .default(Text("OK")))
                            
                            case "error":
                                return Alert(title: Text("Error"), message: Text(errorText), dismissButton: .default(Text("OK")))
                            
                            case "success":
                                return Alert(title: Text("Success"), message: Text("Registered Successfully!"), dismissButton: .default(Text("OK")))

                            default:
                        
                                return Alert(title: Text("Error"), message: Text("Something went wrong."), dismissButton: .default(Text("OK")))
                        }
                    })

                    Spacer()

                    
                }
                .padding()
            }
            .navigationTitle("Register")
        }
    }
    
    //Register function ***LOOK MORE INTO IT*** can put into registerviewmodel
    func register() {
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            
            if let error = error {
                
                errorText = error.localizedDescription
                
                
            } else {
                
                let uid = Auth.auth().currentUser?.uid
                
            
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
