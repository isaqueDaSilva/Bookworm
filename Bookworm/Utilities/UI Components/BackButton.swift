//
//  BackButton.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/4/25.
//

import SwiftUI

struct BackButton: View {
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Icons.chevronLeft.systemImage
                Text("Back")
            }
        }
    }
}

#Preview {
    BackButton { }
}
