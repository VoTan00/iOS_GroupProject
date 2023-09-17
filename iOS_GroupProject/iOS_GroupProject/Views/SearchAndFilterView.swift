//
//  SearchAndFilterView.swift
//  iOS_GroupProject
//
//  Created by Thang Do Quang on 17/09/2023.
//

import SwiftUI

struct SearchAndFilterView: View {
    @State private var search: String = ""
    @State private var selectedIndex: Int = 1
    private let categories = ["All", "Cafe", "Fast Food", "Buffet", "Pub", "Diner"]
    
    var sorts = ["Newest", "Oldest", "Cheapest", "Expensive"]
    @State private var selectedSort = "Newest"
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(#colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 1))
                    .ignoresSafeArea()
                
                ScrollView (showsIndicators: false) {
                    VStack (alignment: .leading) {
                        
                        SearchView(search: $search)
                        HStack{
                            Picker(selection: $selectedSort, label: Text("Sorting:")) {
                                ForEach(sorts, id: \.self) {
                                    Text($0)
                                        .tag($0)
                                        .foregroundColor(.black)
                                }
                                .foregroundColor(.black)
                            }
                            .foregroundColor(.black)
                            
                            ScrollView (.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(0 ..< categories.count) { i in
                                        Button(action: {selectedIndex = i}) {
                                            CategotyView(isActive: selectedIndex == i, text: categories[i])
                                        }
                                    }
                                }
                                .padding()
                            }
                        }
                    }
                }
            }
        }
        .navigationBarTitle("") //this must be empty
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct SearchAndFilterView_Previews: PreviewProvider {
    static var previews: some View {
        SearchAndFilterView()
    }
}
