//
//  NewAnnotationView+ViewModel.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/4/25.
//

import CoreData
import ErrorWrapper
import Foundation
import Observation
import os.log

extension NewAnnotationView {
    @Observable
    @MainActor
    final class ViewModel {
        @ObservationIgnored
        private let storage = Storage.shared
        
        @ObservationIgnored
        private let logger = Logger(
            subsystem: "com.isaqueDaSilva.Bookworm",
            category: "NewAnnotationView+ViewModel"
        )
        
        var title: String = ""
        var commentDescription = ""
        var error: ExecutionError?
        
        func createAnnotation(withBook book: Book) {
            do {
                try storage.makeChanges { [weak self] context in
                    guard let self else { return }
                    let newAnnotation = Annotation(
                        context: context,
                        title: self.title,
                        commentDescription: self.commentDescription,
                        book: book
                    )
                    
                    context.insert(newAnnotation)
                    
                    logger.info(
                        "A new annotation with name: \(newAnnotation.wrappedTitle) instace was created with success."
                    )
                }
            } catch {
                self.error = error
            }
        }
    }
}
