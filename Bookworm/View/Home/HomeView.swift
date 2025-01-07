//
//  HomeView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/2/25.
//

import ErrorWrapper
import SwiftUI

struct HomeView: View {
    // MARK: - View Properties
    @AppStorage("displaying_mode") var displayingMode: DisplayingMode = .grid
    
    @Namespace private var transition
    
    @State private var viewModel: ViewModel
    
    // MARK: - View
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.booksFiltered.isEmpty {
                    NoBooksAvailableView(searchText: viewModel.searchText)
                        .matchedGeometryEffect(id: "transition", in: transition)
                } else {
                    HomeViewPopulatedState(displayingMode: $displayingMode)
                        .matchedGeometryEffect(id: "transition", in: transition)
                        .environment(viewModel)
                }
            }
            .navigationTitle("Books")
            .searchable(text: $viewModel.searchText, prompt: "Search a Book")
            .toolbar {
                HStack {
                    HomeMenu(displayingMode: $displayingMode)
                    
                    AddButton {
                        viewModel.openAddNewBookView()
                    }
                }
            }
            .navigationDestination(for: Book.self) { book in
                BookDetailView(book: book)
            }
            .sheet(isPresented: $viewModel.showingAddNewBook) {
                NewBookView()
            }
            .errorAlert(error: $viewModel.error) { }
            
        }
    }
    
    init(storage: Storage = .shared) {
        _viewModel = State(initialValue: .init(storage: storage))
    }
}



#Preview {
    HomeView(storage: .preview)
}
