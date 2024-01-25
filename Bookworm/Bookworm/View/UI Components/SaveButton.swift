//
//  SaveButton.swift
//  Bookworm
//
//  Created by Isaque da Silva on 21/01/24.
//

import SwiftUI

struct SaveButton: View {
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text("Save")
                .bold()
        }
    }
}

#Preview {
    SaveButton { }
}
