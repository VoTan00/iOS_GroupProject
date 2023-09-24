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
 
struct Restaurant: Codable, Identifiable {
    var id: String = UUID().uuidString
    var name: String?
    var address: String?
    var hours: String?
    var phone: String?
    var img: String?
    var description: String?
    var category: String?
    var date: Date = Date()
    var author: String?
    var rating: Double = 0
}
