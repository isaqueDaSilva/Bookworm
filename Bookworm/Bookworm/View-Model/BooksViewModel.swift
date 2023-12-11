//
//  BooksViewModel.swift
//  Bookworm
//
//  Created by Isaque da Silva on 31/08/23.
//

import Foundation
import SwiftUI

class BooksViewModel: ObservableObject {
    @Published var showingAddNewBook = false
    
    func displayAddNewBook() {
        self.showingAddNewBook = true
    }
    
    func textColor(_ rating: Int) -> Color {
        var color: Color = .green
        if rating <= 2 {
            color = .red
        } else if rating > 2 && rating < 5 {
            color = .orange
        } else if rating == 5 {
            color = .green
        }
        return color
    }
}
