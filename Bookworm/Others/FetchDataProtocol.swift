//
//  FetchDataProtocol.swift
//  Bookworm
//
//  Created by Isaque da Silva on 09/11/23.
//

import Foundation

protocol FetchDataProtocol {
    var books: [Books] { get set }
    func save()
    func fetchBooks()
    func addNewBook(title: String, author: String, releaseDate: Date, genre: String, review: String, rating: Int)
    func delete(_ book: Books)
}
