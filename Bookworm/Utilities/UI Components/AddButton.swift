//
//  AddButton.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/2/25.
//

import SwiftUI

struct AddButton: View {
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Icons.plusCircle.systemImage
        }
    }
}

#Preview {
    AddButton { }
}
