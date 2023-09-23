//
//  BioUnlock.swift
//  iOS_GroupProject
//
//  Created by Thang Do Quang on 23/09/2023.
//

import SwiftUI

struct BioUnlock: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var reviewViewModal: ReviewViewModel
    var body: some View {
        VStack{
            Button {
                userViewModel.bioAuthentication()
            } label: {
                Text("Authenticate")
                    .padding()
                    .background(Color("Color4"))
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }
            
            Text(userViewModel.msg)
        }
    }
}

struct BioUnlock_Previews: PreviewProvider {
    static var previews: some View {
        BioUnlock()
            .environmentObject(UserViewModel())
            .environmentObject(ReviewViewModel())
    }
}
