//
//  Storage.swift
//  Bookworm
//
//  Created by Isaque da Silva on 23/02/24.
//

import Foundation
import SwiftData

final class Storage: ObservableObject {
    let container: ModelContainer
    let context: ModelContext
    
    @Published var user: User?
    
    /// This method is used to save every change
    /// will be happen in a  persistent data model.
    func save() throws {
        try self.context.save()
        try self.fetch()
    }
    
    /// This method is used to fetch an User saved into SwiftData
    private func fetch() throws {
        let descriptor = FetchDescriptor<User>()
        let userFetched = try context.fetch(descriptor)
        
        guard let user = userFetched.first else {
            self.user = nil
            return
        }
        
        self.user = user
    }
    
    /// This method checks if the "user" property not nil.
    private func getUser() throws -> User {
        guard let user = self.user else {
            throw StorageError.dataNotFound
        }
        
        return user
    }
    
    /// This method is used to create and save a new instance of User on SwiftData
    func createUser(_ user: User) throws {
        self.context.insert(user)
        try self.save()
    }
    
    /// This method is used to create, insert and save a new instance of Author 
    /// in an existing user on SwiftData.
    func createAuthor(_ author: Author) throws {
        let user = try self.getUser()
        
        if !user.authors.contains(author) {
            user.authors.append(author)
        } else {
            throw StorageError.duplicateItem
        }
    }
    
    /// This method is used to create, insert and save a new instance of a new Book
    /// on existing Author, from an existing User on SwiftData.
    func createBook(_ book: Book) throws {
        let user = try self.getUser()
        
        for author in user.authors {
            if author.authorName == book.author {
                if !author.books.contains(book) {
                    author.books.append(book)
                } else {
                    throw StorageError.duplicateItem
                }
            }
        }
        
        try self.save()
    }
    
    /// This method is used to delete an existing User.
    func deleteUser() throws {
        let user = try self.getUser()
        
        self.context.delete(user)
        
        try self.save()
    }
    
    /// This method is used to delete an existing Author,
    /// of a existing User saved on SwiftData.
    func deleteAuthor(_ authorForDelete: Author) throws {
        let user = try self.getUser()
        
        for author in user.authors {
            if author.id == authorForDelete.id {
                self.context.delete(author)
            }
        }
        
        try self.save()
    }
    
    /// This method is used to delete an existing Book
    /// of a existing Author, from a existing User saved on SwiftData.
    func deleteBook(_ bookForDelete: Book) throws {
        let user = try self.getUser()
        
        for author in user.authors {
            for book in author.books {
                if book.id == bookForDelete.id {
                    self.context.delete(book)
                }
            }
        }
        
        try self.save()
    }
    
    /// Prepares the Storage type for use
    ///
    /// This iniit configures the ModelContainer for a User Model,
    /// defines a ModelContext for a ModelContainer,
    /// and searches if exist some User save on SwiftData or no,
    /// and if the process fails, an error will be returned.
    init(isStoredInMemoryOnly: Bool = false) {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: isStoredInMemoryOnly)
            self.container = try ModelContainer(for: User.self, configurations: config)
            self.context = ModelContext(container)
            
            try self.fetch()
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }
}
