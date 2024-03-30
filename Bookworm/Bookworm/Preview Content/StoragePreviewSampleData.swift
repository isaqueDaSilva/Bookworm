//
//  StoragePreviewSampleData.swift
//  Bookworm
//
//  Created by Isaque da Silva on 02/03/24.
//

import Foundation

extension Storage {
    static let dummyBook = Book(context: Storage.preview.context)
    
    static var preview: Storage {
        let storageProvider = Storage(inMemory: true)
        let context = storageProvider.context
        
        for index in 1...10 {
            let book = Book(context: context)
            let author = Author(context: context)
            let annotation = Annotation(context: context)
            
            // Author
            author.id = UUID()
            author.name = "Dummy \(index)"
            
            // Book
            book.id = UUID()
            book.title = "Dummy Title \(index)"
            book.releaseDate = Date.now
            book.genre = Genre.allCases.randomElement()?.rawValue ?? Genre.fantasy.rawValue
            book.review = "Dummy Review \(index)"
            book.rating = Int16(Int.random(in: 1...5))
            book.startOfReading = Date.now
            book.isFinished = Bool.random()
            
            if book.isFinished {
                book.endOfReading = Date.now
            }
            
            book.creation = Date.now
            book.author = author
            
            // Annotation
            for annotationIndex in 1...10 {
                annotation.id = UUID()
                annotation.title = "Dummy Title \(annotationIndex)"
                annotation.commentDescription = "Dummy Description \(annotationIndex)"
                annotation.creation = Date.now
                annotation.lastModification = Date.now
                annotation.book = book
                
                book.annotations?.adding(annotation)
            }
            
            author.books?.adding(book)
            
            do {
                try storageProvider.save()
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
        return storageProvider
    }
}
