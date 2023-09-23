//
//  ProfileView.swift
//  iOS_GroupProject
//
//  Created by Thu Nguyen  on 20/09/2023.
//


import SwiftUI



struct ProfileView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var preferenceViewModel: PreferenceViewModel
    
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
                        
                        // MARK: UPLOAD IMAGE BUTTON
                        //                        if image != nil {
                        //                            Button{
                        //                                userViewModel.uploadImage(image: image)
                        //                            } label: {
                        //                                Text(isUploadingImage ? "Upload" : "")
                        //                            }
                        //                        }
                        
                        if image != nil && !isUploadingImage { // Check if an image is selected and not currently uploading
                            Button(action: {
                                isUploadingImage.toggle()
                                userViewModel.uploadImage(image: image) { success in
                                    // Handle upload completion here if needed
                                    if success {
                                        // Image uploaded successfully, you can handle any additional logic here
                                    }
                                }
                            }) {
                                Text("Upload")
                            }
                        }
                        
                        Text("John Doer")
                            .font(.system(size: 20))
                    }
                    .fullScreenCover(isPresented: $showImagePicker, onDismiss: nil) {
                        ImagePicker(image: $image)
                    }
                    .onAppear {
                        userViewModel.retrieveImage(userId: userViewModel.currentUser?.id ?? "i70k5v1IZoUpqEz41YfiaNtfrk32")
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
                        }
                        
                        // MARK: DARK MODE BUTTON
                        Button {
                            preferenceViewModel.toggleColorScheme()
                        } label: {
                            Image(systemName: preferenceViewModel.colorScheme == .dark ? "sun.max.fill" : "moon.fill")
                                .font(.system(size: 30))
                                .foregroundColor(preferenceViewModel.colorScheme == .dark ? .yellow : .blue)
                        }
                        
                        Text("Name: \(userViewModel.currentUser?.username ?? "username")")
                        Text("Email: \(userViewModel.currentUser?.email ?? "email")")
                        Text("UID: \(userViewModel.currentUser?.id ?? "id")")
                    }
                    .background(Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255))
                }
                .onAppear {
                    // Load values from userViewModel when the view appears
                    name = userViewModel.currentUser?.username ?? ""
                    email = userViewModel.currentUser?.email ?? ""
                    bio = userViewModel.currentUser?.bio ?? ""
                }
                .navigationBarTitle("Profile")
                .navigationBarItems(trailing: Button(action: {
                    // Toggle the editing states
                    isEditingName.toggle()
                    isEditingEmail.toggle()
                    isEditingBio.toggle()
                    userViewModel.updateProfile(name: name, email: email, bio: bio)
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
        ProfileView()
            .environmentObject(UserViewModel())
            .environmentObject(PreferenceViewModel())
            .environmentObject(ReviewViewModel())
    }
    
}



