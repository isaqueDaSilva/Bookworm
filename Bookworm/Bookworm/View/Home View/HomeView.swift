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
    
    @Environment(\.isSearching) var isSearching
    
    @Namespace private var transition
    @Namespace private var transitionDisplayingMode
    @StateObject var viewModel: HomeViewModel
    
    let colums = [GridItem(.adaptive(minimum: 150), spacing: 10, alignment: .top)]
    
    // MARK: - View
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.booksFiltered.isEmpty {
                    ContentUnavailableView(
                        "No Books",
                        systemImage: Icons.bookVertical.rawValue,
                        description: 
                            Text("Tap the + Button to create one.").bold()
                    )
                    .transition(AnyTransition.opacity)
                    .matchedGeometryEffect(id: "transition", in: transition)
                } else {
                    HomeViewPopulated()
                        .matchedGeometryEffect(id: "transition", in: transition)
                }
            }
            .navigationTitle("Bookworm")
            .searchable(text: $viewModel.searchText, prompt: "Search a Book")
            .toolbar {
                HStack {
                    Menu {
                        Picker("Displaying Mode", selection: $displayingMode) {
                            ForEach(DisplayingMode.allCases, id: \.id) {
                                Label($0.rawValue, systemImage: $0.systemImageName)

                            }
                        }
                        .labelsHidden()
                    } label: {
                        Image(systemName: displayingMode.systemImageName)
                            .contentTransition(.interpolate)
                    }
                    
                    Button {
                        viewModel.showingAddNewBook = true
                    } label: {
                        Icons.plusCircle.systemImage
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



#Preview {
    HomeView(storage: Storage.preview)
}
