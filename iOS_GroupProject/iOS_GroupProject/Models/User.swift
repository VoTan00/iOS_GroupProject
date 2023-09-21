//
//  User.swift
//  iOS_GroupProject
//
//  Created by Thu Nguyen  on 20/09/2023.
//

import Foundation

//struct User: Codable, Identifiable {
//    var id: String = UUID().uuidString
//    var name: String?
//    var email: String
//    var profilePic: String?
//}

struct User: Encodable, Decodable {
    var id: String
    var email: String
    var profileImageUrl: String
    var username: String
    var searchName: [String]
    var bio: String
}
