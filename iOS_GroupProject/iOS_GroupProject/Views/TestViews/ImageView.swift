//
//  ImageView.swift
//  iOS_GroupProject
//
//  Created by Thu Nguyen  on 17/09/2023.
//

import SwiftUI
import FirebaseStorage
import FirebaseFirestore

struct ImageView: View {
    @State var showImagePicker = false
    @State var image: UIImage?
    @State var selectedImage: UIImage?
    
    var body: some View {
        VStack{
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
    
    func retrieveImgs() {
        // get data from DB
        
        // get img data in storage for each img ref
        
        // display img
        
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView()
    }
}
