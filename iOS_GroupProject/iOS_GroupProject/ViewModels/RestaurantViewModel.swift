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
    @Published var filteredArray = [Restaurant]()
    
    @Published var selectedSort = "Worst Rate"
    @Published var selectedCate = "All"

    private var db = Firestore.firestore()
    
    init() {
        getAllRestaurantData()
    }
    
    func getAllRestaurantData() {
        
        // Retrieve the "restaurants" document
        db.collection("restaurants").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            // Loop to get the "name" field inside each restaurant document
            self.restaurants = documents.map { (queryDocumentSnapshot) -> Restaurant in
                let data = queryDocumentSnapshot.data()
                let name = data["name"] as? String ?? ""
                let address = data["address"] as? String ?? ""
                let hours = data["hours"] as? String ?? ""
                let phone = data["phone"] as? String ?? ""
                let category = data["category"] as? String ?? ""
                let ratings = data["ratings"] as? Int ?? 0
//                self.restaurants.append(Restaurant(name: name, address: address, hours: hours, phone: phone, category: category, ratings: ratings))
                return Restaurant(name: name, address: address, hours: hours, phone: phone, category: category, ratings: ratings)
            }
            
            self.filteredArray = documents.map { (queryDocumentSnapshot) -> Restaurant in
                let data = queryDocumentSnapshot.data()
                let name = data["name"] as? String ?? ""
                let address = data["address"] as? String ?? ""
                let hours = data["hours"] as? String ?? ""
                let phone = data["phone"] as? String ?? ""
                let category = data["category"] as? String ?? ""
                let ratings = data["ratings"] as? Int ?? 0
//                self.restaurants.append(Restaurant(name: name, address: address, hours: hours, phone: phone, category: category, ratings: ratings))
                return Restaurant(name: name, address: address, hours: hours, phone: phone, category: category, ratings: ratings)
            }
        }
    }

    
    
    func addNewRestaurant(curName: String, curAddress: String, curHours: String, curPhone: String) {
            // add a new restaurant to "restaurants" document
            db.collection("restaurants").addDocument(data: ["name": curName, "address": curAddress, "hours": curHours, "phone": curPhone])
    }
    
    func updateFilterRestaurants() {
        switch selectedSort{
        case "Worst Rate":
            filteredArray = filteredArray.sorted { (res1, res2) -> Bool in
                return res1.ratings! < res2.ratings!
            }
        case "Best Rate":
            filteredArray = filteredArray.sorted { (res1, res2) -> Bool in
                return res1.ratings! > res2.ratings!
            }
        default:
            filteredArray = filteredArray
        }
        
        switch selectedCate{
            case "All":
                filteredArray = restaurants
            case "Chinese":
                filteredArray = restaurants.filter { restaurant in
                    restaurant.category! == "Chinese"
                }
            case "Mexican":
                filteredArray = restaurants.filter { restaurant in
                    restaurant.category! == "Mexican"
                }
            case "Vietnamese":
                filteredArray = restaurants.filter { restaurant in
                    restaurant.category! == "Vietnamese"
                }
            case "Italian":
                filteredArray = restaurants.filter { restaurant in
                    restaurant.category! == "Italian"
                }
            case "French":
                filteredArray = restaurants.filter { restaurant in
                    restaurant.category! == "French"
                }
            case "Thai":
                filteredArray = restaurants.filter { restaurant in
                    restaurant.category! == "Thai"
                }
            case "Indian":
                filteredArray = restaurants.filter { restaurant in
                    restaurant.category! == "Indian"
                }
            case "International":
                filteredArray = restaurants.filter { restaurant in
                    restaurant.category! == "International"
                }
            case "Japanese":
                filteredArray = restaurants.filter { restaurant in
                    restaurant.category! == "Japanese"
                }
            case "Korean":
                filteredArray = restaurants.filter { restaurant in
                    restaurant.category! == "Korean"
                }
            default:
                filteredArray = restaurants
        }
    }
    
    func performSearch(keyword: String) {
        filteredArray = filteredArray.filter { restaurant in
            restaurant.name!.contains(keyword)
        }
    }
    
//    func getFilteredRestaurants(selectedCategory: String) -> [Restaurant]{
//            // Get the appropriate restaurant list based on the selected category
//            
//            switch selectedCategory {
//            case "All":
//                return self.restaurants
//            case "Chinese":
//                return self.chineseRes
//            case "Mexican":
//                return self.mexicanRes
//            case "Vietnamese":
//                return self.vietnameseRes
//            case "Italian":
//                return self.italianRes
//            case "French":
//                return self.frenchRes
//            case "Thai":
//                return self.thaiRes
//            case "Indian":
//                return self.indianRes
//            case "International":
//                return self.internationalRes
//            case "Japanese":
//                return self.japaneseRes
//            case "Korean":
//                return self.koreanRes
//            default:
//                return self.restaurants
//            }
//        }

}
