//
//  Comments.swift
//  Bookworm
//
//  Created by Isaque da Silva on 29/02/24.
//

import Foundation
import SwiftData

@Model
final class Note {
    let id: UUID
    var commentCescription: String
    var creation = Date.now
    
    init(id: UUID, commentCescription: String, creation: Date = Date.now) {
        self.id = id
        self.commentCescription = commentCescription
        self.creation = creation
    }
}

extension Note: Hashable { }
