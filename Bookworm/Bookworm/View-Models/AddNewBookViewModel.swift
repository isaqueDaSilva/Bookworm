//
//  AddNewBookViewModel.swift
//  Bookworm
//
//  Created by Isaque da Silva on 24/08/23.
//

import Foundation

extension AddNewBookView {
    class AddNewBookViewModel: ObservableObject {
        @Published var title = ""
        @Published var author = ""
        @Published var rating = 0
        @Published var genre = "Fantasy"
        @Published var review = ""
        
        let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poety", "Romance", "Thriller"]
    }
}
