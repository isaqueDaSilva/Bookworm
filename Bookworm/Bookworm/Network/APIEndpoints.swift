//
//  APIEndpoints.swift
//  Bookworm
//
//  Created by Isaque da Silva on 23/02/24.
//

import Foundation

enum APIEndpoints: String {
    // User endpoints
    case login = "http://127.0.0.1:8080/user/login"
    case getUser = "http://127.0.0.1:8080/user/profile"
    case createUser = "http://127.0.0.1:8080/user/create"
    case updateUser = "http://127.0.0.1:8080/user/update"
    case deleteUser = "http://127.0.0.1:8080/user/delete"
    case logout = "http://127.0.0.1:8080/user/logout"
    
    // Author enpoints
    case createAuthor = "http://127.0.0.1:8080/author/create"
    case getAuthor = "http://127.0.0.1:8080/author/"
    case getAllAuthors = "http://127.0.0.1:8080/author/all"
    case updateAuthor = "http://127.0.0.1:8080/author/update/"
    case deleteAuthor = "http://127.0.0.1:8080/author/delete/"
    
    // Book endpint
    case createBook = "http://127.0.0.1:8080/book/create"
    case getBook = "http://127.0.0.1:8080/book/"
    case getAllBooks = "http://127.0.0.1:8080/book/all"
    case updateBook = "http://127.0.0.1:8080/book/update/"
    case deleteBook = "http://127.0.0.1:8080/book/delete/"
}
