//
//  ContentView.swift
//  iOS_GroupProject
//
//  Created by Thu Nguyen  on 08/09/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var userViewModel = UserViewModel()
    
//    @EnvironmentObject var session: SessionStore
    
    var body: some View {
        LogInView(userViewModel : userViewModel)
            .overlay(
                SplashScreenView()
            )
//        Group {
//            if (session.session != nil) {
//                HomeView()
//            }
//            else {
//                LogInView()
//            }
//        }.onAppear(perform: listen)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



