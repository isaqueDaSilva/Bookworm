//
//  AddNewBookViewModel.swift
//  Bookworm
//
//  Created by Isaque da Silva on 31/08/23.
//

import Foundation

class AddNewBookViewModel: ObservableObject {
    @Published var title = ""
    @Published var author = ""
    @Published var releaseDate = Date.now
    @Published var genre = "Fantasy"
    @Published var review = ""
    @Published var rating = 1
    @Published var showingAlert = false
    
}
