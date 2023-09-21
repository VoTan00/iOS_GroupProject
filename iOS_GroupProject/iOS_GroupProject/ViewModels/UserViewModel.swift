////
////  UserViewModel.swift
////  iOS_GroupProject
////
////  Created by Thu Nguyen  on 20/09/2023.
////
//
//import Foundation
//import Firebase
//import FirebaseFirestore
//
//class UserViewModel: ObservableObject {
//    @Published var users = [User]()
//    @Published var currentUser: User?
//
//    private var db = Firestore.firestore()
//
//    init () {
//        getAllUserDate()
//    }
//
//    // MARK: getAllUserDate
//    func getAllUserDate() {
//        db.collection("users").addSnapshotListener { (querySnapshot, error) in
//            guard let documents = querySnapshot?.documents else {
//                print("No documents")
//                return
//            }
//
//            self.users = documents.map { (queryDocumentSnapshot) -> User in
//                let data = queryDocumentSnapshot.data()
//                let id = queryDocumentSnapshot.documentID
//                let name = data["name"] as? String ?? ""
//                let email = data["email"] as? String ?? ""
//                let profilePic = data["profilePic"] as? String ?? ""
//                return User(id: id, name: name, email: email, profilePic: profilePic)
//            }
//        }
//    }
//
//    // MARK: update current user
//    func updateCurrentUser(name: String, profilePic: String) {
//        // allow user to update name and profile pic
//        let userRef = db.collection("users").document(currentUser!.id)
//        userRef.updateData(["name": name, "profilePic": profilePic])
//    }
//
//    // MARK: add user
//    func addUserToFirestore(user: User) {
//        let userRef = db.collection("users").document(user.id)
//        userRef.setData(["email": user.email, "name": user.name ?? "", "profilePic": user.profilePic ?? ""])
//    }
//
//    // MARK: sign up
//    func signUp(email: String, password: String) {
//        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
//            if error != nil {
//                print(error?.localizedDescription ?? "")
//            } else if let user = authResult?.user {
//                let newUser = User(id: user.uid, email: email)
//                self.addUserToFirestore(user: newUser)
//                self.currentUser = newUser
//            }
//        }
//    }
//
//    // MARK: log in
//    func login(email: String, password: String)  {
//        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
//            if error != nil {
//                print(error?.localizedDescription ?? "")
//            } else if let user = result?.user {
//                self.fetchUser(uid: user.uid)
//            }
//        }
//    }
//
//    // MARK: fetch current user
//    func fetchUser(uid: String) {
//        db.collection("users").document(uid).getDocument { [weak self] document, error in
//            guard let self = self else { return }
//
//            if let document = document, document.exists {
//                if let data = document.data() {
//                    let user = User(id: uid, name: data["name"] as? String, email: data["email"] as! String, profilePic: data["profilePic"] as? String)
//                    self.currentUser = user
//                }
//            } else {
//                print("Document does not exist")
//            }
//        }
//    }
//}
//
