//
//  LogInView.swift
//  iOS_GroupProject
//
//  Created by Tan on 15/09/2023.
//

import SwiftUI
import Firebase

struct LogInView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var error: String = ""
    @State private var showingAlert = false
    @State private var alertTitle: String = "Oh No 😭"
    
    @State var isLinkActive = false
    @State var loginSuccess = false
    
    //     MARK: LOG IN FUNC
    func login()  {
        userViewModel.login(email: email, password: password)
        loginSuccess = true
    }
    
    var body: some View {
        NavigationView {
            ZStack {
//                Color("textColor2")
//                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 20) {
                    ZStack {
                        Ellipse()
                            .frame(width: 510, height: 478)
                            .padding(.leading, -200)
                            .foregroundColor(Color("Color1"))
                            .padding(.top, -200)
                        Ellipse()
                            .frame(width: 458, height: 420)
                            .padding(.trailing, -500)
                            .foregroundColor(Color("Color3"))
                            .padding(.top, -200)
                        
                        Text("Welcome \nBack")
                            .foregroundColor(Color("textColor3"))
                            .font(.system(size: 35))
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 20)
                    }
                    VStack(alignment: .leading) {
                        Text("Sign In To Continue").font(.system(size: 32, weight: .medium))
                            .padding(40)
                            .foregroundColor(Color("textColor4"))
                    }
                    // MARK: INPUT FIELDS
                    UserTextField(placeHolder: "Email", imageName: "envelope", bColor: "textColor1", tOpacity: 0.6, value: $email)
                    
                    UserTextField(placeHolder: "Password", imageName: "lock", bColor: "textColor1", tOpacity: 0.6, value: $password)
                    
                    // MARK: LOGIN BUTTON
                    NavigationLink(destination: MainView(), isActive: $loginSuccess){
                        Button(action: {
                            login()
                        }, label: {
                            Text("Log In").font(.title)
                                .fontWeight(.bold)
                                .frame(height: 58)
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .foregroundColor(Color("textColor3"))
                                .background(Color("Color1"))
                        })
                    }.disabled(email.isEmpty || password.isEmpty)
                    
                    // MARK: SIGN UP BUTTON
                    HStack{
                        Text("New?")
                        NavigationLink(destination: SignUpView()) {
                            Text("Create An Account").font(.system(size: 20, weight: .semibold))
                            
                        }
                    }
                }.padding()
            }
        }.navigationBarHidden(true)
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
            .environmentObject(UserViewModel())
    }
}
