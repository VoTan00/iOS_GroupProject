//
//  HomeView.swift
//  iOS_GroupProject
//
//  Created by Thang Do Quang on 19/09/2023.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var restaurantViewModel : RestaurantViewModel
    @EnvironmentObject var reviewViewModal: ReviewViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State private var search: String = ""
    @State private var selectedIndex: Int = 1
    @State private var selectedCate: String = "All"
    private let categories = ["All", "Chinese", "Mexican", "Vietnamese", "Italian", "French", "Thai", "Indian", "International", "Japanese", "Korean"]
    var column = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Color2")
                    .ignoresSafeArea()
                
                ScrollView (showsIndicators: false) {
                    VStack (alignment: .leading) {
                        // MARK: APP NAME
                        Text("Shop")
                            .font(.largeTitle)
                            .foregroundColor(Color("Color1"))
                        + Text("Spark")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(Color("Color4"))
                        
                        // MARK: SEARCH VIEW
                        SearchView(restaurantViewModel: restaurantViewModel, search: $search)
                            .onChange(of: search, perform: restaurantViewModel.performSearch)
                        
                        ScrollView (.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(0 ..< categories.count) { i in
                                    Button(action: {
                                        selectedIndex = i
                                        restaurantViewModel.selectedCate = categories[i]
                                        restaurantViewModel.filteredArray = restaurantViewModel.getFilteredRestaurants(selectedCategory: restaurantViewModel.selectedCate)
                                    }) {
                                        CategoryView(isActive: selectedIndex == i, text: categories[i])
                                    }
                                }
                                .onAppear{
                                    selectedIndex = 0
                                    restaurantViewModel.selectedCate = categories[0]
                                }
                                .onChange(of: restaurantViewModel.selectedCate) { newValue in
                                    search = ""
                                }
                            }
                            .padding()
                        }
                        
                        ScrollView{
                            LazyVGrid(columns: column, spacing: 20) {
                                ForEach(restaurantViewModel.filteredArray, id: \.id) {restaurant in
                                    NavigationLink(destination: RestaurantDetailView(restaurant: restaurant)) {
                                        RestaurantCardView(restaurant: restaurant)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding()
                        }
                        .navigationTitle(Text("All restaurants"))
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear{
            restaurantViewModel.filteredArray = restaurantViewModel.restaurants
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let restaurantViewModel = RestaurantViewModel()
        
        HomeView(restaurantViewModel: restaurantViewModel)
            .environmentObject(UserViewModel())
            .environmentObject(ReviewViewModel())
    }
}
