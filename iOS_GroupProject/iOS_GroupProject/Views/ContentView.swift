//
//  ContentView.swift
//  iOS_GroupProject
//
//  Created by Thu Nguyen  on 08/09/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var restaurant: String = ""
        
        // our movie view model object
        @StateObject private var restaurantViewModel = RestaurantViewModel()

        var body: some View {
            VStack{
                // input field for a movie name
                TextField("Enter a movie name...", text: $restaurant)
                    .padding()
                    .border(.black)
                    .frame(width: 230, height: 40, alignment: .leading)
                    .padding()



                // button to add a movie
                Button {
                    self.restaurantViewModel.addNewRestaurant(curName: restaurant, curAddress: "test 1", curHours: "test 1", curPhone: "test 1")
                } label: {
                    Text("Add Movies")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.black)
                }
                
                // List of all movies name fetched from firestore
                NavigationView {
                    List {
                        ForEach(restaurantViewModel.restaurants, id: \.id) { restaurant in
                            
                            Text(restaurant.name ?? "" )
                            Text(restaurant.address ?? "")
                            Text(restaurant.phone ?? "")
                        }
                    }
                    .navigationTitle("All Movies")
                }
            }

        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
