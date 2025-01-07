//
//  SaveButton.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/4/25.
//

import SwiftUI

struct SaveButton: View {
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text("Save")
        }
    }
}

#Preview {
    SaveButton { }
}
