//
//  EditAnnotationView+ViewModel.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/4/25.
//

import ErrorWrapper
import Foundation
import Observation
import os.log

extension EditAnnotationView {
    @Observable
    @MainActor
    final class ViewModel {
        @ObservationIgnored
        private let logger = Logger(
            subsystem: "com.isaqueDaSilva.Bookworm",
            category: "EditAnnotationView+ViewModel"
        )
        
        let annotation: Annotation
        
        var title: String
        var commentDescription: String
        var error: ExecutionError?
        
        func saveChanges(_ completation: @escaping () -> Void) {
            let isTitleChanged = annotation.wrappedTitle != title
            let isCommentDescriptionChanged = annotation.wrappedCommentDescription != commentDescription
            
            if isTitleChanged {
                annotation.title = title
                
                logger.info("The title was change for \(self.title) with success")
            }
            
            if isCommentDescriptionChanged {
                annotation.commentDescription = commentDescription
                
                logger.info(
                    "The comment description was change for \(self.commentDescription) with success"
                )
            }
            
            if isTitleChanged || isCommentDescriptionChanged {
                let now = Date.now
                
                annotation.lastModification = now
                
                logger.info(
                    "The last modification was change for \(now) with success"
                )
            }
            
            if let context = annotation.managedObjectContext {
                do {
                    try context.save()
                    
                    logger.info(
                        "All modifications was saved with success."
                    )
                    
                    completation()
                } catch {
                    logger.error(
                        "Don't possible to save the modifications for \(self.annotation.wrappedTitle). Error: \(error.localizedDescription)"
                    )
                    
                    self.error = .failureInSaveAction
                }
            } else {
                logger.error(
                    "Don't possible to save modification, because the instance dpn't have any NSManageObjectContext instance."
                )
                self.error = .unknownError
            }
        }
        
        init(annotation: Annotation) {
            self.annotation = annotation
            self.title = annotation.wrappedTitle
            self.commentDescription = annotation.wrappedCommentDescription
        }
    }
}
