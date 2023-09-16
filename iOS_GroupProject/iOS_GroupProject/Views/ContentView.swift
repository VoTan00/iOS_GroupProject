//
//  ContentView.swift
//  iOS_GroupProject
//
//  Created by Thu Nguyen  on 08/09/2023.
//

import SwiftUI
import FirebaseStorage
import FirebaseFirestore

struct ContentView: View {
    @State private var restaurant: String = ""
    @State var showImagePicker = false
    @State var image: UIImage?
    @State var selectedImage: UIImage?
        
        // our restaurant view model object
        @StateObject private var restaurantViewModel = RestaurantViewModel()

        var body: some View {
            VStack{
                // input field for a restaurant name
                TextField("Enter a restaurant name...", text: $restaurant)
                    .padding()
                    .border(.black)
                    .frame(width: 230, height: 40, alignment: .leading)
                    .padding()
                    .padding()



                // button to add a restaurant
                Button {
                    self.restaurantViewModel.addNewRestaurant(curName: restaurant, curAddress: "test 1", curHours: "test 1", curPhone: "test 1")
                } label: {
                    Text("Add restaurants")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.black)
                }
                
                // List of all restaurants name fetched from firestore
                NavigationView {
                    List {
                        ForEach(restaurantViewModel.restaurants, id: \.id) { restaurant in
                            
                            Text(restaurant.name ?? "" )
                            Text(restaurant.address ?? "")
                            Text(restaurant.phone ?? "")
                        }
                    }
                    .navigationTitle("All restaurants")
                }
                
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
                            Image(systemName: "person.fill")
                                .font(.system(size: 64))
                                .padding()
                        }
                            
                    }.overlay(RoundedRectangle(cornerRadius: 64)
                        .stroke(Color.black, lineWidth: 3))
                    

                }
                
                if image != nil {
                    Button{
                        uploadImg()
                    } label: {
                        Text("Upload")
                    }
                }
            }.fullScreenCover(isPresented: $showImagePicker, onDismiss: nil){
                ImagePicker(image: $image)
            }

        }
    
    func uploadImg() {
        guard image != nil else {
            return
        }
        
        // create storage reference
        let storageRef = Storage.storage().reference()
        
        // turn img into data
        let imageData = image!.jpegData(compressionQuality: 0.8)
        
        guard imageData != nil else {
            return
        }
        
        // specify the file path and name
        let path = "images/\(UUID().uuidString).jpg"
        let fileRef = storageRef.child(path)
        
        // upload data
        let uploadTask = fileRef.putData(imageData!, metadata: nil) {metadata, error in
            if error == nil && metadata != nil {
                
                let db = Firestore.firestore()
                db.collection("images").document().setData(["url":path])
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



