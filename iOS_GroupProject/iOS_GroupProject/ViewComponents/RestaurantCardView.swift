//
//  RestaurantCardView.swift
//  iOS_GroupProject
//
//  Created by Thang Do Quang on 19/09/2023.
//

import SwiftUI

struct RestaurantCardView: View {
    var restaurant: Restaurant
    var body: some View {
        ZStack{
            Color("Color3")
            
            ZStack(alignment: .bottomTrailing) {
                VStack(alignment: .leading) {
                    Image("KFC")
                        .resizable()
                        .frame(width: 175, height: 160)
                        .cornerRadius(12)
                    
                    Text(restaurant.name!)
                        .font(.headline)
                        .padding(.vertical, 1)
                    
                    Text(restaurant.hours!)
                        .foregroundColor(.gray)
                        .font(.caption)
                        .padding(.vertical, 0.5)
                    
                    Text(restaurant.phone!)
                        .bold()
                }
            }
        }
        .frame(width: 180, height: 260)
        .cornerRadius(15)
    }
}

struct RestaurantCardView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantCardView(restaurant: Restaurant(id: "0", name: "KFC", address: "110 Thống Nhất, Gò Vấp, Thành phố Hồ Chí Minh, Vietnam",hours: "8AM - 10PM",phone:"000000", ratings: 3))
    }
}
