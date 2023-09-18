//
//  HomeView.swift
//  iOS_GroupProject
//
//  Created by Bùi Thiên on 18/09/2023.
//

import SwiftUI

struct ListView: View{
    
    @State private var restaurantName:String = ""
    @State private var restaurantAdd: String = ""
    @State private var restaurantHour: String = ""
    @State private var restaurantPhone: String = ""
    @StateObject var restaurantviewmodel = RestaurantViewModel()
    @State private var isShowingSheet = false
    @State private var showingDetail = false
    var body: some View{
        
        /*  VStack{
         TextField("Enter a movie name...", text: $restaurantName)
         .padding()
         .border(.black)
         .frame(width: 230, height: 40, alignment: .leading)
         .padding()
         
         
         // button to add a movie
         Button {
         self.restaurantviewmodel.addNewRestaurant(curName: restaurantName, curAddress: restaurantAdd, curHours: restaurantHour, curPhone: restaurantPhone)
         } label: {
         Text("Add Movies")
         .padding()
         .foregroundColor(.white)
         .background(Color.black)
         }
         }*/
        
        NavigationStack{
            List (restaurantviewmodel.restaurants) {item in
                ForEach(restaurantviewmodel.restaurants, id: \.id) { restaurant in
   
                        NavigationLink(destination: RestaurantDetailView(restaurant: Restaurant())){
                        
                        Text(restaurant.name ?? "")
                    }
                    
                   
                }
            }
            .navigationTitle("ShopSpark")
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Button ("Sign Out"){
                        //code sign out
                    }
                }
            }
        }
            /*.sheet(isPresented: $isShowingSheet){
                NavigationStack{
                    RestaurantDetailView(restaurant: Restaurant())
                }
            }*/
        
    }
}



struct ListView_Previews: PreviewProvider{
    static var previews: some View{
        ListView()
    }
}
