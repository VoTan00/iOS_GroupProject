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
    var reviews: Review?
}

