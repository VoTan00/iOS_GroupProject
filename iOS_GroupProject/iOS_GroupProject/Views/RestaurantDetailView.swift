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
    
    @StateObject var restaurantViewModel = RestaurantViewModel()
    @EnvironmentObject var reviewViewModal: ReviewViewModel
    
    @State private var reviews: [Review] = []
    var restaurant: Restaurant
    

    @State private var review = ""
    
    var body: some View{
        ScrollView{
            VStack(alignment: .leading){
                HStack(alignment: .top){
                    Image(uiImage: restaurantViewModel.im)
                        .resizable()
                        .foregroundColor(Color("AccentColor"))
                        .scaledToFill()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .cornerRadius(19)
                        .shadow(color:Color("Color-black-transparent"), radius: 7)
                }
                
                .padding()
                
                VStack{
                    HStack(alignment: .top) {
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
                
                RatingStarsView(rating: $rating)
                    .padding()
                
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text("Description")
                            .font(.system(.headline, design: .rounded))

                        Text(restaurant.description ?? "")
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
                .padding()
                

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
                .shadow(color:Color("Color-black-transparent"), radius: 7)
                
                Button(action: {
                    self.showReview.toggle()
                }) {
                    Text("Review")
                        .font(.system(.headline, design: .rounded))
                        .frame(minWidth: 0, maxWidth: .infinity)
                }
                .tint(Color("Color1"))
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle(radius: 25))
                .controlSize(.large)
                .padding(.horizontal)
                .padding(.bottom, 20)
                .shadow(color:Color("Color-black-transparent"), radius: 7)
            }
            .sheet(isPresented: $showReview) {
                // You'll need to pass any required data to ReviewListView here
                ReviewListView(restaurant: restaurant, isFormPresented: $showReview)
            }
        }
        .onAppear{
            restaurantViewModel.retrieveImage(resId: restaurant.id)
        }
    }
}
        
struct RestaurantDetailPreview_Preview: PreviewProvider{
    static var previews: some View {
        RestaurantDetailView(restaurant: Restaurant(id: "0", name: "KFC", address: "110 Thống Nhất, Gò Vấp, Thành phố Hồ Chí Minh, Vietnam",hours: "8AM - 10PM",phone:"000000", img: "images/simple.jpg", description: "example", category: "Chinese", date: NSDate() as Date, author: "new", rating: 3.5))
            .environmentObject(UserViewModel())
            .environmentObject(ReviewViewModel())
    }

}
