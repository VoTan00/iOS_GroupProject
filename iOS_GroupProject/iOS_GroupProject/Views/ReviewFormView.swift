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

struct ReviewFormView: View {
    @EnvironmentObject var reviewViewModal: ReviewViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    @Binding var isFormPresented: Bool
    @State private var reviewContent = ""
    @State private var rating: Int = 1 // Default rating
    var restaurant: Restaurant

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Review")) {
                    TextEditor(text: $reviewContent)
                        .frame(height: 150)
                }

                Section(header: Text("Rating")) {
                    Picker("Rating", selection: $rating) {
                        ForEach(1..<6, id: \.self) { number in
                            Text("\(number)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section {
                    Button(action: {
                        // Add logic to submit the review and save it to your data store (e.g., Firestore)
                        // After submitting, you can dismiss the sheet
                        reviewViewModal.addReview(restaurantID: restaurant.id, reviewAuthor: userViewModel.currentUser?.id ?? "", content: reviewContent, date: Calendar.current.startOfDay(for: Date()), rating: rating)
                        isFormPresented = false
                    }) {
                        Text("Submit Review")
                    }
                }
            }
            .navigationTitle("Write a Review")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        // Close the form without submitting
                        isFormPresented = false
                    }
                }
            }
        }
    }
}

struct ReviewFormView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewFormView(isFormPresented: .constant(true), restaurant: Restaurant(id: "0", name: "KFC", address: "110 Thống Nhất, Gò Vấp, Thành phố Hồ Chí Minh, Vietnam",hours: "8AM - 10PM",phone:"000000", img: "KFC", description: "example", category: "Chinese", date: NSDate() as Date, author: "new", rating: 3.5))
            .environmentObject(ReviewViewModel())
            .environmentObject(UserViewModel())
    }
}
