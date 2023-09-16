//
//  RestaurantDetailView.swift
//  iOS_GroupProject
//
//  Created by Bùi Thiên on 16/09/2023.
//

import SwiftUI

struct RestaurantDetailView: View{
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var context
    
    @State private var showReview = false
    
    var restaurant: Restaurant
    
    
    var body: some View{
        ScrollView{
            VStack {
                VStack(alignment: .leading) {
                    Text(restaurant.name ?? "")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("Open hours")
                    Text(restaurant.hours ?? "")
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottomLeading)
                .foregroundColor(.black)
                .padding()
                
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text("ADDRESS")
                            .font(.system(.headline, design: .rounded))
                        
                        Text(restaurant.address ?? "")
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    VStack(alignment: .leading) {
                        Text("PHONE")
                            .font(.system(.headline, design: .rounded))
                        
                        Text(restaurant.phone ?? "")
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal)
                
                NavigationLink(
                    destination:
                        MapView(location: restaurant.address ?? "")
                            .edgesIgnoringSafeArea(.all)
                ) {
                    MapView(location: restaurant.address ?? "", interactionModes: [])
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 150)
                        .cornerRadius(20)
                        .padding()
                }
                
            }
            
        }
    }
}

struct RestaurantDetailPreview_Preview: PreviewProvider{
    static var previews: some View {
        RestaurantDetailView(restaurant: Restaurant(id: "0", name: "KFC", address: "110 Thống Nhất, Gò Vấp, Thành phố Hồ Chí Minh, Vietnam",hours: "8AM - 10PM",phone:"000000" ))
    }
    
}
