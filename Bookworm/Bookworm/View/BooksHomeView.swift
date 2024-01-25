//
//  BooksView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 31/08/23.
//

import SwiftUI

struct BooksHomeView: View {
    var body: some View {
        NavigationStack {
            List(0..<5) { index in
                HStack(alignment: .center) {
                    BookCover(width: 90, height: 120, customText: "B")
                    
                    VStack(alignment: .leading) {
                        Description(title: "Title Test", description: "Author Test", primaryFont: .title2, secondaryFont: .subheadline)
                    }
                    .padding()
                    
                }
            }
            .navigationTitle("Bookworm")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Menu {
                        Text("Text")
                    } label: {
                        Label("Filter by", systemImage: "line.3.horizontal.decrease.circle")
                    }
                }
                
                ToolbarItem {
                    AddButton(
                        title: "Add new Book",
                        systemImage: "plus.circle"
                    ) { }
                }
            }
        }
    }
}

#Preview {
    BooksHomeView()
}

