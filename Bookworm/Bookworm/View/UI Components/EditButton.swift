//
//  EditButton.swift
//  Bookworm
//
//  Created by Isaque da Silva on 21/01/24.
//

import SwiftUI

struct EditButton: View {
    let label: String
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(label)
        }
    }
}

#Preview {
    EditButton(label: "Label Test") { }
}
