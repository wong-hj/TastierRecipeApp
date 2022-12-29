//
//  RegisterView.swift
//  Tastier
//
//  Created by WONG HORNG JUN on 27/12/2022.
//

import SwiftUI
import Firebase

struct RegisterView: View {
    
    @State var email = ""
    @State var password = ""
    @State var username = ""
    @State var cfmPassword = ""
    @State var registerSucceed = false
    @State var emptyField = false
    @State var errorAlert = false
    @State var errorText = ""
    //@State var unmatchPass = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
//                        Image("Queen")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 250, height: 250)
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
                        
                        TextField("", text: $cfmPassword)
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
                            emptyField = true
                            
                        } else {
                            // save user data in Firebase
                            registerSucceed = true
                            register()

                        }
                        
                        if(errorText != "") {
                            errorAlert = true
                        }

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
                    .alert(isPresented: $registerSucceed, content: {
                        // Present an alert if registration is successful
                        Alert(title: Text("Success"), message: Text("Registered Successfully!"), dismissButton: .default(Text("OK")))
                    })
                    .alert(isPresented: $errorAlert, content: {
                        // Present an alert if registration is successful
                        Alert(title: Text("Error"), message: Text(errorText), dismissButton: .default(Text("OK")))
                    })
                    
//                    .alert(isPresented: $emptyField, content: {
//                        // Present an alert
//                        Alert(title: Text("Error"), message: Text("Please fill in all fields!"), dismissButton: .default(Text("OK")))
//                    })
                    
                    Group {
                        Spacer()
                        HStack {
                            Text("Already have an account?")

                            // link to proceed to the login page
                            NavigationLink(
                                destination: LoginView(),
                                label: {
                                    Text("Login")
                            })
                        }
                    }
                    

                    
                }
                .padding()
            }
            .navigationTitle("Register")
        }
    }
    
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
