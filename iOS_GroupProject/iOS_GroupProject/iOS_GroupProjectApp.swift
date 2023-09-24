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

@main
struct iOS_GroupProjectApp: App {
    @EnvironmentObject var reviewViewModal: ReviewViewModel
    @StateObject var userViewModel = UserViewModel()
    
    init() {
        FirebaseApp.configure();
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userViewModel)
                .environmentObject(ReviewViewModel())
        }
    }
}
