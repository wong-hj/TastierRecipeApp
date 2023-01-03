
import SwiftUI

struct EditProfileView: View {
    @ObservedObject var dataManager = EditProfileViewModel()
    @ObservedObject var auth = AuthViewModel()
    @Environment(\.dismiss) var dismiss
    @State var username = ""
    @State var email = ""
    @State var password = ""
    @State var activeAlert = ""
    @State var showAlert = false
    
    var body: some View {
        VStack{
            Text("Edit Profile")
                .font(.largeTitle)
                .foregroundColor(.orange)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 20)
            
            Group{
                
                Text("Username")
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                TextField("", text: $auth.user.username)
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
                
                TextField("", text: $auth.user.email)
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
                
                //edit in firestore
                if (auth.user.username.isEmpty || auth.user.email.isEmpty) {
                    
                    if (password.isEmpty) {
                        activeAlert = "empty"
                    }

                } else {
                    
                    activeAlert = "submit"
                      
                    dataManager.editUser(email: auth.user.email, username: auth.user.username, password: password)
                    
                }
                
                showAlert = true
            
                
                
            }, label: {
                
                HStack{
                    Text("Update")
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
                    
                    case "submit":
                    return Alert(title: Text("Success"), message: Text("Successfully updated your profile!"), dismissButton: .default(Text("OK")) {
                        dismiss()
                    })
                        
                    
                default:
                
                    return Alert(title: Text("Error"), message: Text("Something went wrong."), dismissButton: .default(Text("OK")))
                }
            })
            
            Spacer()
            
        }
        .padding()
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
