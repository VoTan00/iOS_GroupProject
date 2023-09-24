//
//  FilterOptionView.swift
//  Food Review
//
//  Created by Thang Do Quang on 15/09/2023.
//

import SwiftUI

struct FilterOptionView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var restaurantViewModel : RestaurantViewModel
    @State private var selectedButton = "none"
    var body: some View {
        ZStack {
            Color("Color2")
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
//                Text("Categories")
//                    .font(.title)
//                    .fontWeight(.bold)
//
//                HStack (alignment: .top) {
//                    Spacer()
//
//                    Button(action: {selectedButton.toggle()}) {
//                        Text("Break fast")
//                            .font(.title3)
//                            .fontWeight(.semibold)
//                            .padding()
//                            .padding(.horizontal, 6)
//                            .foregroundColor(selectedButton ? Color.white : Color("Color1"))
//                            .background(selectedButton ? Color("Color1") : Color.white)
//                            .cornerRadius(10.0)
//                    }
//
//                    Spacer()
//
//                    Button(action: {selectedButton.toggle()}) {
//                        Text("Diner")
//                            .font(.title3)
//                            .fontWeight(.semibold)
//                            .padding()
//                            .padding(.horizontal, 6)
//                            .foregroundColor(selectedButton ? Color.white : Color("Color1"))
//                            .background(selectedButton ? Color("Color1") : Color.white)
//                            .cornerRadius(10.0)
//                    }
//
//                    Spacer()
//                }
//                .padding(.vertical)
                
                Text("Sort By")
                    .font(.title)
                    .fontWeight(.bold)
                
                HStack (alignment: .top) {
                    Spacer()
                    
                    Button(action: {
                        restaurantViewModel.selectedSort = "Newest"
                        restaurantViewModel.filteredArray = restaurantViewModel.getSortedRestaurants(selectedSort: restaurantViewModel.selectedSort)
                    }) {
                        Text("Newest")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding()
                            .padding(.horizontal, 6)
                            .foregroundColor(restaurantViewModel.selectedSort == "Newest" ? Color.white : Color("Color1"))
                            .background(restaurantViewModel.selectedSort == "Newest" ? Color("Color5") : Color.white)
                            .cornerRadius(10.0)
                    }
                        
                    
                    Spacer()
                    
                    Button(action: {
                        restaurantViewModel.selectedSort = "Oldest"
                        restaurantViewModel.filteredArray = restaurantViewModel.getSortedRestaurants(selectedSort: restaurantViewModel.selectedSort)
                    }) {
                        Text("Oldest")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding()
                            .padding(.horizontal, 6)
                            .foregroundColor(restaurantViewModel.selectedSort == "Oldest" ? Color.white : Color("Color1"))
                            .background(restaurantViewModel.selectedSort == "Oldest" ? Color("Color5") : Color.white)
                            .cornerRadius(10.0)
                    }
                    
                    Spacer()
                }
                .padding(.vertical)

            }
            .padding()
            
            HStack {
                Spacer()
                Button {
                    restaurantViewModel.selectedSort = "none"
                    restaurantViewModel.filteredArray = restaurantViewModel.getSortedRestaurants(selectedSort: restaurantViewModel.selectedSort)
                } label: {
                    Text("Reset")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                        .padding()
                        .padding(.horizontal, 8)
                        .background(Color("Color5"))
                        .cornerRadius(10.0)
                }
                
//                Button {
//                    restaurantViewModel.filteredArray = restaurantViewModel.getSortedRestaurants(selectedSort: restaurantViewModel.selectedSort)
//                } label: {
//                    Text("Apply")
//                        .font(.title3)
//                        .fontWeight(.semibold)
//                        .foregroundColor(Color.white)
//                        .padding()
//                        .padding(.horizontal, 8)
//                        .background(Color("Color1"))
//                        .cornerRadius(10.0)
//                }
            }
            .padding()
            .padding(.horizontal)
//            .background(Color("Primary"))
            .frame(maxHeight: .infinity, alignment: .bottom)
            .edgesIgnoringSafeArea(.bottom)
        }
        .shadow(color:Color("Color-black-transparent"), radius: 7)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton(action: {presentationMode.wrappedValue.dismiss()}), trailing: Image("threeDot"))
    }
}

struct FilterOptionView_Previews: PreviewProvider {
    static var previews: some View {
        let restaurantViewModel = RestaurantViewModel()
        
        FilterOptionView(restaurantViewModel: restaurantViewModel)
    }
}

struct BackButton: View {
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Image(systemName: "chevron.backward")
                .foregroundColor(.black)
                .padding(.all, 12)
                .background(Color.white)
                .cornerRadius(8.0)
        }
    }
}
