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
    @EnvironmentObject var reviewViewModal: ReviewViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
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
            }.navigationBarHidden(true)
            
            // AddRestaurantButton()
        }
    }
}

//struct PostsView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostsView()
//    }
//}

struct PostsView_Previews: PreviewProvider {
    static var previews: some View {
        let restaurantViewModel = RestaurantViewModel()
        
        return Group {
            PostsView(restaurantViewModel: restaurantViewModel)
                .preferredColorScheme(.dark)
                .environmentObject(UserViewModel())
                .environmentObject(ReviewViewModel())
            PostsView(restaurantViewModel: restaurantViewModel)
                .preferredColorScheme(.light)
                .environmentObject(UserViewModel())
                .environmentObject(ReviewViewModel())
        }
    }
}
