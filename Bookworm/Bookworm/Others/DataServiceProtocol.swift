//
//  DataServiceProtocol.swift
//  Bookworm
//
//  Created by Isaque da Silva on 02/12/23.
//

import Foundation

protocol DataServiceProtocol {
    func getBooks() async -> [Book]
    func addNewBook(title: String, authorName: String, releaseDate: Date, genre: String, review: String, rating: Int) async
    func deleteBook(_ book: Book) async
}
