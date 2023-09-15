//
//  iOS_GroupProjectApp.swift
//  iOS_GroupProject
//
//  Created by Thu Nguyen  on 08/09/2023.
//

import SwiftUI
import Firebase

@main
struct iOS_GroupProjectApp: App {
    
    init() {
        FirebaseApp.configure();
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
