//
//  crud.swift
//  iOS_GroupProject
//
//  Created by Vinh Vo on 9/20/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Restaurants: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var description: String
    var opening_time: String
    var closing_time: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case  description
        case opening_time
        case closing_time
    }
}
