//
//  ContentView-ViewModel.swift
//  Bookworm
//
//  Created by Isaque da Silva on 24/08/23.
//

import Foundation

extension ContentView {
    class ContentViewViewModel: ObservableObject {
        @Published var showingAddBookView = false
    }
}
