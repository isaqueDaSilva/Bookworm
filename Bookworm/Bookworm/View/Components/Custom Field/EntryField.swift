//
//  EntryField.swift
//  Bookworm
//
//  Created by Isaque da Silva on 25/02/24.
//

import SwiftUI


struct EntryField<L: View, C: View, A: View>: View {
    @Environment(\.entryFieldStyle) var style
    
    let label: L
    let content: C
    let leadingAccessoryView: A
    var body: some View {
        AnyView(
            style.makeBody(
                .init(
                    label: .init(underlyingView: AnyView(label)),
                    content: .init(underlyingView: AnyView(content)),
                    leadingAccessoryView: .init(underlyingView: AnyView(leadingAccessoryView))
                )
            )
        )
    }
}

struct EntryFieldView: View {
    @State private var value = ""
    var body: some View {
        EntryField(
            label: Text("Email"),
            content: TextField("Email", text: $value),
            leadingAccessoryView: Image(systemName: "person")
        )
        .padding(.horizontal)
    }
}

#Preview {
    EntryFieldView()
}
