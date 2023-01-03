//
//  WelcomeView.swift
//  Tastier
//
//  Created by WONG HORNG JUN on 27/12/2022.
//

import SwiftUI

struct WelcomeView: View {
    @State var isRegisterLinkActive = false
    @State var isLoginLinkActive = false
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ZStack {
                    
                    //background image
                    Image("bg-image")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                        .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                        .opacity(1.0)
                    
                    //add black background
                    Color.black
                        .ignoresSafeArea()
                        .opacity(0.6)
                    
                    //Text
                    
                    VStack{
                        Text("Bon Appetit")
                            .font(Font.custom(
                                "BilboSwashCaps-Regular",
                                size: 108, relativeTo: .title))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(30)
                        
                        
                        Text("Welcome to \n **Tastier**")
                            .font(.system(size: 36))
                            .fontWeight(.light)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                        
                            VStack{
                                NavigationLink(destination: RegisterView(), isActive: $isRegisterLinkActive) {
                                    Button("Sign Up") {
                                        self.isRegisterLinkActive = true
                                    }
                                    .padding([.top, .bottom], 15)
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(.black)
                                    .background(Color.white)
                                    .cornerRadius(20)
                                    .padding(.bottom, 5)
                                
                                }
                                
                                NavigationLink(destination: LoginView(), isActive: $isLoginLinkActive) {
                                    Button("Login") {
                                        
                                        self.isLoginLinkActive = true
                                    }
                                    .padding([.top, .bottom], 15)
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(.white)
                                    .background(Color.orange)
                                    .cornerRadius(20)
                                }
                            }
                            .navigationBarTitle("", displayMode: .inline)
                            .font(.system(size: 20))
                            .padding(20)
                        
                            
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
