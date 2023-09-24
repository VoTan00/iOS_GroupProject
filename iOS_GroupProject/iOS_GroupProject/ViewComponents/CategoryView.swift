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

struct CategoryView: View {
    let isActive: Bool
    let text: String
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            Text(text)
                .font(.system(size: 18))
                .fontWeight(.medium)
                .foregroundColor(isActive ? Color("textColor1") : Color.black.opacity(0.5))
            if (isActive) { Color("textColor1")
                .frame(width: 20, height: 2)
                .clipShape(Capsule())
            }
        }
        .shadow(color:Color("Color-black-transparent"), radius: 7)
        .padding(.trailing)
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(isActive: true, text: "French")
    }
}
