//
//  ProfileView.swift
//  iOS_GroupProject
//
//  Created by Thu Nguyen  on 20/09/2023.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var userViewModel: UserViewModel

  
    @State private var isEditingName = false
    @State private var isEditingEmail = false
    @State private var isEditingBio = false
  
    // Edited values
    @State private var name: String = "John"
    @State private var email: String = "John@gmail.com"
    @State private var bio: String = "John's bio"
  
    var body: some View {
        GeometryReader { g in
            VStack {
                Image("KFC")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .background(Color.yellow)
                    .clipShape(Circle())
                    .padding(.bottom, 10)
                Text("John Doer")
                    .font(.system(size: 20))
  
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
  
                    // Rest of your Form
                }
  
                .background(Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255))
                .navigationBarTitle("Profile")
  
                Button(action: {
                    // Toggle the editing states
                    isEditingName.toggle()
                    isEditingEmail.toggle()
                    isEditingBio.toggle()
                }) {
                    Text(isEditingName || isEditingEmail || isEditingBio ? "Save Changes" : "Edit")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding()
                
                Text("Name: \(userViewModel.currentUser?.username ?? "username")")
                Text("Email: \(userViewModel.currentUser?.email ?? "email")")
                Text("UID: \(userViewModel.currentUser?.id ?? "id")")
                
            }
            .onAppear {
                // Load values from userViewModel when the view appears
                name = userViewModel.currentUser?.username ?? ""
                email = userViewModel.currentUser?.email ?? ""
                bio = userViewModel.currentUser?.bio ?? ""
            }
        }
    }
    
}

struct ProfileView_Previews: PreviewProvider {

  static var previews: some View {
    ProfileView()
      .environmentObject(UserViewModel())
  }

}


 
