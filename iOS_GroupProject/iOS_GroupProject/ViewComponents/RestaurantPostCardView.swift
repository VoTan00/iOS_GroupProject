//
//  RestaurantPostCardView.swift
//  iOS_GroupProject
//
//  Created by Tuan Vo Hoang on 21/09/2023.
//

import SwiftUI

struct RestaurantPostCardView: View {
    @StateObject var restaurantViewModel = RestaurantViewModel()
    var restaurant: Restaurant
    @State private var isShowingAlert = false
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
                    .foregroundColor(Color("textColor2"))
//                Text(restaurant.hours!)
//                    .bold()
//                Text(restaurant.phone!)
//                    .bold()
//                RatingStarsView(rating: .constant(4))
            }
            .padding()
            
            Spacer()
            NavigationLink {
                ResUpdateSheet(restaurant: restaurant)
            } label: {
                Image(systemName: "pencil")
                    .foregroundColor(.blue)
            }

            
            Button {
                isShowingAlert = true
            } label: {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
            .confirmationDialog("Are you sure?", isPresented: $isShowingAlert, titleVisibility: .visible) {
                Button("Delete", role: .destructive) {
                    restaurantViewModel.deleteRestaurant(restaurantID: restaurant.id)
                }
            }
        }
        .padding(.horizontal)
        .background(Color("Color5"))
        .cornerRadius(12)
        .frame(width: .infinity, alignment: .leading)
        .shadow(color:Color("Color-black-transparent"), radius: 7)
        .padding()
        .onAppear{
            restaurantViewModel.retrieveImage(resId: restaurant.id)
        }
    }
}

struct RestaurantPostCardView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantPostCardView(restaurant: Restaurant(id: "0", name: "KFC", address: "110 Thống Nhất, Gò Vấp, Thành phố Hồ Chí Minh, Vietnam",hours: "8AM - 10PM",phone:"000000", img: "KFC", description: "example", category: "Chinese", date: NSDate() as Date, author: "new", rating: 3.5))
    }
}
