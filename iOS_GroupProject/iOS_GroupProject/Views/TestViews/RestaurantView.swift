////
////  RestaurantView.swift
////  iOS_GroupProject
////
////  Created by Thu Nguyen  on 17/09/2023.
////
//
//import SwiftUI
//
//struct RestaurantView: View {
//    @State private var restaurant: String = ""
//    @StateObject private var restaurantViewModel = RestaurantViewModel()
//    
//    var body: some View {
//        VStack {
//            // input field for a restaurant name
//            TextField("Enter a restaurant name...", text: $restaurant)
//                .padding()
//                .border(.black)
//                .frame(width: 230, height: 40, alignment: .leading)
//                .padding()
//                .padding()
//            
//            // button to add a restaurant
//            Button {
////                self.restaurantViewModel.addNewRestaurant(curName: restaurant, curAddress: "test 1", curHours: "test 1", curPhone: "test 1")
//            } label: {
//                Text("Add restaurants")
//                    .padding()
//                    .foregroundColor(.white)
//                    .background(Color.black)
//            }
//            
//            // List of all restaurants name fetched from firestore
//            NavigationView {
//                List {
//                    ForEach(restaurantViewModel.restaurants, id: \.id) { restaurant in
//                        
//                        Text(restaurant.name ?? "" )
//                        Text(restaurant.address ?? "")
//                        Text(restaurant.phone ?? "")
//                    }
//                }
//                .navigationTitle("All restaurants")
//            }
//            
//            
//        }
//    }
//}
//
//struct RestaurantView_Previews: PreviewProvider {
//    static var previews: some View {
//        RestaurantView()
//    }
//}
