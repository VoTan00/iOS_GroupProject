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

struct ContentView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var reviewViewModal: ReviewViewModel
//    @EnvironmentObject var preferenceViewModel: PreferenceViewModel
        
    var body: some View {
        LogInView()
            .overlay(
                SplashScreenView()
            )
            .environment(\.colorScheme, userViewModel.isDark ? .dark : .light)
//        ProfileView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserViewModel())
            .environmentObject(ReviewViewModel())
//            .environmentObject(PreferenceViewModel())
    }
}



