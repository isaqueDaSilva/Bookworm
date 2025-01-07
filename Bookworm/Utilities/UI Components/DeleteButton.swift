//
//  DeleteButton.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/4/25.
//

import SwiftUI

struct DeleteButton: View {
    private let isShownLabel: Bool
    private var target: String
    private var action: () -> Void
    
    var body: some View {
        Button(role: .destructive) {
            action()
        } label: {
            Label(
                isShownLabel ? target : "",
                systemImage: Icons.trash.rawValue
            )
        }
    }
    
    init(action: @escaping () -> Void) {
        self.isShownLabel = false
        self.target = ""
        self.action = action
    }
    
    init(
        isShownLabel: Bool = true,
        target: String,
        action: @escaping () -> Void
    ) {
        self.isShownLabel = isShownLabel
        self.target = "Delete \(target)"
        self.action = action
    }
}

#Preview {
    DeleteButton(target: "Book") { }
    
    DeleteButton { }
}
