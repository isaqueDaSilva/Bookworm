//
//  BooksView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 27/02/24.
//

import SwiftUI

struct HomeView: View {
    // MARK: - View Properties
    @AppStorage("displaying_mode") var displayingMode: DisplayingMode = .icons
    
    @Namespace private var transition
    @Namespace private var transitionDisplayingMode
    @StateObject private var viewModel: HomeViewModel
    let colums = [GridItem(.adaptive(minimum: 150), spacing: 10, alignment: .top)]
    
    // MARK: - View
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.books.isEmpty {
                    ContentUnavailableView(
                        "No Books Saved",
                        systemImage: Icons.bookVertical.rawValue,
                        description: 
                            Text("Tap the + Button to create one.").bold()
                    )
                    .transition(AnyTransition.opacity)
                    .matchedGeometryEffect(id: "transition", in: transition)
                } else {
                    BookListView()
                        .matchedGeometryEffect(id: "transition", in: transition)
                }
            }
            .navigationTitle("Bookworm")
            .toolbar {
                HStack {
                    Button {
                        viewModel.showingAddNewBook = true
                    } label: {
                        Icons.plusCircle.systemImage
                    }
                    
                    Menu {
                        Picker("", selection: $displayingMode) {
                            ForEach(DisplayingMode.allCases, id: \.id) {
                                Label($0.rawValue, systemImage: $0.systemImageName)

                            }
                        }
                    } label: {
                        Icons.line3.systemImage
                    }

                }
            }
            .navigationDestination(for: Book.self) { book in
                BookDetailView(storage: viewModel.storage, book: book)
            }
            .sheet(isPresented: $viewModel.showingAddNewBook) {
                BookFormView(storage: viewModel.storage)
            }
            .alert(viewModel.alertTitle, isPresented: $viewModel.showingAlert) {
            } message: {
                Text(viewModel.alertMessage)
            }
            
        }
    }
    
    init(storage: Storage) {
        _viewModel = StateObject(wrappedValue: HomeViewModel(storage: storage))
    }
}

// MARK: - View Populated State

extension HomeView {
    @ViewBuilder
    private func BookListView() -> some View {
        Group {
            switch displayingMode {
            case .icons:
                GridHomeView()
            case .list:
                ListHomeView()
            }
        }
    }
}

// MARK: - List Home View

extension HomeView {
    @ViewBuilder
    func ListHomeView() -> some View {
        List(viewModel.books) { book in
            NavigationLink(value: book) {
                Cover(
                    coverImage: book.coverImage,
                    title: book.wrappedTitle,
                    width: 75,
                    height: 100
                )
                VStack(alignment: .leading) {
                   Description(
                    title: book.wrappedTitle,
                    author: book.wrappedAuthorName
                   )
                }
            }
            .swipeActions {
                DeleteBook(book, titleHidden: false)
            }
        }
        .listStyle(.plain)
    }
}

// MARK: - Grid Home View

extension HomeView {
    @ViewBuilder
    func GridHomeView() -> some View {
        ScrollView {
            LazyVGrid(columns: colums, spacing: 20) {
                ForEach(viewModel.books) { book in
                    NavigationLink(value: book) {
                        VStack(alignment: .leading) {
                            Cover(
                                coverImage: book.coverImage,
                                title: book.wrappedTitle
                            )
                            .shadow(color: .black.opacity(0.15), radius: 5, x: 5, y: 5)
                            .shadow(color: .black.opacity(0.15), radius: 5, x: -5, y: -5)
                            .contextMenu {
                                DeleteBook(book, titleHidden: true)
                            }
                            
                            Description(
                                title: book.wrappedTitle,
                                author: book.wrappedAuthorName
                            )
                            .disabled(true)
                        }
                    }
                    .navigationStackButtonStyle()
                }
            }
        }
    }
}

// MARK: - Delete Book Button

extension HomeView {
    @ViewBuilder
    func DeleteBook(_ book: Book, titleHidden: Bool) -> some View {
        Button(role: .destructive) {
            withAnimation(.spring.delay(0.65)) {
                viewModel.deleteBook(book)
            }
        } label: {
            Label(
                titleHidden ? "Delete Book" : "",
                systemImage: Icons.trash.rawValue
            )
                
        }
    }
}

#Preview {
    HomeView(storage: Storage.preview)
}
