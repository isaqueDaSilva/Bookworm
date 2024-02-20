//
//  Result+AuthorResult+Extension.swift
//  Bookworm
//
//  Created by Isaque da Silva on 17/02/24.
//

import Foundation

extension Result.AuthorResult {
    func convertResultInAuthor() -> Author {
        Author(from: self)
    }
}

extension Collection where Element == Result.AuthorResult {
    func convertResultCollectionInAuthors() -> [Author] {
        self.map { author in
            author.convertResultInAuthor()
        }
    }
}
