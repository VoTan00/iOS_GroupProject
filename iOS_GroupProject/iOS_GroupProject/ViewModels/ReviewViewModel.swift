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
        db.collection("reviews").addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Error fetching reviews: \(error.localizedDescription)")
                return
            }

            guard let documents = querySnapshot?.documents else {
                print("No review documents")
                return
            }

            self.reviews = documents.compactMap { queryDocumentSnapshot in
                return try? queryDocumentSnapshot.data(as: Review.self)
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
    
    func addReview(review: Review, completion: @escaping (Bool) -> Void) {
    do {
        _ = try db.collection("reviews").addDocument(from: review) { error in
            if let error = error {
                print("Error adding review: \(error.localizedDescription)")
                completion(false)
            } else {
                completion(true)
            }
        }
    } catch {
        print("Error encoding review: \(error.localizedDescription)")
        completion(false)
    }
    }
    
    func getReviewsByRestaurantID(_ restaurantID: String, completion: @escaping ([Review]) -> Void) {
        // Use Firebase Firestore to fetch reviews by restaurantID
        // Replace this with your actual Firestore query
        // Example:
        let reviewsQuery = Firestore.firestore()
            .collection("reviews")
            .whereField("restaurantID", isEqualTo: restaurantID)

        reviewsQuery.getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching reviews: \(error.localizedDescription)")
                completion([])
                return
            }

            if let documents = snapshot?.documents {
                let reviews = documents.compactMap { document -> Review? in
                    do {
                        return try document.data(as: Review.self)
                    } catch {
                        print("Error decoding review: \(error.localizedDescription)")
                        return nil
                    }
                }
                completion(reviews)
            } else {
                completion([])
            }
        }
    }

    // Implement additional methods for CRUD operations on reviews, if needed
}
