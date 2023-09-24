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


import Foundation


struct Review: Codable, Identifiable {
   var id: String = UUID().uuidString
   var restaurantID: String?
   var reviewAuthor: String?
   var content: String?
   var date: Date = Date()
   var rating: Int?
}
