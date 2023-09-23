//
//  PreferenceViewModel.swift
//  iOS_GroupProject
//
//  Created by Thu Nguyen  on 23/09/2023.
//

import Foundation
import SwiftUI

class PreferenceViewModel : ObservableObject {
    @Published var colorScheme: ColorScheme = .light

    func toggleColorScheme() {
        colorScheme = colorScheme == .light ? .dark : .light
    }
}
