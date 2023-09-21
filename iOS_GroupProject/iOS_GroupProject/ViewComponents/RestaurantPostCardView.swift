//
//  RestaurantPostCardView.swift
//  iOS_GroupProject
//
//  Created by Tuan Vo Hoang on 21/09/2023.
//

import SwiftUI

struct RestaurantPostCardView: View {
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
//                Text(restaurant.hours!)
//                    .bold()
//                Text(restaurant.phone!)
//                    .bold()
//                RatingStarsView(rating: .constant(4))
            }
            .padding()
            
            Spacer()
            
            Image(systemName: "pencil")
                .foregroundColor(.blue)
            
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
        .shadow(color:Color("Color-black-transparent"), radius: 7)
        .padding()
    }
}

//struct RestaurantPostCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        RestaurantPostCardView()
//    }
//}
