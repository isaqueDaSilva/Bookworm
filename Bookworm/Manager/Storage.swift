//
//  Storage.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/2/25.
//

import CoreData
import ErrorWrapper
import Foundation
import os.log

final class Storage {
    static let shared = Storage()
    
    private let container: NSPersistentContainer
    private let context: NSManagedObjectContext
    
    private let logger = Logger(
        subsystem: "com.isaquedasilva.Bookworm",
        category: "Storage Manager"
    )
    
    private func save() throws(ExecutionError) {
        guard context.hasChanges else { return }
        
        do {
            try context.save()
            
            logger.info("The save action was completed with sucess.")
        } catch {
            logger.error(
                "An error was thrown when the manager was trying to save data to persistent storage. Error: \(error.localizedDescription)"
            )
            
            throw .failureInSaveAction
        }
    }
    
    func makeChanges(
        _ actionHandler: @escaping (NSManagedObjectContext) -> Void
    ) throws(ExecutionError) {
        actionHandler(context)
        try save()
    }
   
    func fetch<T: NSFetchRequestResult>(
        withController controller: NSFetchedResultsController<T>
    ) throws(ExecutionError) {
        do {
            try controller.performFetch()
            
            logger.info("The fetch action was finished with sucess.")
        } catch {
            logger.error(
                "An error was thrown when the manager was trying to fetch data in persistence storage. Error: \(error.localizedDescription)."
            )
            
            throw .failureInFetchAction
        }
    }
    
    func fetchChanges<M: NSManagedObject>(
        _ controller: NSFetchedResultsController<NSFetchRequestResult>,
        by model: M.Type
    ) -> [M] {
        guard let models = controller.fetchedObjects as? [M] else { return [] }
        
        logger.info(
            "A fetch for changes was finished with sucess. Was founded \(models.count) models saved in the persistence storage."
        )
        
        return models
    }
    
    func fetchedResultController<M: NSFetchRequestResult>(
        for request: NSFetchRequest<M>
    ) -> NSFetchedResultsController<M> {
        NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
    }
    
    private init(inMemory: Bool = false) {
        self.container = NSPersistentContainer(name: "BookModel")
        self.context = self.container.viewContext
        
        guard let description = container.persistentStoreDescriptions.first else {
            logger.error("Failed to retrieve a persistent store description.")
            fatalError()
        }
        
        if inMemory {
            description.url = URL(filePath: "/dev/null")
        }
        
        self.container.loadPersistentStores { [weak self] _, error in
            guard let self else { return }
            
            if let error {
                logger.error("An error was thrown when the manager was trying to fetch data in persistence storage. Error: \(error.localizedDescription)")
            }
        }
        
        self.context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        
        logger.info("A new Storage manager instance was created.")
    }
}

#if DEBUG
extension Storage {
    static var preview: Storage {
        let storage = Storage(inMemory: true)
        
        try? storage.makeChanges { context in
            let author = Author.makePreview(withContext: context)
            let genre = Genre.makePreview(withContext: context)
            
            for _ in 0..<10 {
                let newBook = Book.makePreview(
                    withContext: context,
                    author: author,
                    genre: genre
                )
                
                let newAnnotation = Annotation.makePreview(
                    withContext: context,
                    book: newBook
                )
                
                newBook.addToAnnotations(newAnnotation)
                genre.addToBooks(newBook)
                author.addToBooks(newBook)
            }
        }
        
        return storage
    }
}
#endif
