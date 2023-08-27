//
//  AddNewBookViewModel.swift
//  Bookworms
//
//  Created by Isaque da Silva on 26/08/23.
//

import Foundation

extension AddNewBookView {
    class AddNewBookViewModel: ObservableObject {
        @Published var title = ""
        @Published var author = ""
        @Published var releaseData = Date.now
        @Published var genre = "Fantasy"
        @Published var review = ""
        @Published var rating = 1
        
        let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
        
        var isValid: Bool {
            if title.isEmpty || author.isEmpty || review.isEmpty {
                return false
            } else {
                return true
            }
        }
    }
}
