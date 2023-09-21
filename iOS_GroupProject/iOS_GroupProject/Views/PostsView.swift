//
//  PostsView.swift
//  iOS_GroupProject
//
//  Created by Tuan Vo Hoang on 21/09/2023.
//

import SwiftUI

struct PostsView: View {
    
    @ObservedObject var restaurantViewModel : RestaurantViewModel
    @State private var gridLayout: [GridItem] = [GridItem(.flexible())]
    
    
    var body: some View {
        ZStack {
            NavigationView {
                ZStack {
                    Color("Color2").ignoresSafeArea(.all, edges: .all)
                    
                    ScrollView{
                        if restaurantViewModel.restaurants.count > 0 {
                            ForEach(restaurantViewModel.restaurants, id: \.id) {res in
                                NavigationLink{
                                    RestaurantDetailView(restaurant: res)
                                } label:
                                {
                                    RestaurantPostCardView(restaurant: res)
                                }
                                .buttonStyle(.plain)
                            }
                        } else {
                            Text("Your have not created any post!")
                        }
                    }
                    .navigationTitle(Text("Restaurants Posts"))
                }
            }
            
            // AddRestaurantButton()
        }
    }
}

//struct PostsView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostsView()
//    }
//}
