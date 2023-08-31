//
//  BookDetailsViewModel.swift
//  Bookworm
//
//  Created by Isaque da Silva on 31/08/23.
//

import Foundation

extension BookDetailsView {
    class BookDetailsViewModel: ObservableObject {
        let manager = CoreDataMananger.shared
        
        @Published var deleteCurrentBookAlert = false
        
        var dateFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter
        }
        
        func deleteCurrentBook(_ book: Books) {
            manager.context.delete(book)
            manager.save()
        }
    }
}
