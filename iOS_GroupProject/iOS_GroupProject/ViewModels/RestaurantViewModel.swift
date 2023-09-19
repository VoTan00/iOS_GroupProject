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
            
        }
    }
    
    func addRestaurant(name: String, address: String, hours: String, phone: String, img: String, description: String, category: String, date: Date, author: String) {
        do {
            let restaurantData: [String: Any] = [
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
            
            db.collection("restaurants").addDocument(data: restaurantData) { error in
                if let error = error {
                    print("Error adding restaurant to Firestore: \(error)")
                    return
                }
                
                // Restaurant added successfully
                print("Restaurant added successfully!")
            }
        } catch {
            print("Error adding restaurant to Firestore: \(error)")
        }
    }
    
    
    func updateRestaurant(restaurantID: String, name: String, address: String, hours: String, phone: String, img: String, description: String, category: String, date: Date, author: String) {
        do {
            let restaurantData: [String: Any] = [
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
    }
    
    func getRestaurantByID(restaurantID: String) -> Restaurant? {
        return restaurants.first(where: { $0.id == restaurantID })
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
}
