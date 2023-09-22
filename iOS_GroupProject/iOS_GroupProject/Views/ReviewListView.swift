//
//  ReviewListView.swift
//  iOS_GroupProject
//
//  Created by Bùi Thiên on 22/09/2023.
//
import SwiftUI

struct ReviewListView: View {
    var restaurantID: String
    @ObservedObject var reviewViewModel: ReviewViewModel

    var body: some View {
        VStack {
            Text("Reviews")
                .font(.title)

            // Fetch and display reviews for the selected restaurant
            List(reviewViewModel.reviews) { review in
                if review.restaurantID == restaurantID {
                    ReviewRowView(review: review)
                }
            }
        }
        .onAppear {
            // Fetch reviews for the selected restaurant
            reviewViewModel.getReviewsByRestaurantID(restaurantID){ reviews in
                reviewViewModel.reviews = reviews
                
            }
        }
    }
}
