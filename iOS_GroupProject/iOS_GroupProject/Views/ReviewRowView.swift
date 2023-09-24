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


import SwiftUI

struct ReviewRowView: View {
    var review: Review
    @EnvironmentObject var reviewViewModal: ReviewViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    @State var image: UIImage?

    var body: some View {
        HStack(alignment: .center){
            Image(uiImage: userViewModel.im)
                .resizable()
                .frame(width: 50, height: 50)
                .cornerRadius(100)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack{
                    Text("Rating:")
                        .font(.headline)
                    RatingStarsView(rating: .constant(review.rating ?? 0))
                    Text("\(review.rating!)")
                        .font(.headline)
                }
                
                Text(review.content ?? "")
                    .font(.body)
                    .lineLimit(nil) // Show full review content
            }
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
        .onAppear{
            userViewModel.retrieveImage(userId: review.reviewAuthor ?? "JkJacUS1vkV5sQbagw5jQhvfNhD3")
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
