//
//  ProfileView.swift
//  iOS_GroupProject
//
//  Created by Thu Nguyen  on 20/09/2023.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var userViewModel : UserViewModel
    
    var body: some View {
        VStack {
            Text("Name: \(userViewModel.currentUser?.username ?? "username")")
            Text("Email: \(userViewModel.currentUser?.email ?? "email")")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {

  static var previews: some View {
    ProfileView()
      .environmentObject(UserViewModel())
  }

}
