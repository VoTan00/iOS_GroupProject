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

struct PostsView: View {
    
    @ObservedObject var restaurantViewModel : RestaurantViewModel
    @State private var gridLayout: [GridItem] = [GridItem(.flexible())]
    @EnvironmentObject var reviewViewModal: ReviewViewModel
    @EnvironmentObject var userViewModel: UserViewModel
//    @EnvironmentObject var preferenceViewModel: PreferenceViewModel
    
    var body: some View {
        ZStack {
            NavigationView {
                ZStack {
                    Color("Color2").ignoresSafeArea(.all, edges: .all)
                    
                    VStack{
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
                        
                        AddRestaurantButton()
                            .padding()
                    }
                    
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
//                .environmentObject(PreferenceViewModel())
            PostsView(restaurantViewModel: restaurantViewModel)
                .preferredColorScheme(.light)
                .environmentObject(UserViewModel())
                .environmentObject(ReviewViewModel())
//                .environmentObject(PreferenceViewModel())
        }
    }
}
