//
//  CreateNewBookView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 28/02/24.
//

import SwiftUI
import SwiftData

struct BookFormView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: BookFormViewModel
    
    var action: () -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Cover(
                        title: viewModel.title.isEmpty ? "No Title" : viewModel.title,
                        author: viewModel.author?.wrappedName ?? "No Author"
                    )
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .listRowBackground(Color.listLightGray)
                
                Section("More Information") {
                    LabeledContent("Title:") {
                        TextField("Insert the title here...", text: $viewModel.title)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    Button {
                        viewModel.showingAuthorSelectionView = true
                    } label: {
                        LabeledContent("Author") {
                            HStack {
                                Text(viewModel.author?.wrappedName ?? "Select an Author")
                                
                                Icons.chevronRight.systemImage
                            }
                        }
                    }
                    .buttonStyle(.plain)

                    
                    DatePicker(
                        "Release Date:",
                        selection: $viewModel.releaseDate,
                        in: ...Date.now,
                        displayedComponents: .date
                    )
                    
                    Picker("Genre:", selection: $viewModel.genre) {
                        ForEach(Genre.allCases, id: \.id) {
                            Text($0.rawValue)
                        }
                    }
                }
                
                Section("Reading Information") {
                    DatePicker(
                        "Starting of Reading:",
                        selection: $viewModel.startOfReading,
                        in: ...Date.now,
                        displayedComponents: .date
                    )
                    
                    if viewModel.isFinished {
                        DatePicker(
                            "End of Reading:",
                            selection: $viewModel.endOfReading,
                            in: ...Date.now,
                            displayedComponents: .date
                        )
                    }
                    
                    Toggle("Have you finished reading yet?", isOn: $viewModel.isFinished.animation(.easeInOut))
                    
                }
                
                if viewModel.isFinished {
                    Section("Review") {
                        LabeledContent("Rating:") {
                            RatingStars(rating: $viewModel.rating)
                        }
                        
                        TextField("Insert the revire here...", text: $viewModel.review, axis: .vertical)
                    }
                }
            }
            .navigationTitle(viewModel.navTitle)
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $viewModel.showingAuthorSelectionView) {
                AuthorSelectionView(
                    authorSelected: viewModel.author,
                    storage: viewModel.storage
                ) { author in
                    viewModel.author = author
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        HStack {
                            Icons.chevronLeft.systemImage
                            Text("Back")
                        }
                    }

                }
                
                ToolbarItem {
                    Button {
                        viewModel.save()
                        action()
                        dismiss()
                    } label: {
                        Text("Save")
                    }
                }
            }
            .alert(viewModel.errorTitle, isPresented: $viewModel.showingError) {
            } message: {
                Text(viewModel.errorMessage)
            }
        }
    }
    
    init(storage: Storage, book: Book? = nil, action: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: BookFormViewModel(storage: storage, book: book))
        self.action = action
    }
}

#Preview {
    BookFormView(storage: .preview) { }
}

extension Color {
    static var listLightGray = Color(CGColor(red: 246, green: 240, blue: 240, alpha: 0))
}
