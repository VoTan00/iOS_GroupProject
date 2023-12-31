/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Group 27
  Created  date: 04/09/2023
  Last modified: 24/09/2023
  Acknowledgement: none
*/


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
                    .padding()
                    .background(Color("Color4"))
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }
            .sheet(isPresented: $isShowingAddRestaurantSheet) {
                NavigationView {        
                    Form {
                        Section {
                            VStack{
                                // MARK: CHOOSE IMAGE BUTTON
                                HStack{
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
                                                Image(systemName: "house")
                                                    .font(.system(size: 64))
                                                    .padding()
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
        .shadow(color:Color("Color-black-transparent"), radius: 7)
    }
}
  
struct AddRestaurantButton_Previews: PreviewProvider {
    static var previews: some View {
        AddRestaurantButton()
            .environmentObject(UserViewModel())
            .environmentObject(ReviewViewModel())
    }
}
 
