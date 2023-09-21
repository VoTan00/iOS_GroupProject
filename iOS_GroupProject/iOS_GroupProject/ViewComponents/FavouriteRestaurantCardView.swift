//
//  FavouriteRestaurantCardView.swift
//  iOS_GroupProject
//
//  Created by Thang Do Quang on 21/09/2023.
//

import SwiftUI

struct FavouriteRestaurantCardView: View {
    var restaurant: Restaurant
    var body: some View {
        HStack(spacing: 20){
            Image("KFC")
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
//                RatingStarsView(rating: .constant(4))
            }
            .padding()
            
            Spacer()
            
            Image(systemName: "trash")
                .foregroundColor(.red)
//                .onTapGesture {
//
//                }
        }
        .padding(.horizontal)
        .background(Color("Color1"))
        .cornerRadius(12)
        .frame(width: .infinity, alignment: .leading)
        .padding()
    }
}

struct FavouriteRestaurantCardView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteRestaurantCardView(restaurant: Restaurant(id: "0", name: "KFC", address: "110 Thống Nhất, Gò Vấp, Thành phố Hồ Chí Minh, Vietnam",hours: "8AM - 10PM",phone:"000000", img: "KFC", description: "example", category: "Chinese", date: NSDate() as Date, author: "new", rating: 3.5))
    }
}
