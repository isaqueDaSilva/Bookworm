//
//  LoginComponent.swift
//  Bookworm
//
//  Created by Isaque da Silva on 22/01/24.
//

import SwiftUI

struct FieldComponent<L: View>: View {
    let label: L
    
    var body: some View {
        label
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 50)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(Color(.systemGray5))
            )
            .padding(.horizontal)
    }
    
    init(_ label: L) {
        self.label = label
    }
}

#Preview {
    LoginView()
}
