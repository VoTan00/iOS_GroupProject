//
//  SearchView.swift
//  Food Review
//
//  Created by Thang Do Quang on 15/09/2023.
//  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

import SwiftUI

struct SearchView: View {
    @Binding var search: String
    
    var body: some View {
        HStack {
            HStack {
                Image("Search")
                    .padding(.trailing, 8)
                TextField("Search restaurant", text: $search)
            }
            .padding(.all, 20)
            .background(Color.white)
            .cornerRadius(10.0)
            .padding(.trailing, 8)
            
            NavigationLink(
                destination: FilterOptionView(),
                label: {
                    Image("filter-2")
                        .padding()
                        .background(Color("Color1"))
                        .cornerRadius(10.0)
                })
                .navigationBarHidden(true)
                .foregroundColor(.black)
        }
        .padding(.horizontal)
    }
}
//
//struct SearchView_Previews: PreviewProvider {
//    var search: String = "hello"
//    static var previews: some View {
//        SearchView(search: )
//    }
//}