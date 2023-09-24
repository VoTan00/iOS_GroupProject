/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Group 27
  Created  date: 04/09/2023
  Last modified: 24/09/2023
  Acknowledgement: none
*/


import Foundation
import FirebaseFirestore
import FirebaseStorage
  
class RestaurantViewModel: ObservableObject {
    @Published var restaurants = [Restaurant]()
    @Published var reviews = [Review]()

    @Published var vietnameseRes = [Restaurant]()
    @Published var italianRes = [Restaurant]()
    @Published var frenchRes = [Restaurant]()
    @Published var thaiRes = [Restaurant]()
    @Published var mexicanRes = [Restaurant]()
    @Published var indianRes = [Restaurant]()
    @Published var internationalRes = [Restaurant]()
    @Published var japaneseRes = [Restaurant]()
    @Published var koreanRes = [Restaurant]()
    @Published var chineseRes = [Restaurant]()
    
    @Published var newestRes = [Restaurant]()
    @Published var olderRes = [Restaurant]()
    @Published var leastRate = [Restaurant]()
    @Published var mostRate = [Restaurant]()
    
    @Published var selectedCate = "All"
    @Published var selectedSort = "None"
    @Published var filteredArray = [Restaurant]()
    
    @Published var im = UIImage ()
    
    private var db = Firestore.firestore()
    
    init() {
        getAllRestaurantData()
    }
    
    func getAllRestaurantData() {
        // Retrieve the "restaurants" collection
        db.collection("restaurants").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            // Loop to get the data for each restaurant document
            self.restaurants = documents.map { (queryDocumentSnapshot) -> Restaurant in
                let data = queryDocumentSnapshot.data()
                let id = queryDocumentSnapshot.documentID
                let name = data["name"] as? String ?? ""
                let address = data["address"] as? String ?? ""
                let hours = data["hours"] as? String ?? ""
                let phone = data["phone"] as? String ?? ""
                let img = data["img"] as? String ?? ""
                let description = data["description"] as? String ?? ""
                let category = data["category"] as? String ?? ""
                let date = data["date"] as? Date ?? Date()
                let author = data["author"] as? String ?? ""
                return Restaurant(id: id, name: name, address: address, hours: hours, phone: phone, img: img, description: description, category: category, date: date, author: author)
            }
            self.filteredArray = self.restaurants
            self.vietnameseRes = self.restaurants.filter { $0.category?.contains("Vietnamese") ?? false}
            self.italianRes = self.restaurants.filter { $0.category?.contains("Italian") ?? false}
            self.frenchRes = self.restaurants.filter { $0.category?.contains("French") ?? false}
            self.thaiRes = self.restaurants.filter { $0.category?.contains("Thai") ?? false}
            self.mexicanRes = self.restaurants.filter { $0.category?.contains("Mexican") ?? false}
            self.indianRes = self.restaurants.filter { $0.category?.contains("Indian") ?? false}
            self.internationalRes = self.restaurants.filter { $0.category?.contains("International") ?? false}
            self.japaneseRes = self.restaurants.filter { $0.category?.contains("Japanese") ?? false}
            self.koreanRes = self.restaurants.filter { $0.category?.contains("Korean") ?? false}
            self.chineseRes = self.restaurants.filter { $0.category?.contains("Chinese") ?? false}
            
            self.newestRes = self.restaurants.sorted {$0.date > $1.date}
            self.olderRes = self.restaurants.sorted {$0.date < $1.date}
            self.leastRate = self.restaurants.sorted {$0.rating < $1.rating}
            self.mostRate = self.restaurants.sorted {$0.rating > $1.rating}
        }
    }
    
    // MARK: RETRIEVE IMAGE FUNC for a restaurant
    func retrieveImage(resId: String) {
        db.collection("restaurants").getDocuments { snapshot, error in
            
            if error == nil && snapshot != nil {
                
                var path = String ()
                
                for doc in snapshot!.documents {
                    // extract the file path
                    if doc["img"] != nil {
                        if doc.documentID == resId {
                            path = doc["img"] as! String
                        }
                    }
                    
                }
                
                // fetch data from storage
                let storageRef = Storage.storage().reference()
                
                let  fileRef = storageRef.child(path)
                
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
    
    func addRestaurant(name: String, address: String, hours: String, phone: String, img: UIImage, description: String, category: String, date: Date, author: String) {
        do {
            var restaurantData: [String: Any] = [
                "name": name,
                "address": address,
                "hours": hours,
                "phone": phone,
                "img": "",
                "description": description,
                "category": category,
                "date": date,
                "author": author
            ]
            
            // create storage reference
            let storageRef = Storage.storage().reference()
            
            // turn image into data
            let imageData = img.jpegData(compressionQuality: 0.8)
            
            // specify the file path and name
            let path = "images/\(UUID().uuidString).jpg"
            let fileRef = storageRef.child(path)
            
            restaurantData["img"] = path

            // upload data
            fileRef.putData(imageData!, metadata: nil) {metadata, error in
                if let error = error {
                    print("Failed to push image: \(error)")
                    return
                }
            }
            
            db.collection("restaurants").addDocument(data: restaurantData) { error in
                if let error = error {
                    print("Error adding restaurant to Firestore: \(error)")
                    return
                }
                print("Restaurant added successfully!")
            }
        } catch {
            print("Error adding restaurant to Firestore: \(error)")
        }
    }
    
    
    func updateRestaurant(restaurantID: String, name: String, address: String, hours: String, phone: String, img: UIImage, description: String, category: String, date: Date, author: String) {
        do {
            var restaurantData: [String: Any] = [
                "name": name,
                "address": address,
                "hours": hours,
                "phone": phone,
                "img": img,
                "description": description,
                "category": category,
                "date": date,
                "author": author
            ]
            // create storage reference
            let storageRef = Storage.storage().reference()
            
            // turn image into data
            let imageData = img.jpegData(compressionQuality: 0.8)
            
            // specify the file path and name
            let path = "images/\(UUID().uuidString).jpg"
            let fileRef = storageRef.child(path)
            
            restaurantData["img"] = path

            // upload data
            fileRef.putData(imageData!, metadata: nil) {metadata, error in
                if let error = error {
                    print("Failed to push image: \(error)")
                    return
                }
            }
            db.collection("restaurants").document(restaurantID).setData(restaurantData, merge: true) { error in
                if let error = error {
                    print("Error updating restaurant in Firestore: \(error)")
                    return
                }
                
                // Restaurant updated successfully
                print("Restaurant updated successfully!")
            }
        } catch {
            print("Error updating restaurant in Firestore: \(error)")
        }
    }
    
    
    func deleteRestaurant(restaurantID: String) {
        db.collection("restaurants").document(restaurantID).delete { error in
            if let error = error {
                print("Error deleting restaurant from Firestore: \(error)")
            } else {
                // Restaurant deleted successfully
                print("Restaurant deleted successfully!")
            }
        }

        let storageRef = Storage.storage().reference()
                
        let  fileRef = storageRef.child(getRestaurantByID(restaurantID: restaurantID).img!)
        // Delete the image
        fileRef.delete { error in
            if let error = error {
                print("Error deleting image: \(error.localizedDescription)")
            } else {
                print("Image deleted successfully.")
            }
        }
    }
    
    func getRestaurantByID(restaurantID: String) -> Restaurant {
        return restaurants.first(where: { $0.id == restaurantID })!
    }
     
    func getFilteredRestaurants(selectedCategory: String) -> [Restaurant]{
        // Get the appropriate restaurant list based on the selected category
        
        switch selectedCategory {
        case "All":
            return self.restaurants
        case "Chinese":
            return self.chineseRes
        case "Mexican":
            return self.mexicanRes
        case "Vietnamese":
            return self.vietnameseRes
        case "Italian":
            return self.italianRes
        case "French":
            return self.frenchRes
        case "Thai":
            return self.thaiRes
        case "Indian":
            return self.indianRes
        case "International":
            return self.internationalRes
        case "Japanese":
            return self.japaneseRes
        case "Korean":
            return self.koreanRes
        default:
            return self.restaurants
        }
    }
    
    func performSearch(keyword: String) {
        if keyword.isEmpty {
            if selectedCate != "All" {
                filteredArray = getFilteredRestaurants(selectedCategory: selectedCate)
            } else {
                filteredArray = restaurants
            }
        } else {
            if selectedCate != "All" {
                filteredArray = getFilteredRestaurants(selectedCategory: selectedCate).filter{
                    $0.name?.lowercased().contains(keyword.lowercased()) ?? false
                }
            } else {
                filteredArray = restaurants.filter{
                    $0.name?.lowercased().contains(keyword.lowercased()) ?? false
                }
            }
        }
    }
    
    func getSortedRestaurants(selectedSort: String) -> [Restaurant]{
        switch selectedSort {
        case "Newest":
            return self.newestRes
        case "Oldest":
            return self.olderRes
        case "Least Ratings":
            return self.leastRate
        case "Most Ratings":
            return self.mostRate
        default:
            return self.restaurants
        }
    }
}
