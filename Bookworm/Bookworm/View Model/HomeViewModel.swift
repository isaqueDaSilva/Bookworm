//
//  HomeViewModel.swift
//  Bookworm
//
//  Created by Isaque da Silva on 27/02/24.
//

import CoreData
import Foundation
import SwiftUI

extension HomeView {
    final class HomeViewModel: ObservableObject {
        let storage: Storage
        
        @Published var books = [Book]()
        @Published var alertTitle = ""
        @Published var alertMessage = ""
        @Published var showingAlert = false
        @Published var showingAddNewBook = false
        
        func overlayColor(_ book: Book) -> Color {
            if book.isFinished {
                
                switch Int(book.rating) {
                case 1...2:
                    return .red
                case 3...4:
                    return .orange
                case 5:
                    return .green
                default:
                    return .primary
                }
            } else {
                return .primary
            }
        }
        
        func fetchBooks() {
            do {
                let request = Book.fetchRequest()
                self.books = try storage.context.fetch(request)
                
            } catch let error {
                self.alertTitle = "Falied to Fetch Books"
                self.alertMessage = error.localizedDescription
                self.showingAlert = true
            }
        }
        
        func deleteBook(_ book: Book) {
            do {
                self.storage.context.delete(book)
                
                try storage.save()
                self.fetchBooks()
            } catch let error {
                self.alertTitle = "Falied to Delete Book"
                self.alertMessage = error.localizedDescription
                self.showingAlert = true
            }
        }
        
        init(storage: Storage) {
            self.storage = storage
        }
    }
}
