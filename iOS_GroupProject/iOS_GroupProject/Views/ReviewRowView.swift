//
//  ReviewRowView.swift
//  iOS_GroupProject
//
//  Created by Bùi Thiên on 22/09/2023.
//

import SwiftUI

struct ReviewRowView: View {
    var review: Review
    @EnvironmentObject var reviewViewModal: ReviewViewModel
    @EnvironmentObject var userViewModel: UserViewModel

    var body: some View {
        HStack(alignment: .center){
            Image("KFC")
                .resizable()
                .frame(width: 50, height: 50)
                .cornerRadius(100)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Rating: \(review.rating!)")
                    .font(.headline)
                Text(review.content ?? "")
                    .font(.body)
                    .lineLimit(nil) // Show full review content
            }
//            .frame(width: 250)
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            .padding(.vertical, 8)
            
            if userViewModel.currentUser?.id == review.reviewAuthor {
                Button {
                    reviewViewModal.deleteReview(revId: review.id)
                    reviewViewModal.fetchData()
                } label: {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                }
            }
            
            Spacer()
        }
        .padding()
    }
}

struct ReviewRowView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewRowView(review: Review(id: "0", restaurantID: "07drUE8ic4YTfPeJM1dw", reviewAuthor: "kN1hAeQK6WPP2nS1ycvZ6XFcmvG2", content: "thisdfsfsfsafsdgdfgsdfgsdfgsdgsgsdgsdfgfsgsdgsdgsd", date: NSDate() as Date, rating: 3))
            .environmentObject(UserViewModel())
            .environmentObject(ReviewViewModel())
    }
}
