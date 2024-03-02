//
//  AuthorSelectionView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 29/02/24.
//

import SwiftUI

struct AuthorSelectionView<SelectionValue: Hashable, Content: View>: View {
    private let title: LocalizedStringKey
    private let selection: Binding<SelectionValue>
    private let content: Content
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    init(
        _ title: LocalizedStringKey,
        selection: Binding<SelectionValue>,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.selection = selection
        self.content = content()
    }
}

//#Preview {
//    AuthorSelectionView()
//}
