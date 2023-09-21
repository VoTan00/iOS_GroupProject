//
//  AddRestaurantButton.swift
//  iOS_GroupProject
//
//  Created by Tuan Vo Hoang on 21/09/2023.
//

import SwiftUI
  
struct AddRestaurantButton: View {
    @State private var isShowingAddRestaurantSheet = false
    @StateObject var restaurantViewModel = RestaurantViewModel()
     
    // Properties to store restaurant details
    @State private var name: String = ""
    @State private var address: String = ""
    @State private var hours: String = ""
    @State private var phone: String = ""
    @State private var description: String = ""
    @State private var category: String = ""

     
    var body: some View {
        Button(action: {
            isShowingAddRestaurantSheet.toggle()
        }) {
            Text("Add Restaurant")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
        }
        .sheet(isPresented: $isShowingAddRestaurantSheet) {
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
                             
                            // Close the sheet
                            isShowingAddRestaurantSheet.toggle()
                             
                            restaurantViewModel.addRestaurant(name: name, address: address, hours: hours, phone: phone, img: "test", description: description, category: category, date: Calendar.current.startOfDay(for: Date()), author: "tester")
                            // Clear the input fields
                            name = ""
                            address = ""
                            hours = ""
                            phone = ""
                            description = ""
                            category = ""

                        }) {
                            Text("Add")
                        }
                    }
                }
                .navigationTitle("Add Restaurant")
                .navigationBarItems(trailing: Button("Cancel") {
                    isShowingAddRestaurantSheet.toggle()
                })
            }
        }
    }
}
  
struct AddRestaurantButton_Previews: PreviewProvider {
    static var previews: some View {
        AddRestaurantButton()
    }
}
 
