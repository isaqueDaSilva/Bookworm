//
//  EditButton.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/4/25.
//

import SwiftUI

struct EditButton: View {
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Label("Edit", systemImage: Icons.pencil.rawValue)
        }
    }
}

#Preview {
    EditButton { }
}
