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


import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage

class ReviewViewModel: ObservableObject {
    @Published var reviews: [Review] = []
    private var db = Firestore.firestore()

    init() {
        fetchData()
    }

    func fetchData() {
        db.collection("reviews").addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Error fetching reviews: \(error.localizedDescription)")
                return
            }

            guard let documents = querySnapshot?.documents else {
                print("No review documents")
                return
            }

            self.reviews = documents.map{ (queryDocumentSnapshot) -> Review in
                let data = queryDocumentSnapshot.data()
                let id = queryDocumentSnapshot.documentID
                let restaurantID = data["restaurantID"] as? String ?? ""
                let reviewAuthor = data["reviewAuthor"] as? String ?? ""
                let content = data["content"] as? String ?? ""
                let date = data["date"] as? Date ?? Date()
                let rating = data["rating"] as? Int ?? 0
                return Review(id: id, restaurantID: restaurantID, reviewAuthor: reviewAuthor, content: content, date: date, rating: rating)
            }
        }
    }
    
    func addReview(restaurantID: String, reviewAuthor: String, content: String, date: Date, rating: Int) {
        do {
            let reviewData: [String: Any] = [
                "restaurantID": restaurantID,
                "reviewAuthor": reviewAuthor,
                "content": content,
                "date": date,
                "rating": rating
            ]
            
            print(reviewData)
            
            db.collection("reviews").addDocument(data: reviewData) { error in
                if error != nil {
                    print("Error adding review to Firestore")
                    return
                }
                print("review added successfully!")
//                self.fetchData()
            }
        }
    }

    func getReviewsByRestaurantID(resId: String) -> [Review] {
        return reviews.filter { $0.restaurantID == resId }
    }

    func deleteReview(revId: String) {
        db.collection("reviews").document(revId).delete { error in
            if let error = error {
                print("Error deleting review from Firestore: \(error)")
            } else {
                // Restaurant deleted successfully
                print("Review deleted successfully!")
            }
        }
    }

    func updateReView(revId: String, restaurantID: String, reviewAuthor: String, content: String, date: Date, rating: Int) {
        do {
            var reviewData: [String: Any] = [
                "restaurantID": restaurantID,
                "reviewAuthor": reviewAuthor,
                "content": content,
                "date": date,
                "rating": rating
            ]
            
            db.collection("reviews").document(revId).setData(reviewData, merge: true) { error in
                if let error = error {
                    print("Error updating review in Firestore: \(error)")
                    return
                }
                self.fetchData()
                // Restaurant updated successfully
                print("Review updated successfully!")
            }
        } catch {
            print("Error updating review in Firestore: \(error)")
        }
    }

    func getAllRatingOfARestaurant(resId: String) -> Double {
        let resRev = reviews.filter { $0.restaurantID == resId}
        var sum = 0
        for rev in resRev {
            sum += rev.rating!
        }
        sum = sum / resRev.count
        return Double(sum)
    }
    // Implement additional methods for CRUD operations on reviews, if needed
}
