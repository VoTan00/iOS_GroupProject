////
////  StorageService.swift
////  iOS_GroupProject
////
////  Created by Tài on 21/09/2023.
////
//
//import Foundation
//import Firebase
//import FirebaseAuth
//import FirebaseStorage
//
//
//class StorageService {
//    static var storage = Storage.storage()
//    static var storageRoot = storage.reference(forURL: "gs://ios-group-project-4f94f.appspot.com/profile")
//    
//    static var storageProfile = storageRoot.child("profile")
//    
//    static func storageProfileID(userId:String) -> StorageReference {
//        return storageProfile.child(userId)
//    }
//    
//    static func saveProfileImage(userId:String, username:String, email:String, imageData:Data, metaData: StorageMetadata,
//                                 storageProfileImageRef: StorageReference, onSuccess: @escaping(_ user: User) -> Void,
//                                 onError: @escaping(_ errorNessage: String) -> Void) {
//        
//        storageProfileImageRef.putData(imageData, metadata: metaData) {
//            (StorageMetadata, error) in
//            
//            if error != nil {
//                onError(error!.localizedDescription)
//                return
//            }
//            storageProfileImageRef.downloadURL {
//                (url, error) in
//                if let metaImageUrl = url?.absoluteString {
//                    if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest() {
//                        changeRequest.photoURL = url
//                        changeRequest.displayName = username
//                        changeRequest.commitChanges {
//                            (error) in
//                            if error != nil {
//                                onError(error!.localizedDescription)
//                                return
//                            }
//                        }
//                    }
//                    
//                    let firestoreuserId = AuthService.getuserId(userId: userId)
//                    let user = User.init(id: userId, email: email, profileImageUrl: metaImageUrl, username: username, bio: "")
//                    guard let dict = try?user.asDictionary() else {return}
//                    firestoreuserId.setData(dict) {
//                        (error) in
//                        if error != nil {
//                            onError(error!.localizedDescription)
//                        }
//                    }
//                    onSuccess(user)
//                }
//            }
//        }
//    }
//    
//}
