//
//  CategotyView.swift
//  Food Review
//
//  Created by Thang Do Quang on 15/09/2023.
//

import SwiftUI

struct CategotyView: View {
    let isActive: Bool
    let text: String
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            Text(text)
                .font(.system(size: 18))
                .fontWeight(.medium)
                .foregroundColor(isActive ? Color("Color1") : Color.black.opacity(0.5))
            if (isActive) { Color("Color1")
                .frame(width: 30, height: 2)
                .clipShape(Capsule())
            }
        }
        .padding(.trailing)
    }
}

struct CategotyView_Previews: PreviewProvider {
    static var previews: some View {
        CategotyView(isActive: true, text: "French")
    }
}
