//
//  UserViewModel.swift
//  iOS_GroupProject
//
//  Created by Thu Nguyen  on 20/09/2023.
//

import Foundation
import Firebase
import FirebaseFirestore
import LocalAuthentication
import FirebaseStorage

class UserViewModel: ObservableObject {
    @Published var users = [User]()
    @Published var currentUser: User?
    @Published var isUnlocked = false
    @Published var msg = "Locked"
    @Published var isLogedIn = false
    @Published var isSignedUp = false
    @Published var im = UIImage ()
    
    private var db = Firestore.firestore()
    
    init () {
        getAllUserDate()
    }
    
    // MARK: getAllUserDate
    func getAllUserDate() {
        db.collection("users").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.users = documents.map { (queryDocumentSnapshot) -> User in
                let data = queryDocumentSnapshot.data()
                let id = queryDocumentSnapshot.documentID
                let username = data["username"] as? String ?? ""
                let email = data["email"] as? String ?? ""
                let profileImageUrl = data["profileImageUrl"] as? String ?? ""
                let bio = data["bio"] as? String ?? ""
                let favList = data["favList"] as? [String] ?? []
                return User(id: id, email: email, profileImageUrl: profileImageUrl, username: username, bio: bio, favList: favList)
            }
        }
    }
    
    // MARK: update current user
    func updateCurrentUser(username: String, profileImageUrl: String, bio: String, favList: [String]) {
        // allow user to update username and profile pic
        let userRef = db.collection("users").document(currentUser!.id)
        userRef.updateData(["username": username, "profileImageUrl": profileImageUrl, "bio": bio, "favList": favList])
    }
    
    // MARK: update FAVOURITE LIST current user
    func updateFavList(resId: String) {
        // allow user to update username and profile pic
        if currentUser != nil {
            var favList = currentUser?.favList as? [String] ?? []
            
            if !(favList.contains(resId)) {
                favList.append(resId)
            } else {
                if let index = favList.firstIndex(of: resId) {
                    favList.remove(at: index)
                }
            }
            
            let userRef = db.collection("users").document(currentUser!.id)
            userRef.updateData(["favList": favList])
        }
    }
    
    // MARK: add user
    func addUserToFirestore(user: User) {
        let userRef = db.collection("users").document(user.id)
        userRef.setData(["email": user.email, "username": "", "profileImageUrl": "", "bio": "","favList": []])
    }
    
    // MARK: sign up
    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else if let user = authResult?.user {
                let newUser = User(id: user.uid, email: email, profileImageUrl: "", username: "", bio: "", favList: [])
                self.addUserToFirestore(user: newUser)
                self.currentUser = newUser
                self.isSignedUp = true
            }
        }
    }
    
    // MARK: log in
    func login(email: String, password: String)  {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else if let user = result?.user {
//                print(user.uid)
                self.fetchUser(uid: user.uid)
                self.isLogedIn = true
            }
        }
    }
    
    // MARK: fetch current user
    func fetchUser(uid: String) {
        db.collection("users").document(uid).getDocument { [weak self] document, error in
            guard let self = self else { return }
            
            if let document = document, document.exists {
                if let data = document.data() {
                    let user = User(id: uid, email: data["email"] as! String, profileImageUrl: data["profileImageUrl"] as? String, username: data["username"] as? String, bio: data["bio"] as! String, favList: data["favList"] as? [String])
                    self.currentUser = user
                    //                    self.bioAuthentication()
                }
            } else {
                print("Document does not exist")
            }
        }
    }
    
    // MARK: bio authentication
    func bioAuthentication() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = " Please authenticate yourself to log in the system."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {success, authentacationError in
                if success {
                    Task {@MainActor in
                        self.isUnlocked = true
                        self.msg = "Unlocked"
                    }
                } else {
                    //error
                    self.msg = "There is a problem"
                }
            }
        } else {
            //no bio
            self.msg = "Phone does not have Biometrics!"
        }
    }
    
    func getUserByID(userId: String) -> [User] {
        return users.filter { $0.id == userId}
    }
    
    // MARK: update current user
    func updateProfile(name: String, email: String, bio: String, img: UIImage) {
        // Check if currentUser is nil, and if so, create a default user with the specified ID
        let currentUser = currentUser ?? User(id: "i70k5v1IZoUpqEz41YfiaNtfrk32",  email: "", username: "", bio: "")
        // create storage reference
        let storageRef = Storage.storage().reference()
        // turn image into data
        let imageData = img.jpegData(compressionQuality: 0.8)
        // specify the file path and name
        let path = "profile/\(UUID().uuidString).jpg"
        let fileRef = storageRef.child(path)
//        currentUser.p= path

        // upload data
        fileRef.putData(imageData!, metadata: nil) {metadata, error in
            if let error = error {
                print("Failed to push image: \(error)")
                return
            }
        }
        // Allow the user to update username and profile pic
        let userRef = db.collection("users").document(currentUser.id)
        userRef.updateData(["username": name, "email": email, "bio": bio, "profileImageUrl": path]) { error in
            if let error = error {
                // Handle the error, e.g., show an error message
                print("Error updating profile: \(error.localizedDescription)")
            } else {
                // Profile updated successfully
                print("Profile updated successfully")
            }
        }
    }
    
    // MARK: UPLOAD IMAGE FUNC
//    func uploadImage(image: UIImage?,  completion: @escaping (Bool) -> Void) {
//        guard let image = image else {
//            completion(false)
//            return
//        }
//        // Create storage reference
//        let storageRef = Storage.storage().reference()
//        // Turn image into data
//        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
//            return
//        }
//        // Specify the file path and name
//        let path = "profile/\(UUID().uuidString).jpg"
//        let fileRef = storageRef.child(path)
//        // Upload data
//        fileRef.putData(imageData, metadata: nil) { metadata, error in
//            if error == nil && metadata != nil {
//                // Image uploaded successfully
//                let db = Firestore.firestore()
//                let currentUserID = self.currentUser?.id ?? "i70k5v1IZoUpqEz41YfiaNtfrk32"
//                // Update the profileImageUrl field without affecting other fields
//                let userRef = db.collection("users").document(currentUserID)
//                userRef.updateData(["profileImageUrl": path]) { error in
//                    if error == nil {
//                        DispatchQueue.main.async {
//                            // Add uploaded images to the list of images for display if needed
//                        }
//                    } else {
//                        // Handle the error, e.g., show an error message
//                        print("Error updating profile image URL in Firestore: \(error!.localizedDescription)")
//                    }
//                }
//            } else {
//                // Handle the error, e.g., show an error message
//                print("Error uploading image to Storage: \(error!.localizedDescription)")
//            }
//        }
//    }

    // MARK: RETRIEVE IMAGE FUNC for a user
    func retrieveImage(userId: String) {
        db.collection("users").getDocuments { snapshot, error in
            if error == nil && snapshot != nil {
                var path = String ()
                for doc in snapshot!.documents {
                    // extract the file path
                    if doc["profileImageUrl"] != nil {
                        if doc.documentID == userId {
                            path = doc["profileImageUrl"] as! String
                        }
                    }
                }
                // fetch data from storage
                let storageRef = Storage.storage().reference()
                let fileRef = storageRef.child(path)
                fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                    if error == nil && data != nil {
                        if let image = UIImage(data: data!) {
                            DispatchQueue.main.async {
                                self.im = image
                            }
                        }
                    }
                }
            }
        }
    }
    
    func logout() {
        self.currentUser = nil
        self.isLogedIn = false
        self.isUnlocked = false
    }
}
