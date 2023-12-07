//
//  DataServiceProtocol.swift
//  Bookworm
//
//  Created by Isaque da Silva on 02/12/23.
//

import Foundation

protocol DataServiceProtocol {
    func getBooks() async -> Published<[Book]>.Publisher
    func addNewBook(title: String, authorName: String, releaseDate: Date, genre: String, review: String, rating: Int) async
    func delete(_ book: Book) async
}
