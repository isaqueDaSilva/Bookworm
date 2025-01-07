//
//  NoBooksAvailableView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/2/25.
//


import SwiftUI

extension HomeView {
    struct NoBooksAvailableView: View {
        let searchText: String
        
        var body: some View {
            ContentUnavailableView(
                "No Books",
                systemImage: Icons.bookVertical.rawValue,
                description:
                    Text(
                        searchText.isEmpty ?
                        "Tap the + Button to create one." : "No book's title corresponding to the '\(searchText)'"
                    )
                    .bold()
            )
        }
    }
}