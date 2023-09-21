//
//  HomeView.swift
//  iOS_GroupProject
//
//  Created by Bùi Thiên on 18/09/2023.
//

import SwiftUI

struct ListView: View {
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
                                    FavouriteRestaurantCardView(restaurant: res)
                                }
                                .buttonStyle(.plain)
                            }
                        } else {
                            Text("Your favoutite list is empty!")
                        }
                    }
                    .navigationTitle(Text("Favourite List"))
                }
            }
        }
        
//        ZStack {
//            NavigationView {
//                ZStack {
//                    Color("taco-yellow").ignoresSafeArea(.all, edges: .all)
//
//                    ScrollView {
//                        LazyVGrid(columns: gridLayout, alignment: .center, spacing: 30) {
//                            ForEach(restaurantViewModel.restaurants) { restaurant in
//                                NavigationLink{
//                                    RestaurantDetailView(restaurant: restaurant)
//                                } label:
//                                {
//                                    VStack {
//                                        Image("KFC")
//                                            .resizable()
//                                            .scaledToFill()
//                                            .frame(minWidth: 0, maxWidth: .infinity)
//                                            .frame(height: 200)
//                                            .cornerRadius(10)
//                                            .shadow(color: Color.primary.opacity(0.3), radius: 1)
//
//                                        VStack(spacing: 5) {
//                                            Text(restaurant.name ?? "")
//                                                .font(.system(size: 20).bold())
//
//                                            if (gridLayout.count == 1) {
//                                                Text(restaurant.phone ?? "")
//                                            }
//                                        }
//                                        .frame(height: 80)
//                                    }
//                                    .foregroundColor(.black)
//
//                                }
//                            }
//                        }
//                        .padding(.all, 20)
//                    }
//                }
//                .navigationTitle("Taco Places")
//                .toolbar {
//                    ToolbarItem(placement: .navigationBarTrailing) {
//                        Button(action: {
//                            self.gridLayout = Array(repeating: .init(.flexible()), count: self.gridLayout.count % 2 + 1)
//                        }) {
//                            Image(systemName: "circle.grid.2x2")
//                                .font(.title)
//                                .foregroundColor(.primary)
//                        }
//                    }
//                }
//            }
//        }
    }
}
 
struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        let restaurantViewModel = RestaurantViewModel()
        
        return ListView(restaurantViewModel: restaurantViewModel)
    }
}
