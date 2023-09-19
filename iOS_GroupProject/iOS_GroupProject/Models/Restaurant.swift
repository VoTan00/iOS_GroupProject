//
//  Restaurant.swift
//  iOS_GroupProject
//
//  Created by Tuan Vo Hoang on 15/09/2023.
//
 
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
//    var reviews: [Review]()
}
