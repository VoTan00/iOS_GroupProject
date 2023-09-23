//
//  Review.swift
//  iOS_GroupProject
//
//  Created by Tuan Vo Hoang on 15/09/2023.
//

import Foundation


struct Review: Codable, Identifiable {
   var id: String = UUID().uuidString
   var restaurantID: String?
   var reviewAuthor: String?
   var content: String?
   var date: Date = Date()?
   var rating: Int?
}
