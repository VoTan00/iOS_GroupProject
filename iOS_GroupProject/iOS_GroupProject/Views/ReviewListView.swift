//
//  ReviewListView.swift
//  iOS_GroupProject
//
//  Created by Bùi Thiên on 22/09/2023.
//
import SwiftUI

struct ReviewListView: View {
    var restaurant: Restaurant
    @EnvironmentObject var reviewViewModal: ReviewViewModel
    @EnvironmentObject var userViewModel: UserViewModel

    var body: some View {
        ZStack {
            NavigationView {
                ZStack {
                    Color("Color2").ignoresSafeArea(.all, edges: .all)
                    
                    ScrollView{
                        ForEach(reviewViewModal.reviews, id: \.id) {rev in
                            ReviewRowView(review: rev)
                        }
                    }
                    .navigationTitle(Text("Review List"))
                }
            }.navigationBarHidden(true)
        }
    }
}

struct ReviewListView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewListView(restaurant: Restaurant(id: "0", name: "KFC", address: "110 Thống Nhất, Gò Vấp, Thành phố Hồ Chí Minh, Vietnam",hours: "8AM - 10PM",phone:"000000", img: "KFC", description: "example", category: "Chinese", date: NSDate() as Date, author: "new", rating: 3.5))
            .environmentObject(ReviewViewModel())
            .environmentObject(UserViewModel())
    }
}
