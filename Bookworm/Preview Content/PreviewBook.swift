//
//  PreviewBook.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/4/25.
//

#if DEBUG
import CoreData
struct PreviewBook {
    var books: [Book] = []
    
    private mutating func makePreviewInstance() {
        let previewStorage = Storage.preview
        let fetchRequest = Book.fetchRequest()
        fetchRequest.sortDescriptors = []
        let resultController = previewStorage.fetchedResultController(for: fetchRequest)
        try? resultController.performFetch()
        let books = (resultController.fetchedObjects ?? [])
        
        self.books = books
    }
    
    init() {
        makePreviewInstance()
    }
}
#endif
