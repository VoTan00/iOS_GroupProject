//
//  ContentView.swift
//  iOS_GroupProject
//
//  Created by Thu Nguyen  on 08/09/2023.
//

import SwiftUI
import FirebaseStorage

struct ContentView: View {
    @State private var restaurant: String = ""
    @State var showImagePicker = false
    @State var image: UIImage?
    @State var selectedImage: UIImage?
        
        // our movie view model object
        @StateObject private var restaurantViewModel = RestaurantViewModel()

        var body: some View {
            VStack{
                // input field for a movie name
                TextField("Enter a movie name...", text: $restaurant)
                    .padding()
                    .border(.black)
                    .frame(width: 230, height: 40, alignment: .leading)
                    .padding()
                    .padding()



                // button to add a movie
                Button {
                    self.restaurantViewModel.addNewRestaurant(curName: restaurant, curAddress: "test 1", curHours: "test 1", curPhone: "test 1")
                } label: {
                    Text("Add Movies")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.black)
                }
                
                // List of all movies name fetched from firestore
                NavigationView {
                    List {
                        ForEach(restaurantViewModel.restaurants, id: \.id) { restaurant in
                            
                            Text(restaurant.name ?? "" )
                            Text(restaurant.address ?? "")
                            Text(restaurant.phone ?? "")
                        }
                    }
                    .navigationTitle("All Movies")
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
        
        let storageRef = Storage.storage().reference()
        
        let imageData = image!.jpegData(compressionQuality: 0.8)
        
        guard imageData != nil else {
            return
        }
        
        let fileRef = storageRef.child("images/\(UUID().uuidString).jpg")
        
        let uploadTask = fileRef.putData(imageData!, metadata: nil) {metadata, error in
            if error == nil && metadata != nil {
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



