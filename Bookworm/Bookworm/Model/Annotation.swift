//
//  Annotation.swift
//  Bookworm
//
//  Created by Isaque da Silva on 29/02/24.
//

import Foundation
import SwiftData

@Model
final class Annotation {
    let id: UUID
    var commentCescription: String
    var lastModification = Date.now
    
    init(id: UUID, commentCescription: String) {
        self.id = id
        self.commentCescription = commentCescription
    }
}

extension Annotation: Hashable { }
