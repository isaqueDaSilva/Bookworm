//
//  ContentViewModel.swift
//  Bookworms
//
//  Created by Isaque da Silva on 26/08/23.
//

import CoreData
import Foundation
import SwiftUI

extension ContentView {
    class ContentViewModel: ObservableObject {
        let manager = CoreDataManager.shared
        
        @Published var savedBooks = [Book]()
        @Published var showingAddNewBook = false
        
        func fetchBook() {
            let request = NSFetchRequest<Book>(entityName: "Book")
            let sort = NSSortDescriptor(keyPath: \Book.title, ascending: true)
            
            request.sortDescriptors = [sort]
            
            do{
                savedBooks = try manager.context.fetch(request)
            } catch {
                fatalError("Falied to fetching books in Data Model. Error \(error)")
            }
        }
        
        func textColor(_ rating: Int16) -> Color {
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
        
        func deleteBook(at indexSet: IndexSet) {
            guard let index = indexSet.first else {
                return
            }
            
            let book = savedBooks[index]
            manager.context.delete(book)
            manager.saveBook()
        }
        
        init() {
            fetchBook()
        }
    }
}
