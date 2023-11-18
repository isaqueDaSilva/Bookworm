//
//  Author.swift
//  Bookworm
//
//  Created by Isaque da Silva on 18/11/23.
//

import Foundation

struct Author: Codable, Identifiable, Equatable, Comparable  {
    var id = UUID()
    let name: String
    
    static func < (lhs: Author, rhs: Author) -> Bool {
        lhs.name < rhs.name
    }
}
