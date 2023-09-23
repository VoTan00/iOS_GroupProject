//
//  ReviewListView.swift
//  iOS_GroupProject
//
//  Created by Bùi Thiên on 22/09/2023.
//
import SwiftUI

struct ReviewListView: View {
    var restaurant: Restaurant
    @ObservedObject var reviewViewModel: ReviewViewModel

    var body: some View {
        VStack {
            Text("Reviews")
                .font(.title)

            // Fetch and display reviews for the selected restaurant
            List(reviewViewModel.reviews) { review in
                if review.restaurantID == restaurant.id {
                    ReviewRowView(review: review)
                }
            }
        }
        .onAppear {
            // Fetch reviews for the selected restaurant
            reviewViewModel.getReviewsByRestaurantID(restaurant.id){ reviews in
                reviewViewModel.reviews = reviews
                
            }
        }
    }
}
