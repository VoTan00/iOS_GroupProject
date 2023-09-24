/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Group 27
  Created  date: 04/09/2023
  Last modified: 24/09/2023
  Acknowledgement: none
*/


import SwiftUI

struct ListView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @ObservedObject var restaurantViewModel : RestaurantViewModel
    @State private var gridLayout: [GridItem] = [GridItem(.flexible())]
    @EnvironmentObject var reviewViewModal: ReviewViewModel
  
    var body: some View {
        ZStack {
            NavigationView {
                ZStack {
                    Color("Color2").ignoresSafeArea(.all, edges: .all)
                    
                    ScrollView{
                        if (userViewModel.currentUser != nil) {
                            if (userViewModel.currentUser?.favList?.count)! > 0 {
                                ForEach(0..<(userViewModel.currentUser?.favList?.count)!, id: \.self) {res in
                                    NavigationLink{
                                        RestaurantDetailView(restaurant: restaurantViewModel.getRestaurantByID(restaurantID: (userViewModel.currentUser?.favList?[res])!))
                                    } label:
                                    {
                                        FavouriteRestaurantCardView(restaurant: restaurantViewModel.getRestaurantByID(restaurantID: (userViewModel.currentUser!.favList![res])))
                                    }
                                    .buttonStyle(.plain)
                                }
                            } else {
                                Text("Your favoutite list is empty!")
                            }
                        } else {
                            Text("Please log in to see favourite list!")
                        }
//
                    }
                    .navigationTitle(Text("Favourite List"))
                }
            }.navigationBarHidden(true)
        }
    }
}
 
struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        let restaurantViewModel = RestaurantViewModel()
        
        ListView(restaurantViewModel: restaurantViewModel)
            .environmentObject(UserViewModel())
            .environmentObject(ReviewViewModel())
    }
}
