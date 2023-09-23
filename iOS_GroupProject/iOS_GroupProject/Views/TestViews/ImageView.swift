////
////  ImageView.swift
////  iOS_GroupProject
////
////  Created by Thu Nguyen  on 17/09/2023.
////
//
//import SwiftUI
//import FirebaseStorage
//import FirebaseFirestore
//
//struct ImageView: View {
//    @State var showImagePicker = false
//    @State var image: UIImage?
//    @State var selectedImage: UIImage?
//    @State var retrievedImages = [UIImage]()
//    
//    var body: some View {
//        VStack{
//            // MARK: CHOOSE IMAGE BUTTON
//            Button {
//                showImagePicker.toggle()
//            } label: {
//                
//                VStack{
//                    if let image = self.image {
//                        Image(uiImage: image)
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 64, height: 64)
//                            .cornerRadius(32)
//                    } else {
//                        Image(systemName: "person.fill")
//                            .font(.system(size: 64))
//                            .padding()
//                    }
//                    
//                }.overlay(RoundedRectangle(cornerRadius: 64)
//                    .stroke(Color.black, lineWidth: 3))
//                
//                
//            }
//            
//            // MARK: UPLOAD IMAGE BUTTON
//            if image != nil {
//                Button{
//                    uploadImage()
//                } label: {
//                    Text("Upload to cloud")
//                }
//            }
//            
//            Divider()
//            
//            // MARK: DISPLAY IMAGES
//            ScrollView(.horizontal) {
//                HStack {
//                    ForEach(retrievedImages, id: \.self) { image in
//                        Image(uiImage: image)
//                            .resizable()
//                            .frame(width: 200, height: 200)
//                    }
//                }
//            }
//            
//        }.fullScreenCover(isPresented: $showImagePicker, onDismiss: nil){
//            ImagePicker(image: $image)
//        }
//        .onAppear{
//            retrieveImages()
//        }
//    }
//    
//    // MARK: UPLOAD IMAGE FUNC
//    func uploadImage() {
//        guard image != nil else {
//            return
//        }
//        
//        // create storage reference
//        let storageRef = Storage.storage().reference()
//        
//        // turn image into data
//        let imageData = image!.jpegData(compressionQuality: 0.8)
//        
//        guard imageData != nil else {
//            return
//        }
//        
//        // specify the file path and name
//        let path = "images/\(UUID().uuidString).jpg"
//        let fileRef = storageRef.child(path)
//        
//        // upload data
//        fileRef.putData(imageData!, metadata: nil) {metadata, error in
//            if error == nil && metadata != nil {
//                
//                let db = Firestore.firestore()
//                db.collection("images").document().setData(["url":path]) { error in
//                    if error == nil {
//                        DispatchQueue.main.async {
//                            // add uploaded images to the list of images for display
//                            self.retrievedImages.append(self.image!)
//                        }
//                    }
//                }
//            }
//        }
//    }
//    
//    // MARK: RETRIEVE IMAGES FUNC
//    func retrieveImages() {
//        // get data from DB
//        let db = Firestore.firestore()
//        
//        db.collection("images").getDocuments { snapshot, error in
//            
//            if error == nil && snapshot != nil {
//                
//                var paths = [String]()
//                
//                for doc in snapshot!.documents {
//                    // extract the file path
//                    paths.append(doc["url"] as! String)
//                }
//                
//                // fetch data from storage
//                for path in paths {
//                    let storageRef = Storage.storage().reference()
//                    
//                    let  fileRef = storageRef.child(path)
//                    
//                    fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
//                        
//                        if error == nil && data != nil {
//                            
//                            if let image = UIImage(data: data!) {
//                                DispatchQueue.main.async {
//                                    retrievedImages.append(image)
//                                }
//                            }
//                        }
//                    }
//                }
//                
//            }
//        }
//        
//        // get image data in storage for each image ref
//        
//        // display image
//        
//    }
//}
//
//struct ImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageView()
//    }
//}
