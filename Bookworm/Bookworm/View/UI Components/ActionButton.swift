//
//  ActionButton.swift
//  Bookworm
//
//  Created by Isaque da Silva on 22/01/24.
//

import SwiftUI

struct ActionButton: View {
    let title: String
    var action: () -> Void
    
    var body: some View {
        Button {
            
        } label: {
            Text(title)
                .font(.headline)
                .foregroundStyle(.white)
                .padding()
                .frame(maxWidth: .infinity, maxHeight: 50)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.blue)
                )
                .padding([.top, .horizontal])
        }
    }
}

#Preview {
    ActionButton(title: "Login") { }
}
