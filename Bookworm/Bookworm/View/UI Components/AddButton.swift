//
//  AddButton.swift
//  Bookworm
//
//  Created by Isaque da Silva on 21/01/24.
//

import SwiftUI

struct AddButton: View {
    let title: String
    let systemImage: String
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Label(title, systemImage: systemImage)
        }
    }
}

#Preview {
    AddButton(title: "Add New Book", systemImage: "plus.circle") { }
}
