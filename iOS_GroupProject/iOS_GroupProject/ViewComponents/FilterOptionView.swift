//
//  FilterOptionView.swift
//  Food Review
//
//  Created by Thang Do Quang on 15/09/2023.
//

import SwiftUI

struct FilterOptionView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var selectedButton = false
    var body: some View {
        ZStack {
            Color("Color2")
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Text("Categories")
                    .font(.title)
                    .fontWeight(.bold)
                
                HStack (alignment: .top) {
                    Spacer()
                    
                    Button(action: {selectedButton.toggle()}) {
                        Text("Break fast")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding()
                            .padding(.horizontal, 6)
                            .foregroundColor(selectedButton ? Color.white : Color("Color1"))
                            .background(selectedButton ? Color("Color1") : Color.white)
                            .cornerRadius(10.0)
                    }
                    
                    Spacer()
                    
                    Button(action: {selectedButton.toggle()}) {
                        Text("Diner")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding()
                            .padding(.horizontal, 6)
                            .foregroundColor(selectedButton ? Color.white : Color("Color1"))
                            .background(selectedButton ? Color("Color1") : Color.white)
                            .cornerRadius(10.0)
                    }
                    
                    Spacer()
                }
                .padding(.vertical)
                
                Text("Filter By")
                    .font(.title)
                    .fontWeight(.bold)
                
                HStack (alignment: .top) {
                    Spacer()
                    
                    Button(action: {selectedButton.toggle()}) {
                        Text("Favourite")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding()
                            .padding(.horizontal, 6)
                            .foregroundColor(selectedButton ? Color.white : Color("Color1"))
                            .background(selectedButton ? Color("Color1") : Color.white)
                            .cornerRadius(10.0)
                    }
                        
                    
                    Spacer()
                    
                    Button(action: {selectedButton.toggle()}) {
                        Text("Most Popular")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding()
                            .padding(.horizontal, 6)
                            .foregroundColor(selectedButton ? Color.white : Color("Color1"))
                            .background(selectedButton ? Color("Color1") : Color.white)
                            .cornerRadius(10.0)
                    }
                    
                    Spacer()
                }
                .padding(.vertical)
                
                Spacer()
            }
            .padding()
            
            HStack {
                Spacer()
                Text("Reset")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.white)
                    .padding()
                    .padding(.horizontal, 8)
                    .background(Color("Color1"))
                    .cornerRadius(10.0)
                
                Text("Apply")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.white)
                    .padding()
                    .padding(.horizontal, 8)
                    .background(Color("Color1"))
                    .cornerRadius(10.0)
                
            }
            .padding()
            .padding(.horizontal)
//            .background(Color("Primary"))
            .frame(maxHeight: .infinity, alignment: .bottom)
            .edgesIgnoringSafeArea(.bottom)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton(action: {presentationMode.wrappedValue.dismiss()}), trailing: Image("threeDot"))
    }
}

struct FilterOptionView_Previews: PreviewProvider {
    static var previews: some View {
        FilterOptionView()
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
