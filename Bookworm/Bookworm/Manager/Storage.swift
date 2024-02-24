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
    
    func save() throws {
        try self.context.save()
        try self.fetch()
    }
    
    private func fetch() throws {
        let descriptor = FetchDescriptor<User>()
        let userFetched = try context.fetch(descriptor)
        
        guard let user = userFetched.first else {
            self.user = nil
            return
        }
        
        self.user = user
    }
    
    private func getUser() throws -> User {
        guard let user = self.user else {
            throw StorageError.dataNotFound
        }
        
        return user
    }
    
    func createUser(_ user: User) throws {
        self.context.insert(user)
        try self.save()
    }
    
    func createAuthor(_ author: Author) throws {
        let user = try self.getUser()
        
        if !user.authors.contains(author) {
            user.authors.append(author)
        } else {
            throw StorageError.duplicateItem
        }
    }
    
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
    
    
    func deleteUser() throws {
        let user = try self.getUser()
        
        self.context.delete(user)
        
        try self.save()
    }
    
    func deleteAuthor(_ authorForDelete: Author) throws {
        let user = try self.getUser()
        
        for author in user.authors {
            if author.id == authorForDelete.id {
                self.context.delete(author)
            }
        }
        
        try self.save()
    }
    
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
    
    init() {
        do {
            self.container = try ModelContainer(for: User.self)
            self.context = ModelContext(container)
            
            try self.fetch()
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }
}
