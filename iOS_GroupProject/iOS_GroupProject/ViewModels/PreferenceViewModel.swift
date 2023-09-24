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


import Foundation
import SwiftUI

class PreferenceViewModel : ObservableObject {
    @Published var colorScheme: ColorScheme = .light

    func toggleColorScheme() {
        colorScheme = colorScheme == .light ? .dark : .light
    }
}
