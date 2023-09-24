//
//  ResUpdateSheet.swift
//  iOS_GroupProject
//
//  Created by Thang Do Quang on 22/09/2023.
//

import SwiftUI

struct ResUpdateSheet: View {
    @StateObject var restaurantViewModel = RestaurantViewModel()
    @EnvironmentObject var reviewViewModal: ReviewViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    @Binding var isFormPresented: Bool
    
    // Properties to store restaurant details
    var restaurant: Restaurant
    @State private var name: String = ""
    @State private var address: String = ""
    @State private var hours: String = ""
    @State private var phone: String = ""
    @State private var description: String = ""
    @State private var category: String = ""
    
    @State var showImagePicker = false
    @State var image: UIImage?
    var body: some View {
        NavigationView {
            Form {
                Section {
                    VStack{
                        // MARK: CHOOSE IMAGE BUTTON
                        HStack {
                            Spacer()
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
                                        Image(uiImage: restaurantViewModel.im)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 64, height: 64)
                                            .cornerRadius(32)
                                    }
                                    
                                }.overlay(RoundedRectangle(cornerRadius: 64)
                                    .stroke(Color.black, lineWidth: 3))
                            }
                            .shadow(color:Color("Color-black-transparent"), radius: 7)
                            Spacer()
                        }
                        
                        
                    }.fullScreenCover(isPresented: $showImagePicker, onDismiss: nil){
                        ImagePicker(image: $image)
                    }
                    .onAppear{
                        restaurantViewModel.retrieveImage(resId: restaurant.id)
                    }
                }
                
                Section(header: Text("Restaurant Details")) {
                    TextField("Name", text: $name)
                        .onAppear{
                            name = restaurant.name!
                        }
                    TextField("Address", text: $address)
                        .onAppear{
                            address = restaurant.address!
                        }
                    TextField("Hours", text: $hours)
                        .onAppear{
                            hours = restaurant.hours!
                        }
                    TextField("Phone", text: $phone)
                        .onAppear{
                            phone = restaurant.phone!
                        }
                    TextField("Description", text: $description)
                        .onAppear{
                            description = restaurant.description!
                        }
                    TextField("Category", text: $category)
                        .onAppear{
                            category = restaurant.category!
                        }
                }
                 
                Section {
                    HStack{
                        Spacer()
                        Button(action: {
                            // Perform some action with the entered restaurant details
                            // For example, add the restaurant to your data source
                            // restaurantViewModel.addRestaurant(name: name, address: address, hours: hours, phone: phone, description: description, category: category, date: Date(), author: author)
                             
                             
                            restaurantViewModel.updateRestaurant(restaurantID: restaurant.id, name: name, address: address, hours: hours, phone: phone, img: image ?? UIImage(imageLiteralResourceName: "KFC"), description: description, category: category, date: Calendar.current.startOfDay(for: Date()), author: "tester")
    //                        // Clear the input fields
    //                        name = ""
    //                        address = ""
    //                        hours = ""
    //                        phone = ""
    //                        description = ""
    //                        category = ""
                            isFormPresented.toggle()
                        }) {
                            Text("Update")
                        }
                        Spacer()
                    }
                    
                }
            }
            .navigationTitle("Update Restaurant")
            .navigationBarItems(trailing: Button("Cancel") {
                isFormPresented.toggle()
            })
        }.navigationBarHidden(true)
    }
}

struct ResUpdateSheet_Previews: PreviewProvider {
    static var previews: some View {
        ResUpdateSheet(isFormPresented: .constant(true), restaurant: Restaurant(id: "0", name: "KFC", address: "110 Thống Nhất, Gò Vấp, Thành phố Hồ Chí Minh, Vietnam",hours: "8AM - 10PM",phone:"000000", img: "KFC", description: "example", category: "Chinese", date: NSDate() as Date, author: "new", rating: 3.5))
            .environmentObject(UserViewModel())
            .environmentObject(ReviewViewModel())
    }
}
