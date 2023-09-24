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

struct LogInView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var reviewViewModal: ReviewViewModel
    
    @State private var email: String = ""
    @State private var password: String = ""
        
    var body: some View {
        NavigationView {
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
                        .foregroundColor(Color("Color4"))
                }
                // MARK: INPUT FIELDS
                UserTextField(placeHolder: "Email", imageName: "envelope", bColor: "textColor1", tOpacity: 0.6, value: $email)
                
                UserTextField(placeHolder: "Password", imageName: "lock", bColor: "textColor1", tOpacity: 0.6, value: $password)
                
                // MARK: LOGIN BUTTON
                Button(action: {
                    userViewModel.login(email: email, password: password)
                }, label: {
                    UserButton(title: "LOG IN", bgColor: "Color1", textColor: "textColor3")
                })
                
                if userViewModel.isUnlocked {
                    NavigationLink(destination: MainView(), isActive: $userViewModel.isLogedIn) {
                        EmptyView()
                    }
                }
                
                // MARK: SIGN UP BUTTON
                HStack{
                    // MARK: SIGN UP BUTTON
                    HStack{
                        Text("New?")
                        NavigationLink(destination: SignUpView()) {
                            Text("Create An Account").font(.system(size: 20, weight: .semibold))
                            
                        }
                    }
                }
            }.padding()
        }.navigationBarHidden(true)
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
            .environmentObject(UserViewModel())
            .environmentObject(ReviewViewModel())
    }
}
