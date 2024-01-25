//
//  DeleteButton.swift
//  Bookworm
//
//  Created by Isaque da Silva on 21/01/24.
//

import SwiftUI

struct DestructiveButton: View {
    let label: String
    var action: () -> Void
    
    var body: some View {
        Button(label, role: .destructive) {
            action()
        }
    }
}

#Preview {
    DestructiveButton(label: "Label Test") { }
}
