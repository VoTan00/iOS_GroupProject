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



struct ProfileView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State private var isEditingName = false
    @State private var isEditingEmail = false
    @State private var isEditingBio = false
    @State private var isUploadingImage = false
    // Edited values
    
    @State private var name: String = "John"
    @State private var email: String = "John@gmail.com"
    @State private var bio: String = "John's bio"
    
    @State var showImagePicker = false
    @State var image: UIImage?
    
    var user: User
    
    var body: some View {
        NavigationView {
            GeometryReader { g in
                VStack {
                    VStack {
                        
                        // MARK: CHOOSE IMAGE BUTTON
                        Button {
                            showImagePicker.toggle()
                        } label: {
                            VStack {
                                if let image = self.image {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 64, height: 64)
                                        .cornerRadius(32)
                                } else {
                                    Image(uiImage: userViewModel.im)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 64, height: 64)
                                        .cornerRadius(32)
                                }
                            }
                            .overlay(RoundedRectangle(cornerRadius: 64)
                                .stroke(Color.black, lineWidth: 3))
                        }
                        .shadow(color:Color("Color-black-transparent"), radius: 7)
                        .disabled(!isEditingName)
                        
                        
                        Text(name)
                            .font(.system(size: 20))
                    }
                    .fullScreenCover(isPresented: $showImagePicker, onDismiss: nil) {
                        ImagePicker(image: $image)
                    }
                    .onAppear {
                        userViewModel.retrieveImage(userId: userViewModel.currentUser?.id ?? "JkJacUS1vkV5sQbagw5jQhvfNhD3")
                    }
                    
                    Form {
                        Section(header: Label("Personal Information", systemImage: "person.circle.fill")) {
                            Section(header: Label("Name", systemImage: "person.fill")) {
                                if isEditingName {
                                    TextField("Name", text: $name)
                                } else {
                                    Text(name)
                                }
                            }
                            
                            Section(header: Label("Email", systemImage: "envelope.fill")) {
                                if isEditingEmail {
                                    TextField("Email", text: $email)
                                } else {
                                    Text(email)
                                }
                            }
                            
                            Section(header: Label("Bio", systemImage: "info.circle.fill")) {
                                if isEditingBio {
                                    TextEditor(text: $bio)
                                        .frame(height: 100)
                                } else {
                                    Text(bio)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                            }
                            // MARK: DARK MODE BUTTON
                            HStack(alignment: .center) {
                                Spacer()
                                
                                Button {
                                    userViewModel.isDark.toggle()
                                } label: {
                                    Image(systemName: userViewModel.isDark ? "sun.max.fill" : "moon.fill")
                                        .font(.system(size: 30))
                                        .foregroundColor(userViewModel.isDark ? .yellow : .blue)
                                }
                                
                                Spacer()
                            }
                            HStack(alignment: .center) {
                                Spacer()
                                
                                Button {
                                    userViewModel.logout()
                                } label: {
                                    Text("LOG OUT")
                                        .padding()
                                        .background(Color("Color4"))
                                        .foregroundColor(.white)
                                        .clipShape(Capsule())
                                }
                                .shadow(color:Color("Color-black-transparent"), radius: 7)

                                Spacer()
                            }
                        }
                        
                        
                        
                        
                    }
                    .background(Color("Color2"))
                    
                }
                .onAppear {
                    // Load values from userViewModel when the view appears
                    userViewModel.fetchUser(uid: user.id)
                    name = user.username ?? ""
                    email = user.email
                    bio = user.bio ?? ""
                }
                .navigationBarTitle("Profile")
                .navigationBarItems(trailing: Button(action: {
                    // Toggle the editing states
                    isEditingName.toggle()
                    isEditingEmail.toggle()
                    isEditingBio.toggle()
                    userViewModel.updateProfile(name: name, email: email, bio: bio, img: image ?? UIImage(imageLiteralResourceName: "Logo"))
                    userViewModel.fetchUser(uid: userViewModel.currentUser!.id)
                }) {
                    Image(systemName: isEditingName || isEditingEmail || isEditingBio ? "checkmark.circle.fill" : "pencil.circle.fill")
                        .font(.title)
                        .foregroundColor(.blue)
                })
            }
        }
    }
}



struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: User(id: "JkJacUS1vkV5sQbagw5jQhvfNhD3", email: "Thang2@gmail.com", profileImageUrl: "profile/0C0FE48D-51EE-43B5-8119-170F458CFCB1.jpg", username: "zet", bio: "Love Sleeping"))
            .environmentObject(UserViewModel())
            .environmentObject(ReviewViewModel())
    }
    
}



