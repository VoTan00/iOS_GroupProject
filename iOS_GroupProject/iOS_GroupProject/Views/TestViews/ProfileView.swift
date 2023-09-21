//
//  ProfileView.swift
//  iOS_GroupProject
//
//  Created by Thu Nguyen  on 20/09/2023.
//

import SwiftUI

struct ProfileView: View {
//    @ObservedObject var userViewModel : UserViewModel
    
    var body: some View {
        VStack {
//            Text("Name: \(userViewModel.currentUser?.name ?? "name")")
//            Text("Email: \(userViewModel.currentUser?.email ?? "email")")
            Text("Name")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
//        let userViewModel = UserViewModel()
        
        return ProfileView()
    }
}
