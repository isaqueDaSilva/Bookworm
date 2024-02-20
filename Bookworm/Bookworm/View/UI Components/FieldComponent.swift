//
//  LoginComponent.swift
//  Bookworm
//
//  Created by Isaque da Silva on 22/01/24.
//

import SwiftUI

struct FieldComponent<L: View>: View {
    @Environment(\.colorScheme) var colorScheme
    let label: L
    
    var body: some View {
        label
            .textFieldStyle(.roundedBorder)
            .border(.secondary)
            .clipShape(RoundedRectangle(cornerRadius: 2))
    }
    
    init(_ label: L) {
        self.label = label
    }
}
