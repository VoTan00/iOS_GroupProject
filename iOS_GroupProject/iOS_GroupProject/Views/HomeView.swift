//
//  HomeView.swift
//  iOS_GroupProject
//
//  Created by Thang Do Quang on 19/09/2023.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var restaurantViewModel : RestaurantViewModel
    
    @State private var search: String = ""
    @State private var selectedIndex: Int = 1
    private let categories = ["All", "Chinese", "Mexican", "Vietnamese", "Italian", "French", "Thai", "Indian", "International", "Japanese", "Korean"]
    var sorts = ["Worst Rate", "Best Rate"]
    var column = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    
    private var res: [Restaurant] {
        restaurantViewModel.filteredArray.isEmpty ? restaurantViewModel.filteredArray : restaurantViewModel.filteredArray
    }
    
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
                        SearchView(search: $search)
                            .onChange(of: search, perform: restaurantViewModel.performSearch)
                        
                        
                        HStack{
                            Picker(selection: $restaurantViewModel.selectedSort, label: Text("Sorting:")) {
                                ForEach(sorts, id: \.self) {
                                    Text($0)
                                        .tag($0)
                                        .foregroundColor(Color("Color1"))
                                }
                                .buttonStyle(.plain)
                            }
                            .onChange(of: restaurantViewModel.selectedSort, perform: { newValue in
                                restaurantViewModel.updateFilterRestaurants()
                            })
                            .buttonStyle(.plain)
                            
                            ScrollView (.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(0 ..< categories.count) { i in
                                        Button(action: {
                                            selectedIndex = i
                                            restaurantViewModel.selectedCate = categories[i]
                                            restaurantViewModel.updateFilterRestaurants()
                                        }) {
                                            CategoryView(isActive: selectedIndex == i, text: categories[i])
                                        }
                                    }
                                    
                                }
                                .padding()
                            }
                        }
                        
                        ScrollView{
                            LazyVGrid(columns: column, spacing: 20) {
                                ForEach(res, id: \.id) {restaurant in
                                    NavigationLink(destination: RestaurantDetailView(restaurant: Restaurant(ratings: 4))) {
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
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let restaurantViewModel = RestaurantViewModel()
        
        return HomeView(restaurantViewModel: restaurantViewModel)
    }
}
