//
//  ResUpdateSheet.swift
//  iOS_GroupProject
//
//  Created by Thang Do Quang on 22/09/2023.
//

import SwiftUI

struct ResUpdateSheet: View {
    @StateObject var restaurantViewModel = RestaurantViewModel()
    
    // Properties to store restaurant details
    var restaurant: Restaurant
    @State private var name: String = ""
    @State private var address: String = ""
    @State private var hours: String = ""
    @State private var phone: String = ""
    @State private var description: String = ""
    @State private var category: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Restaurant Details")) {
                    TextField("Name", text: $name)
                    TextField("Address", text: $address)
                    TextField("Hours", text: $hours)
                    TextField("Phone", text: $phone)
                    TextField("Description", text: $description)
                    TextField("Category", text: $category)
                    
                }
                 
                Section {
                    Button(action: {
                        // Perform some action with the entered restaurant details
                        // For example, add the restaurant to your data source
                        // restaurantViewModel.addRestaurant(name: name, address: address, hours: hours, phone: phone, description: description, category: category, date: Date(), author: author)
                         
                         
                        restaurantViewModel.updateRestaurant(restaurantID: restaurant.id, name: name, address: address, hours: hours, phone: phone, img: "test", description: description, category: category, date: Calendar.current.startOfDay(for: Date()), author: "tester")
                        // Clear the input fields
                        name = ""
                        address = ""
                        hours = ""
                        phone = ""
                        description = ""
                        category = ""
                    }) {
                        Text("Update")
                    }
                }
            }
            .navigationTitle("Update Restaurant")
        }
    }
}

struct ResUpdateSheet_Previews: PreviewProvider {
    static var previews: some View {
        ResUpdateSheet(restaurant: Restaurant(id: "0", name: "KFC", address: "110 Thống Nhất, Gò Vấp, Thành phố Hồ Chí Minh, Vietnam",hours: "8AM - 10PM",phone:"000000", img: "KFC", description: "example", category: "Chinese", date: NSDate() as Date, author: "new", rating: 3.5))
    }
}
