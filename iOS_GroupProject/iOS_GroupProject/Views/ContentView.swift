//
//  ContentView.swift
//  iOS_GroupProject
//
//  Created by Thu Nguyen  on 08/09/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userViewModel: UserViewModel
        
    var body: some View {
        LogInView()
            .overlay(
                SplashScreenView()
            )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserViewModel())
    }
}



