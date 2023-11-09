//
//  Filter.swift
//  Bookworm
//
//  Created by Isaque da Silva on 08/11/23.
//

import Foundation

enum Filter: String, CaseIterable {
    case all = "All"
    case ascendingOrder = "Ascending Order"
    case genre = "Genre"
    case ratingEqual = "Rating Equal to"
    case authors = "Authors"
}
