//
//  RestaurantViewModel.swift
//  iOS_GroupProject
//
//  Created by Tuan Vo Hoang on 15/09/2023.
//


import Foundation
import FirebaseFirestore

class RestaurantViewModel: ObservableObject {
    @Published var restaurants = [Restaurant]()

    private var db = Firestore.firestore()
    
    init() {
        getAllRestaurantData()
    }
    
    func getAllRestaurantData() {
        
        // Retrieve the "movies" document
        db.collection("restaurants").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            // Loop to get the "name" field inside each movie document
            self.restaurants = documents.map { (queryDocumentSnapshot) -> Restaurant in
                let data = queryDocumentSnapshot.data()
                let name = data["name"] as? String ?? ""
                let address = data["address"] as? String ?? ""
                let hours = data["hours"] as? String ?? ""
                let phone = data["phone"] as? String ?? ""
                return Restaurant(name: name, address: address, hours: hours, phone: phone)
            }
        }
    }

    
    
    func addNewRestaurant(curName: String, curAddress: String, curHours: String, curPhone: String) {
            // add a new restaurant to "restaurants" document
            db.collection("restaurants").addDocument(data: ["name": curName, "address": curAddress, "hours": curHours, "phone": curPhone])
            

    }

}
