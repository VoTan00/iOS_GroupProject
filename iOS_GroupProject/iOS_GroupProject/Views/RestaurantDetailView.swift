//
//  RestaurantDetailView.swift
//  iOS_GroupProject
//
//  Created by Bùi Thiên on 16/09/2023.
//

import SwiftUI

struct RestaurantDetailView: View{
    @EnvironmentObject var userViewModel: UserViewModel
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var context
    @State private var isPickerShowing = false
    @State private var selectedImage = UIImage?.self
    @State private var showReview = false
    @State private var isShownSheet = false
    @State private var isShowPhotoLibrary = false
    @State private var rating = 3
    
    @State private var image = UIImage()
    
    @StateObject var restaurantviewmodel = RestaurantViewModel()
    @EnvironmentObject var reviewViewModal: ReviewViewModel
    
    @State private var reviews: [Review] = []
    var restaurant: Restaurant
    

    @State private var review = ""
    
    var body: some View{
        ScrollView{
            VStack(alignment: .leading){
                HStack(alignment: .top){
                    /*Button{
                        isPickerShowing = true
                    } label: {
                        Text ("Select a photo")
                    }*/
                    //for image picker
                    Image ("KFC")
                        .resizable()
                        .foregroundColor(Color("AccentColor"))
                        .scaledToFill()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 400)
                }
                
                .padding()
                .sheet(isPresented: $isPickerShowing, onDismiss: nil){
                    //ImagePicker(selectedImage: $selectedImage, isPickerShowing: $isPickerShowing)
                }
                .overlay{
                    VStack{
                        HStack(alignment: .bottom) {
                            VStack(alignment: .leading){
                                Text(restaurant.name ?? "")
                                    .font(.title)
                                    .fontWeight(.bold)
                                Text("Open hours")
                                Text(restaurant.hours ?? "")
                            }
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottomLeading)
                            .foregroundColor(.black)
                            .padding()
                            
                            Button {
                                userViewModel.updateFavList(resId: restaurant.id)
                                if (userViewModel.currentUser != nil) {
                                    userViewModel.fetchUser(uid: userViewModel.currentUser!.id)
                                }
                            } label: {
                                if (userViewModel.currentUser != nil) {
                                    Image(systemName: (userViewModel.currentUser?.favList?.contains(restaurant.id))! ? "heart.fill" : "heart")
                                        .resizable()
                                        .foregroundColor(Color(.red))
                                        .frame(width: 30, height: 30)
                                } else {
                                    Image(systemName: "heart")
                                        .resizable()
                                        .foregroundColor(Color(.red))
                                        .frame(width: 30, height: 30)
                                }
                            }
                            .padding()
                        }

                    }
                }

            RatingStarsView(rating: $rating)
//            Text(restaurant.reviews?.content ?? "")
                .padding()
                Text(restaurant.description ?? "")

            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("ADDRESS")
                        .font(.system(.headline, design: .rounded))

                    Text(restaurant.address ?? "")
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)

                VStack(alignment: .leading) {
                    Text("PHONE")
                        .font(.system(.headline, design: .rounded))

                    Text(restaurant.phone ?? "")
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal)

            NavigationLink(
                destination:
                    MapView(location: restaurant.address ?? "")
                    .edgesIgnoringSafeArea(.all)
            ) {
                MapView(location: restaurant.address ?? "", interactionModes: [])
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 150)
                    .cornerRadius(20)
                    .padding()
            }
            Button(action: {
                self.showReview.toggle()
            }) {
                Text("Review")
                    .font(.system(.headline, design: .rounded))
                    .frame(minWidth: 0, maxWidth: .infinity)
            }
            .tint(Color.orange)
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.roundedRectangle(radius: 25))
            .controlSize(.large)
            .padding(.horizontal)
            .padding(.bottom, 20)
            }
            .sheet(isPresented: $showReview) {
            // You'll need to pass any required data to ReviewListView here
            ReviewListView(restaurant: restaurant, isFormPresented: $showReview)
            }
        }
    }
}
        
struct RestaurantDetailPreview_Preview: PreviewProvider{
    static var previews: some View {
        RestaurantDetailView(restaurant: Restaurant(id: "0", name: "KFC", address: "110 Thống Nhất, Gò Vấp, Thành phố Hồ Chí Minh, Vietnam",hours: "8AM - 10PM",phone:"000000", img: "KFC", description: "example", category: "Chinese", date: NSDate() as Date, author: "new", rating: 3.5))
            .environmentObject(UserViewModel())
            .environmentObject(ReviewViewModel())
    }

}
