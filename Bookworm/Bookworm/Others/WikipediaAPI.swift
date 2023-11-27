//
//  WikipediaAPI.swift
//  Bookworm
//
//  Created by Isaque da Silva on 26/11/23.
//

import Foundation

struct WikipediaAPI: Codable {
    struct Results: Codable {
        let query: Query
    }
    
    struct Query: Codable {
        let pages: [Int : Pages]
    }
    
    struct Pages: Codable, Equatable {
        let pageid: Int
        let title: String
        let terms: [String : [String]]?
        
        var description: String {
            terms?["description"]?.first ?? "No further information"
        }
        
        static func <(lhs: Pages, rhs: Pages) -> Bool {
            lhs.title < rhs.title
        }
    }
}
