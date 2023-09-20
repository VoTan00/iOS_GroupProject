//
//  SignUpView.swift
//  User Editor
//
//  Created by Tan on 16/09/2023.
//

import SwiftUI
import Firebase

struct SignUpView: View {
    @State private var name: String = ""
    @State private var password: String = ""
    @State private var email: String = ""
    @State private var cpassword: String = ""
    @State var isLinkActive = false
    @State var signUpSuccess: Bool = false
    
    func signUp() {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error != nil {
                print(error?.localizedDescription ?? "")
                signUpSuccess = false
            } else {
                print("success")
                signUpSuccess = true
            }
        }
    }
    
    
    var body: some View {
        NavigationView {
            ZStack (alignment: .topLeading){
                Color("Color1").ignoresSafeArea()
                VStack {
                    VStack (spacing: 40) {
                        ZStack {
                            Ellipse()
                                .frame(width: 458, height: 420)
                                .padding(.trailing, -500)
                                .foregroundColor(Color("Color2"))
                                .padding(.top, -200)
                            
                            Text("Create \nAccount")
                                .foregroundColor(.white)
                                .font(.system(size: 35))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 20)
                                .padding(.top, 100)
                        }
                        VStack (spacing: 20){
                            
                            // MARK: INPUT FIELDS
                            VStack (spacing: 20){
                                UserTextField(placeHolder: "Name", imageName: "person", bColor: "textColor2", tOpacity: 0.8, value: $name)
                                UserTextField(placeHolder: "Email", imageName: "envelope", bColor: "textColor2", tOpacity: 0.8, value: $email)
                                UserTextField(placeHolder: "Password", imageName: "lock", bColor: "textColor2", tOpacity: 0.8, value: $password)
                                UserTextField(placeHolder: "Confirm Password", imageName: "lock", bColor: "textColor2", tOpacity: 0.8, value: $cpassword)
                                
                                if cpassword != password {
                                    Text("Password does not match")
                                        .foregroundColor(.red)
                                        .font(.system(size: 20))
                                        .fontWeight(.semibold)
                                }
                            }
                            
                            // MARK: SIGN UP BUTTON
                            NavigationLink(destination: MainView(), isActive: $signUpSuccess){
                                Button(action: {
                                    signUp()
                                }, label: {
                                    UserButton(title: "SIGN UP", bgColor: "Color2", textColor: "textColor1")
                                })
                                .padding(.horizontal, 20)
                                .disabled(email.isEmpty || password.isEmpty)
                            }
                            
                            // if sign up success, display welcome + name
                            if signUpSuccess {
                                Text("Welcome \(name)")
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
                    
                    // MARK: LOG IN
                    HStack {
                        Text("Already have an account?")
                            .fontWeight(.bold)
                            .foregroundColor(Color("textColor1"))
                            .font(.system(size: 18))
                        NavigationLink(destination: LogInView(), isActive: $isLinkActive){
                            Button(action: {
                                self.isLinkActive = true
                            }, label: {
                                Text("LOG IN")
                                    .font(.system(size:18))
                                    .foregroundColor(Color("Color1"))
                                    .fontWeight(.bold)
                            })
                        }
                    }
                    .frame(height: 63)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color("Color2"))
                    .ignoresSafeArea()
                }
                //                TopBarView()
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .navigationBarHidden(true)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
