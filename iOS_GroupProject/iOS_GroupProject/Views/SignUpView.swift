//
//  SignUpView.swift
//  User Editor
//
//  Created by Tan on 16/09/2023.
//

import SwiftUI
import Firebase

struct SignUpView: View {
//    @ObservedObject var userViewModel : UserViewModel

//    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var username: String = ""
    @State private var profileImage: Image?
    @State private var pickedImage: Image?
    @State private var showingActionSheet = false
    @State private var showingImagePicker = false
    @State private var imageData: Data = Data()
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State var isLinkActive = false
    @State var signUpSuccess: Bool = false
    
    @State private var error: String = ""
    @State private var showingAlert = false
    @State private var alertTitle: String = "Oh No 😭"
    
    // MARK: SIGN UP FUNC
//    func signUp()  {
//        userViewModel.signUp(email: email, password: password)
//        signUpSuccess = true
//    }
    
    func loadImage() {
        guard let inputImage = pickedImage else {
            return
        }
        profileImage = inputImage
    }
    
    func errorCheck() -> String? {
        if email.trimmingCharacters(in: .whitespaces).isEmpty ||
            password.trimmingCharacters(in: .whitespaces).isEmpty ||
            username.trimmingCharacters(in: .whitespaces).isEmpty ||
            imageData.isEmpty{
            return "Please Fill In All Fields And Provide An Image"
        }
        return nil
    }
    
    func clear() {
        self.email = ""
        self.username = ""
        self.password = ""
    }
    
    func signUp() {
        if let error = errorCheck() {
            self.error = error
            self.showingAlert = true
            return
        }
        
        AuthService.signUp(username: username, email: email, password: password, imageData: imageData, onSuccess: {
            (user) in
            self.clear()
        }) {
            (errorMessage) in
            print("Error \(errorMessage)")
            self.error = errorMessage
            self.showingAlert = true
            return
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack (alignment: .topLeading){
                Color("Color1").ignoresSafeArea()
                VStack{
                    VStack(spacing: 40) {
                        ZStack{
                            Ellipse()
                                .frame(width: 458, height: 420)
                                .padding(.trailing, -500)
                                .foregroundColor(Color("Color2"))
                                .padding(.top, -250)
            
                                
                                Text("Sign Up \nTo Start")
                                .foregroundColor(.white)
                                .font(.system(size: 35))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 20)
                                .padding(.top, 10)
                        }
                        VStack {
                            Group {
                                if profileImage != nil {
                                    profileImage!.resizable()
                                        .clipShape(Circle())
                                        .frame(width: 200, height: 200)
                                        .padding(.top, 5)
                                        .onTapGesture{
                                            self.showingActionSheet = true
                                        }
                                } else {
                                    Image(systemName: "person.circle")
                                        .resizable()
                                        .clipShape(Circle())
                                        .frame(width: 100, height: 100)
                                        .foregroundColor(Color("Color2"))
                                        .onTapGesture{
                                            self.showingActionSheet = true
                                        }
                                    Button(action: {}) {
                                        Text("Choose Photo")
                                            .font(.body)
                                            .fontWeight(.bold)
                                            .frame(height:30)
                                            .frame(minWidth: 0, maxWidth: 150)
                                            .foregroundColor(Color("Color1"))
                                            .background(Color("Color2"))
                                            .onTapGesture{
                                                self.showingActionSheet = true
                                            }
                                    }
                                }
                            }
                        }
                        
                        VStack (spacing: 15){
                            UserTextField(placeHolder: "Name", imageName: "person", bColor: "textColor2", tOpacity: 0.8, value: $username)
                            UserTextField(placeHolder: "Email", imageName: "envelope", bColor: "textColor2", tOpacity: 0.8, value: $email)
                            UserTextField(placeHolder: "Password", imageName: "lock", bColor: "textColor2", tOpacity: 0.8, value: $password)
            
                        }
                        
                        Button(action: signUp) {
                            Text("Sign Up")
                                .font(.title)
                                .fontWeight(.bold)
                                .frame(height: 58)
                                .frame(minWidth: 0, maxWidth: 400)
                                .foregroundColor(Color("Color1"))
                                .background(Color("Color2"))
                            
                            
                            
                        }.alert(isPresented: $showingAlert) {
                            Alert(title: Text(alertTitle), message: Text(error), dismissButton: .default(Text("OK")))
                        }
                        
                        //            HStack{
                        //                Text("Got An Account?")
                        //                NavigationLink(destination: SignInView()) {
                        //                    Text("Sign In").font(.system(size: 20, weight: .semibold))
                        //                        .foregroundColor(.black)
                        //                }
                        //            }
                    }.padding()
                }.sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                    ImagePicker2(pickedImage: self.$pickedImage, showImagePicker: self.$showingImagePicker, imageData: self.$imageData)
                }.actionSheet(isPresented: $showingActionSheet) {
                    ActionSheet(title: Text(""), buttons: [.default(Text("Choose A Photo")){
                        self.sourceType = .photoLibrary
                        self.showingImagePicker = true
                    },
                    .default(Text("Take A Photo")){
                        self.sourceType = .camera
                        self.showingImagePicker = true
                                                               
                    }, .cancel()
                                                          ])
                }
            }
            }
            
            }
            
}

//struct SignUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpView()
//    }
//}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
//        let userViewModel = UserViewModel()
        
        return SignUpView()
    }
}

