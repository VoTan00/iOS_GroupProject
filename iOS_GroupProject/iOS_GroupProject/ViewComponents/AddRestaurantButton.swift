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
    @EnvironmentObject var reviewViewModal: ReviewViewModel
    @EnvironmentObject var userViewModel: UserViewModel
     
    // Properties to store restaurant details
    @State private var name: String = ""
    @State private var address: String = ""
    @State private var hours: String = ""
    @State private var phone: String = ""
    @State private var description: String = ""
    @State private var category: String = ""

    @State var showImagePicker = false
    @State var image: UIImage?
    @State var selectedImage: UIImage?
    @State var retrievedImages = [UIImage]()
    
    var body: some View {
        VStack {
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
                        Section {
                            VStack{
                                // MARK: CHOOSE IMAGE BUTTON
                                Button {
                                    showImagePicker.toggle()
                                } label: {
                                    
                                    VStack{
                                        if let image = self.image {
                                            Image(uiImage: image)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 64, height: 64)
                                                .cornerRadius(32)
                                        } else {
                                            Image(systemName: "house")
                                                .font(.system(size: 64))
                                                .padding()
                                        }
                                        
                                    }.overlay(RoundedRectangle(cornerRadius: 64)
                                        .stroke(Color.black, lineWidth: 3))
                                    
                                    
                                }
                                
                            }.fullScreenCover(isPresented: $showImagePicker, onDismiss: nil){
                                ImagePicker(image: $image)
                            }
                        }
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
                                 
                                restaurantViewModel.addRestaurant(name: name, address: address, hours: hours, phone: phone, img: image ?? UIImage(imageLiteralResourceName: "KFC"), description: description, category: category, date: Calendar.current.startOfDay(for: Date()), author: "tester")
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
                }.navigationBarHidden(true)
            }
        }
    }
}
  
struct AddRestaurantButton_Previews: PreviewProvider {
    static var previews: some View {
        AddRestaurantButton()
            .environmentObject(UserViewModel())
            .environmentObject(ReviewViewModel())
    }
}
 
