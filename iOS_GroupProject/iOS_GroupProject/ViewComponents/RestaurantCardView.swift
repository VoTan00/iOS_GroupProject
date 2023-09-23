//
//  RestaurantCardView.swift
//  iOS_GroupProject
//
//  Created by Thang Do Quang on 19/09/2023.
//

import SwiftUI

struct RestaurantCardView: View {
    @StateObject var restaurantViewModel = RestaurantViewModel()
    @EnvironmentObject var userViewModel: UserViewModel
    var restaurant: Restaurant
    var body: some View {
        ZStack{
            Color("Color3")
            
            ZStack(alignment: .bottomTrailing) {
                VStack(alignment: .leading) {
                    Image(uiImage: restaurantViewModel.im)
                        .resizable()
                        .frame(width: 165, height: 150)
                        .cornerRadius(12)
                    
                    HStack {
                        Text(restaurant.name!)
                            .font(.headline)
                            .padding(.vertical, 1)
                        
                        Spacer()
                        
                        Button {
                            if (userViewModel.currentUser != nil) {
                                userViewModel.updateFavList(resId: restaurant.id)
                                userViewModel.fetchUser(uid: userViewModel.currentUser!.id)
                            } else {
                                print("please log in")
                            }
                        } label: {
                            if (userViewModel.currentUser != nil) {
                                Image(systemName: (userViewModel.currentUser?.favList?.contains(restaurant.id))! ? "heart.fill" : "heart")
                                    .resizable()
                                    .foregroundColor(Color(.red))
                                    .frame(width: 20, height: 20)
                            } else {
                                Image(systemName: "heart")
                                    .resizable()
                                    .foregroundColor(Color(.red))
                                    .frame(width: 20, height: 20)
                            }
                        }
                    }
                    
                    Text(restaurant.hours!)
                        .foregroundColor(.gray)
                        .font(.caption)
                        .padding(.vertical, 0.5)
                    
                    Text(restaurant.phone!)
                        .bold()
                }
                .padding(10)
            }
            .padding(.bottom,20)
            .padding(.leading, 10)
            .padding(.trailing, 10)
        }
        .frame(width: 180, height: 260)
        .cornerRadius(15)
        .shadow(color:Color("Color-black-transparent"), radius: 7)
        .onAppear{
            restaurantViewModel.retrieveImage(resId: restaurant.id)
        }
    }
}

struct RestaurantCardView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantCardView(restaurant: Restaurant(id: "0", name: "KFC", address: "110 Thống Nhất, Gò Vấp, Thành phố Hồ Chí Minh, Vietnam",hours: "8AM - 10PM",phone:"000000", img: "KFC", description: "example", category: "Chinese", date: NSDate() as Date, author: "new", rating: 3.5))
            .environmentObject(UserViewModel())
    }
}
