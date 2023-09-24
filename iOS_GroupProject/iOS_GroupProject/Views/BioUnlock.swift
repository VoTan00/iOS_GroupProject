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
