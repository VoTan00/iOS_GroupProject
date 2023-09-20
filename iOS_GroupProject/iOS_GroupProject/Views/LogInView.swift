//
//  LogInView.swift
//  iOS_GroupProject
//
//  Created by Tan on 15/09/2023.
//

import SwiftUI
import Firebase

struct LogInView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State var isLinkActive = false
    @State var loginSuccess = false
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
                loginSuccess = false
            } else {
                print("success")
                loginSuccess = true
            }
        }
    }
    
    
    var body: some View {
        NavigationView{
            ZStack (alignment: .topLeading){
                VStack {
                    VStack (spacing: 40) {
                        ZStack {
                            
                            Ellipse()
                                .frame(width: 510, height: 478)
                                .padding(.leading, -200)
                                .foregroundColor(Color("Color1"))
                                .padding(.top, -200)
                            Ellipse()
                                .frame(width: 458, height: 420)
                                .padding(.trailing, -500)
                                .foregroundColor(Color("Color2"))
                                .padding(.top, -200)
                            
                            Text("Welcome \nBack")
                                .foregroundColor(.white)
                                .font(.system(size: 35))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 20)
                        }
                        VStack (spacing: 30){
                            //MARK: INPUT FIELDS
                            VStack (spacing: 30){
                                UserTextField(placeHolder: "Email", imageName: "envelope", bColor: "textColor1", tOpacity: 0.6, value: $email)
                                UserTextField(placeHolder: "Password", imageName: "lock", bColor: "textColor1", tOpacity: 0.6, value: $password)
                            }
                            
                            VStack (alignment: .trailing){
                                //                                Text("Forgot Password")
                                //                                    .fontWeight(.medium)
                                
                                // MARK: LOG IN BUTTON
                                NavigationLink(destination: MainView(), isActive: $loginSuccess){
                                    Button(action: {
                                        login()
                                    }, label: {
                                        UserButton(title: "LOG IN", bgColor: "Color1", textColor: "textColor2")
                                    })
                                    .disabled(email.isEmpty || password.isEmpty)
                                }
                            }.padding(.horizontal, 20)
                            
                            // if login success display welcome back
                            if loginSuccess {
                                Text("Welcome Back")
                                    .foregroundColor(.red)
                                    .font(.system(size: 20))
                                    .fontWeight(.semibold)
                            }
                            
                            //                            HStack {
                            //                                Button(action: {}, label:  {
                            //                                    Image("fb")
                            //                                        .resizable()
                            //                                        .frame(width: 30, height: 30)
                            //                                        .padding(.horizontal,60)
                            //                                        .padding(.vertical,15)
                            //                                        .background(Color("button-bg"))
                            //                                        .cornerRadius(15)
                            //                                })
                            //
                            //                                Spacer()
                            //                                Button(action: {}, label:  {
                            //                                    Image("google")
                            //                                        .resizable()
                            //                                        .frame(width: 30, height: 30)
                            //                                        .padding(.horizontal,60)
                            //                                        .padding(.vertical,15)
                            //                                        .background(Color("button-bg"))
                            //                                        .cornerRadius(15)
                            //                                })
                            //                            }
                            //                            .padding(.horizontal, 20)
                        }
                    }
                    
                    Spacer()
                    
                    // MARK: SIGN UP
                    HStack {
                        Text("Don't have an account?")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .font(.system(size: 18))
                        
                        NavigationLink(destination: SignUpView(), isActive: $isLinkActive){
                            Button(action: {
                                self.isLinkActive = true
                            }, label: {
                                Text("SIGN UP")
                                    .font(.system(size:18))
                                    .foregroundColor(Color("Color2"))
                                    .fontWeight(.bold)
                            })
                        }
                    }
                    .frame(height: 63)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color("Color1"))
                    .ignoresSafeArea()
                }
                //                TopBarView()
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .navigationBarHidden(true)
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
