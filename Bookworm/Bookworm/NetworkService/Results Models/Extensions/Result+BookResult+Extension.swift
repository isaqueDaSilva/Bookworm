//
//  Result+BookResult+Extension.swift
//  Bookworm
//
//  Created by Isaque da Silva on 17/02/24.
//

import Foundation

extension Result.BookResult {
    func convertResultInBook() -> Book {
        Book(from: self)
    }
}

extension Collection where Element == Result.BookResult {
    func convertResultCollectionInBooks() -> [Book] {
        self.map { author in
            author.convertResultInBook()
        }
    }
}
