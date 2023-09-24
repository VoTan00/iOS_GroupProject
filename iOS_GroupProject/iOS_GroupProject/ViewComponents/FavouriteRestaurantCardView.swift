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

struct FavouriteRestaurantCardView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var reviewViewModal: ReviewViewModel
    @StateObject var restaurantViewModel = RestaurantViewModel()
    @State private var isShowingAlert = false
    var restaurant: Restaurant
    
    var body: some View {
        HStack(spacing: 20){
            Image(uiImage: restaurantViewModel.im)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 70)
                .cornerRadius(9)
            VStack(alignment: .leading, spacing: 5) {
                Text(restaurant.name!)
                    .bold()
                Text(restaurant.hours!)
                    .bold()
                Text(restaurant.phone!)
                    .bold()
            }
            .padding()
            
            Spacer()
            
            Button {
                isShowingAlert = true
            } label: {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
            .confirmationDialog("Are you sure?", isPresented: $isShowingAlert, titleVisibility: .visible) {
                Button("Delete", role: .destructive) {
                    userViewModel.updateFavList(resId: restaurant.id)
                    userViewModel.fetchUser(uid: userViewModel.currentUser!.id)
                }
            }
        }
        .padding(.horizontal)
        .background(Color("Color1"))
        .cornerRadius(12)
        .frame(width: .infinity, alignment: .leading)
        .shadow(color:Color("Color-black-transparent"), radius: 7)
        .padding()
        .onAppear{
            restaurantViewModel.retrieveImage(resId: restaurant.id)
        }
    }
}

struct FavouriteRestaurantCardView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteRestaurantCardView(restaurant: Restaurant(id: "0", name: "KFC", address: "110 Thống Nhất, Gò Vấp, Thành phố Hồ Chí Minh, Vietnam",hours: "8AM - 10PM",phone:"000000", img: "KFC", description: "example", category: "Chinese", date: NSDate() as Date, author: "new", rating: 3.5))
            .environmentObject(UserViewModel())
            .environmentObject(ReviewViewModel())
    }
}
