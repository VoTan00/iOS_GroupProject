/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Group 27
  Created  date: 04/09/2023
  Last modified: 24/09/2023
  Acknowledgement: none
*/


import SwiftUI
import Firebase

struct SignUpView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var reviewViewModal: ReviewViewModel
//    @EnvironmentObject var preferenceViewModel: PreferenceViewModel
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var username: String = ""
    @State private var cpassword: String = ""
    
    @State var isLinkActive = false
    @State var signUpSuccess: Bool = false
    
    // MARK: SIGN UP FUNC
    func signUp()  {
        print("Signup button triggered")
        userViewModel.signUp(email: email, password: password)
        print("uvm called")
        signUpSuccess = true
        print("success true")
    }
    
    var body: some View {
        NavigationView {
            ZStack (alignment: .topLeading){
                VStack {
                    VStack (spacing: 40) {
                        ZStack {
                            Ellipse()
                                .frame(width: 510, height: 478)
                                .padding(.leading, -200)
                                .foregroundColor(Color("Color2"))
                                .padding(.top, -200)
                            Ellipse()
                                .frame(width: 458, height: 420)
                                .padding(.trailing, -500)
                                .foregroundColor(Color("Color3"))
                                .padding(.top, -200)
                            
                            Text("Create\nAccount")
                                .foregroundColor(Color("textColor4"))
                                .font(.system(size: 40))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 20)
                        }
                        VStack (spacing: 20){
                            
                            // MARK: INPUT FIELDS
                            VStack (spacing: 20){
                                UserTextField(placeHolder: "Email", imageName: "envelope", bColor: "textColor1", tOpacity: 0.8, value: $email)
                                UserTextField(placeHolder: "Password", imageName: "lock", bColor: "textColor1", tOpacity: 0.8, value: $password)
                                UserTextField(placeHolder: "Confirm Password", imageName: "lock", bColor: "textColor1", tOpacity: 0.8, value: $cpassword)
                                
                                if cpassword != password {
                                    Text("Password does not match")
                                        .foregroundColor(.red)
                                        .font(.system(size: 20))
                                        .fontWeight(.semibold)
                                }
                            }
                            
                            // MARK: SIGN UP BUTTON
//                            NavigationLink(destination: MainView(), isActive: $signUpSuccess){
                                Button(action: {
                                    userViewModel.signUp(email: email, password: password)
                                }, label: {
                                    UserButton(title: "SIGN UP", bgColor: "Color1", textColor: "textColor3")
                                })
                                .padding(.horizontal, 20)
                                .disabled(email.isEmpty || password.isEmpty || cpassword != password)
                                
//                            }.disabled(email.isEmpty || password.isEmpty || cpassword != password)
                            NavigationLink(destination: LogInView(), isActive: $userViewModel.isSignedUp) {
                                EmptyView()
                            }
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
                                    .foregroundColor(Color("textColor4"))
                                    .fontWeight(.bold)
                            })
                        }
                    }
                    .frame(height: 63)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color("Color2"))
                    .ignoresSafeArea()
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .navigationBarHidden(true)
    }
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        
        SignUpView()
            .environmentObject(UserViewModel())
            .environmentObject(ReviewViewModel())
//            .environmentObject(PreferenceViewModel())
    }
}

