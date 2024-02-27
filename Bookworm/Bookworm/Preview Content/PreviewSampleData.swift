//
//  PreviewSampleData.swift
//  Bookworm
//
//  Created by Isaque da Silva on 26/02/24.
//

import Foundation

extension Storage {
    static var preview: Storage = {
        let storage = Storage(isStoredInMemoryOnly: true)
        let context = storage.context
        
        let bookSample = Book(
            id: UUID(),
            title: "Harry Potter",
            author: "J.K Rowlling",
            releaseDate: "26/07/1997",
            genre: "Fantasy",
            review: "A good book",
            rating: 5
        )
        
        let authorSample = Author(
            id: UUID(),
            authorName: "J.K Rowlling",
            books: [bookSample]
        )
        
        let userSample = User(
            id: UUID(),
            name: "Tim Cook",
            username: "tim_cook",
            email: "tim.cook@apple.com",
            author: [authorSample]
        )
        
        context.insert(userSample)
        do {
            try context.save()
        } catch let error {
            print(error.localizedDescription)
        }
        
        return storage
    }()
}
