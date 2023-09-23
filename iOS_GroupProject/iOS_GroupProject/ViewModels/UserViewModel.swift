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

class UserViewModel: ObservableObject {
    @Published var users = [User]()
    @Published var currentUser: User?
    @Published var isUnlocked = false
    @Published var msg = "Locked"

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
        userRef.setData(["email": user.email, "username": user.username , "profileImageUrl": user.profileImageUrl , "bio": user.bio, "favList": user.favList ])
    }

    // MARK: sign up
    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else if let user = authResult?.user {
                let newUser = User(id: user.uid, email: email)
                self.addUserToFirestore(user: newUser)
                self.currentUser = newUser
            }
        }
    }

    // MARK: log in
    func login(email: String, password: String)  {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else if let user = result?.user {
                self.fetchUser(uid: user.uid)
            }
        }
    }

    // MARK: fetch current user
    func fetchUser(uid: String) {
        db.collection("users").document(uid).getDocument { [weak self] document, error in
            guard let self = self else { return }

            if let document = document, document.exists {
                if let data = document.data() {
                    let user = User(id: uid, email: data["email"] as! String, profileImageUrl: data["profileImageUrl"] as? String, username: data["name"] as? String, favList: data["favList"] as? [String])
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
        return users.filter { $0.id? == userId ?? false}
    }
}

