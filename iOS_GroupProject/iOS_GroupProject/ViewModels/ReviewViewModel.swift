//
//  ReviewViewModel.swift
//  iOS_GroupProject
//
//  Created by Bùi Thiên on 22/09/2023.
//

import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class ReviewViewModel: ObservableObject {
    @Published var reviews: [Review] = []
    private var db = Firestore.firestore()

    init() {
        fetchData()
    }

    func fetchData() {
        // db.collection("users").addSnapshotListener { (querySnapshot, error) in
        //     guard let documents = querySnapshot?.documents else {
        //         print("No documents")
        //         return
        //     }

        //     self.users = documents.map { (queryDocumentSnapshot) -> User in
        //         let data = queryDocumentSnapshot.data()
        //         let id = queryDocumentSnapshot.documentID
        //         let username = data["username"] as? String ?? ""
        //         let email = data["email"] as? String ?? ""
        //         let profileImageUrl = data["profileImageUrl"] as? String ?? ""
        //         let bio = data["bio"] as? String ?? ""
        //         let favList = data["favList"] as? [String] ?? []
        //         return User(id: id, email: email, profileImageUrl: profileImageUrl, username: username, bio: bio, favList: favList)
        //     }
        // }
        db.collection("reviews").addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Error fetching reviews: \(error.localizedDescription)")
                return
            }

            guard let documents = querySnapshot?.documents else {
                print("No review documents")
                return
            }

            // self.reviews = documents.compactMap { queryDocumentSnapshot in
            //     return try? queryDocumentSnapshot.data(as: Review.self)
            // }

            self.reviews = documents.map{ (queryDocumentSnapshot -> Review) in
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

    /*func addReview(for id: String, restaurantID: String, reviewAuthor: String, content: String, rating: Int, date: Date) {
        let newReview = Review(id: id ,restaurantID: restaurantID, reviewAuthor: reviewAuthor, content: content, date: date, rating: rating )

        do {
            _ = try db.collection("reviews").addDocument(from: newReview)
        } catch {
            print("Error adding review: \(error.localizedDescription)")
        }
    }*/
    
    // func addReview(review: Review, completion: @escaping (Bool) -> Void) {
    // do {
    //     _ = try db.collection("reviews").addDocument(from: review) { error in
    //         if let error = error {
    //             print("Error adding review: \(error.localizedDescription)")
    //             completion(false)
    //         } else {
    //             completion(true)
    //         }
    //     }
    // } catch {
    //     print("Error encoding review: \(error.localizedDescription)")
    //     completion(false)
    // }
    // }
    
    func addReview(restaurantID: String, reviewAuthor: String, content: String, date: Date, rating: Int) {
        do {
            var reviewData: [String: Any] = [
                "restaurantID": restaurantID,
                "reviewAuthor": reviewAuthor,
                "content": content,
                "date": date,
                "rating": rating
            ]
            
            // create storage reference
            let storageRef = Storage.storage().reference()
            
            db.collection("reviews").addDocument(data: reviewData) { error in
                if let error = error {
                    print("Error adding review to Firestore: \(error)")
                    return
                }
                print("review added successfully!")
                fetchData()
            }
        } catch {
            print("Error adding review to Firestore: \(error)")
        }
    }

    // func getReviewsByRestaurantID(_ restaurantID: String, completion: @escaping ([Review]) -> Void) {
    //     // Use Firebase Firestore to fetch reviews by restaurantID
    //     // Replace this with your actual Firestore query
    //     // Example:
    //     let reviewsQuery = Firestore.firestore()
    //         .collection("reviews")
    //         .whereField("restaurantID", isEqualTo: restaurantID)

    //     reviewsQuery.getDocuments { snapshot, error in
    //         if let error = error {
    //             print("Error fetching reviews: \(error.localizedDescription)")
    //             completion([])
    //             return
    //         }

    //         if let documents = snapshot?.documents {
    //             let reviews = documents.compactMap { document -> Review? in
    //                 do {
    //                     return try document.data(as: Review.self)
    //                 } catch {
    //                     print("Error decoding review: \(error.localizedDescription)")
    //                     return nil
    //                 }
    //             }
    //             completion(reviews)
    //         } else {
    //             completion([])
    //         }
    //     }
    // }

    func getReviewsByRestaurantID(resId: String) -> [Review] {
        return reviews.filter { $0.restaurantID? == resId ?? false}
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
                fetchData()
                // Restaurant updated successfully
                print("Review updated successfully!")
            }
        } catch {
            print("Error updating review in Firestore: \(error)")
        }
    }

    func getAllRatingOfARestaurant(resId: String) -> Double {
        let resRev = reviews.filter { $0.restaurantID? == resId ?? false}
        let sum = 0
        for(rev in resRev) {
            sum += rev.rating
        }
        sum = sum / resRev.count
        return sum
    }
    // Implement additional methods for CRUD operations on reviews, if needed
}
