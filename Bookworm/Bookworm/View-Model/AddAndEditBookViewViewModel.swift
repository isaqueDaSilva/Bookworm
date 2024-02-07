//
//  AddNewBookViewModel.swift
//  Bookworm
//
//  Created by Isaque da Silva on 31/08/23.
//

import Foundation

extension AddNewBookView {
    final class AddNewBookViewModel: ObservableObject {
        let authenticationManager: AuthenticationManager
        private var author: UUID
        
        var authorName = ""
        
        @Published var title = ""
        @Published var releaseDate = Date.now
        @Published var genre: Genre = .fantasy
        @Published var review = ""
        @Published var rating = 1
        @Published var showingAlert = false
        
        func createNewBook() async throws -> Book {
            let newBook = Book.CreateBook(
                title: title,
                author: author,
                releaseDate: Date().convertDateToString(date: releaseDate),
                genre: genre.rawValue,
                review: review,
                rating: rating
            )
            
            let endpoint = "http://127.0.0.1:8080/book/create"
            
            guard let url = URL(string: endpoint) else {
                throw NetworkError.invalidURL
            }
            
            guard let token = authenticationManager.token else {
                throw LoginError.noTokenAvailable
            }
                    
            var request = URLRequest(url: url)
            request.addValue("Bearer \(token.value)", forHTTPHeaderField: "Authorization")
            request.httpMethod = HTTPMethod.post.rawValue
            
            let bookEncoded = try JSONEncoder().encode(newBook)
            
            let (data, response) = try await URLSession.shared.upload(for: request, from: bookEncoded)
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw NetworkError.invalidResponse
            }
            
            return try JSONDecoder().decode(Book.self, from: data)
        }
        
        func getAuthorName() async throws {
            let endpoint = "http://127.0.0.1:8080/author/\(author)"
            
            guard let url = URL(string: endpoint) else {
                throw NetworkError.invalidURL
            }
            
            guard let token = authenticationManager.token else {
                throw LoginError.noTokenAvailable
            }
                    
            var request = URLRequest(url: url)
            request.addValue("Bearer \(token.value)", forHTTPHeaderField: "Authorization")
            request.httpMethod = HTTPMethod.post.rawValue
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw NetworkError.invalidResponse
            }
            
            let authorDecoded = try JSONDecoder().decode(Author.self, from: data)
            
            self.authorName = authorDecoded.authorName
        }
        
        init(authenticationManager: AuthenticationManager, author: UUID) {
            self.authenticationManager = authenticationManager
            self.author = author
            
            Task {
                do {
                    try await self.getAuthorName()
                } catch {
                    self.authorName = "An error occurred when searching for the author"
                }
            }
        }
        
        init(authenticationManager: AuthenticationManager, author: UUID, book: Book) {
            self.authenticationManager = authenticationManager
            self.author = author
            
            _title = Published(initialValue: book.title)
            _releaseDate = Published(initialValue: String().convertStringToDate(book.releaseDate))
            _genre = Published(initialValue: Genre(rawValue: book.genre) ?? .fantasy)
            _review = Published(initialValue: book.review)
            _rating = Published(initialValue: book.rating)
            
            Task {
                do {
                    try await self.getAuthorName()
                } catch {
                    self.authorName = "An error occurred when searching for the author"
                }
            }
        }
    }
}
