//
//  MainView.swift
//  iOS_GroupProject
//
//  Created by Bùi Thiên on 18/09/2023.
//

import SwiftUI


struct MainView: View {
    
    @State private var selectedTabIndex = 0
    
    var body: some View {
        
        TabView(selection: $selectedTabIndex) {
            ListView()
                .tabItem {
                    Label("Restaurants", systemImage: "tag.fill")
                }
                .tag(0)
            
            
            Text("Discover")
                .tabItem {
                    Label("Discover", systemImage: "wand.and.rays")
                }
                .tag(1)
            
            /*AboutView()
                .tabItem {
                    Label("About", systemImage: "square.stack")
                }
                .tag(2)*/
        }
        .accentColor(Color.orange)
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
