//
//  HeaderText.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/4/25.
//

import SwiftUI

struct HeaderText: View {
    let header: String
    
    var body: some View {
        Text(header)
            .font(.headline)
            .fontDesign(.rounded)
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    HeaderText(header: "Bookworm")
}
