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

struct ReviewListView: View {
    var restaurant: Restaurant
    @EnvironmentObject var reviewViewModal: ReviewViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var isShownSheet = false
    @State private var showReview = false
    @Binding var isFormPresented: Bool

    var body: some View {
        NavigationView {
            ZStack {
                Color("Color2").ignoresSafeArea(.all, edges: .all)
                
                VStack{
                    if reviewViewModal.getReviewsByRestaurantID(resId: restaurant.id).count > 0 {
                        ScrollView{
                            ForEach(reviewViewModal.getReviewsByRestaurantID(resId: restaurant.id), id: \.id) {rev in
                                ReviewRowView(review: rev)
                            }
                        }
                        .padding()
                    } else {
                        Text("There is no review yet!")
                            .padding()
                        Spacer()
                    }
                    

                    Button(action:{
                            self.isShownSheet.toggle()
                    }){
                        Text("Post a review")
                            .font(.system(.headline, design: .rounded))
                            .frame(minWidth: 0, maxWidth: .infinity)
                    }
                    .tint(Color("Color1"))
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.roundedRectangle(radius: 25))
                    .controlSize(.large)
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
                .sheet(isPresented: $isShownSheet) {
                    ReviewFormView(isFormPresented: $isShownSheet, restaurant: restaurant)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        // Close the form without submitting
                        isFormPresented = false
                    }
                }
            }
            .navigationTitle(Text("Review List"))
        }
        
    }
}

struct ReviewListView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewListView(restaurant: Restaurant(id: "0", name: "KFC", address: "110 Thống Nhất, Gò Vấp, Thành phố Hồ Chí Minh, Vietnam",hours: "8AM - 10PM",phone:"000000", img: "KFC", description: "example", category: "Chinese", date: NSDate() as Date, author: "new", rating: 3.5), isFormPresented: .constant(true))
            .environmentObject(ReviewViewModel())
            .environmentObject(UserViewModel())
    }
}
